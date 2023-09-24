#include "player.h"
#include "worker.h"

Player::Player(QObject *parent)
    : QObject(parent)
    , m_player(new QMediaPlayer(this))
    , m_playlistModel(new PlaylistModel(this))
    , m_playlist(new QMediaPlaylist(this))
    , m_singleTrackModel(new PlaylistModel(this))
    , m_singleTrackPlaylist(new QMediaPlaylist(this))
    , m_settings(
          new QSettings(QDir::homePath() + "/.config/ice/player.ini", QSettings::IniFormat, this))
    , m_api(new API(this))
{
    // 读取音量配置
    m_volume = m_settings->value("Volume/DefaultVolume", 50).toInt();
    // 读取静音配置
    m_mute = m_settings->value("Volume/Mute", false).toBool();
    // 读取播放模式配置 把第一种播放模式去除，只要后面三种
    int playbackMode = m_settings->value("Playback/PlaybackMode", 3).toInt();
    switchPlaybackMode(playbackMode);

    m_currentModel = m_singleTrackModel;
    m_currentPlaylist = m_singleTrackPlaylist;
    m_player->setPlaylist(m_currentPlaylist);

    m_singleTrackPlaylist->setPlaybackMode(m_playbackMode);
    m_playlist->setPlaybackMode(m_playbackMode);

    // 设置音量
    m_player->setVolume(m_volume);
    // 连接信号槽
    connect(m_player, &QMediaPlayer::positionChanged, this, &Player::onPositionChanged);
    connect(m_player, &QMediaPlayer::durationChanged, this, &Player::onDurationChanged);
    /*******************************/
    connect(m_playlist, &QMediaPlaylist::currentIndexChanged, this, &Player::onCurrentIndexChanged);
    connect(m_playlist, &QMediaPlaylist::mediaInserted, this, &Player::onMediaCountChanged);
    connect(m_playlist, &QMediaPlaylist::mediaRemoved, this, &Player::onMediaCountChanged);
    connect(m_singleTrackPlaylist,
            &QMediaPlaylist::currentIndexChanged,
            this,
            &Player::onCurrentIndexChanged);
    connect(m_singleTrackPlaylist,
            &QMediaPlaylist::mediaInserted,
            this,
            &Player::onMediaCountChanged);
    connect(m_singleTrackPlaylist,
            &QMediaPlaylist::mediaRemoved,
            this,
            &Player::onMediaCountChanged);

    connect(m_player,
            QOverload<QMediaPlayer::Error>::of(&QMediaPlayer::error),
            [=](QMediaPlayer::Error error) {
                m_currentPlaylist->blockSignals(true);
                qDebug() << "播放器错误: " << error;
                int currentIndex = m_currentPlaylist->currentIndex() - 1;
                m_currentPlaylist->clear();
                m_currentPlaylist->blockSignals(false);
                stop();
                m_api->getSongUrl(m_currentModel->getAllId());
                connect(m_api, &API::songUrlCompleted, [&](QJsonArray response) {
                    qDebug() << "获取到的数组大小: " << response.size();
                    // 定义一个数组，存放歌曲url
                    QStringList urls;
                    for (int i = 0; i < response.size(); ++i) {
                        QJsonObject item = response[i].toObject();
                        QString url = item["url"].toString();
                        urls.append(url);
                    }
                    qDebug() << "歌曲url获取完成, 歌曲数量:" << urls.size();
                    m_currentPlaylist->blockSignals(true);
                    for (int i = 0; i < urls.size(); ++i) {
                        m_currentPlaylist->addMedia(QUrl(urls[i]));
                    }
                    m_currentPlaylist->blockSignals(false);
                    onMediaCountChanged(0, 0);
                    qDebug() << "播放列表添加完成";
                    qDebug() << "播放列表大小:" << m_currentPlaylist->mediaCount();
                    play(currentIndex);
                });
            });

    connect(m_playlist, &QMediaPlaylist::loadFailed, [=]() {
        qDebug() << "播放列表加载失败";
        stop();
    });
}

/**
 * 添加单曲到播放列表
 * 会自动播放最新添加的歌曲
 *
 * @param url 歌曲的url
 * @param id 歌曲的id
 * @param name 歌曲的名字
 * @param pic 歌曲的图片（URL）
 * @param artist 歌曲的作者
 * @param duration 歌曲的时长（格式化成'00:00'的字符串）
 * @param isVip 歌曲是否为VIP歌曲
 *
 */
void Player::addSignleToPlaylist(const QString &url,
                                 const QString &id,
                                 const QString &name,
                                 const QString &pic,
                                 const QString &artist,
                                 const QString &duration,
                                 const QString &album,
                                 const bool &isVip)
{
    // 判断添加的歌曲是否已经在播放列表中
    int index = m_currentModel->indexOfId(id);
    if (index != -1) {
        m_currentPlaylist->moveMedia(index, m_currentPlaylist->mediaCount() - 1);
    } else {
        m_singleTrackPlaylist->addMedia(QUrl(url));
        m_singleTrackModel->addSong(id, name, pic, artist, duration, album, isVip);
    }
    if (m_currentModel != m_singleTrackModel) {
        switchToSingleTrackMode();
    }
    play(m_currentPlaylist->mediaCount() - 1);
}

/**
 * 添加歌单歌曲到播放列表
 * 添加后需要由用户受到调用play(index)的方法，播放歌曲
 *
 * @param url 歌曲的url
 * @param id 歌曲的id
 * @param name 歌曲的名字
 * @param pic 歌曲的图片（URL）
 * @param artist 歌曲的作者
 * @param duration 歌曲的时长（格式化成'00:00'的字符串）
 * @param isVip 歌曲是否为VIP歌曲
 *
 */
void Player::addPlaylistToPlaylist(const QString &url,
                                   const QString &id,
                                   const QString &name,
                                   const QString &pic,
                                   const QString &artist,
                                   const QString &duration,
                                   const QString &album,
                                   const bool &isVip)
{
    int index = m_currentModel->indexOfId(id);
    if (index != -1) {
        m_currentPlaylist->moveMedia(index, m_currentPlaylist->mediaCount() - 1);
    }else {
        m_playlist->addMedia(QUrl(url));
        m_playlistModel->addSong(id, name, pic, artist, duration, album, isVip);
    }
    if (m_currentModel != m_playlistModel) {
        switchToPlaylistMode();
    }
}

/**
 * 切换到单曲的播放列表
 *
 * @param None
 *
 * @return None
 *
 */
void Player::switchToSingleTrackMode()
{
    m_currentPlaylist = m_singleTrackPlaylist;
    m_currentModel = m_singleTrackModel;
    m_player->setPlaylist(m_currentPlaylist);
    // 切换到当前播放列表需要把另一个播放列表清空
    m_playlist->clear();
    m_playlistModel->clear();
}

/**
 * 切换到歌单的播放列表
 * 
 * @param None
 *
 * @return None
 *
 */
void Player::switchToPlaylistMode()
{
    m_currentPlaylist = m_playlist;
    m_currentModel = m_playlistModel;
    m_player->setPlaylist(m_currentPlaylist);
    // 切换到当前播放列表需要把另一个播放列表清空
    m_singleTrackPlaylist->clear();
    m_singleTrackModel->clear();
}

/************* Controller *****************/
/**
 * 如果媒体有效，则播放该媒体，并发出指示播放状态变化的信号。
 */
void Player::play()
{
    QMediaPlayer::MediaStatus status = m_player->mediaStatus();
    if (status == QMediaPlayer::UnknownMediaStatus) {
        qDebug() << "媒体状态未知";
        return;
    }
    if (status == QMediaPlayer::InvalidMedia) {
        qDebug() << "媒体无效";
        return;
    }
    m_player->play();
    m_playState = true;
    emit playStateChanged();
}

/**
 * 播放播放列表中指定索引处的媒体文件.
 *
 * @param index 播放列表中的索引
 *
 * @return void
 * 
 */
void Player::play(int index)
{
    QMediaPlayer::MediaStatus status = m_player->mediaStatus();
    if (status == QMediaPlayer::UnknownMediaStatus || status == QMediaPlayer::EndOfMedia
        || status == QMediaPlayer::InvalidMedia)
        return;
    m_currentPlaylist->setCurrentIndex(index);
    play();
    m_playState = true;
    emit playStateChanged();
}

/**
 * 暂停播放
 */
void Player::pause()
{
    m_player->pause();
    m_playState = false;
    emit playStateChanged();
}

/**
 * 停止播放
 */
void Player::stop()
{
    m_player->stop();
    m_playState = false;
    emit playStateChanged();
}

/**
 * 暂停播放，切换到播放列表中的下一首歌曲，
 * 然后继续播放。
 */
void Player::next()
{
    pause();
    m_currentPlaylist->next();
    qDebug() << "切换下一首：" << m_currentPlaylist->currentIndex();
    play();
}

/**
 * 暂停播放，切换到播放列表中的上一首歌曲，
 * 然后继续播放。
 */
void Player::previous()
{
    pause();
    m_currentPlaylist->previous();
    qDebug() << "切换上一首：" << m_currentPlaylist->currentIndex();
    play();
}

/*************** Slots ********************/
/**
 * player的播放进度发生变化时触发
 *
 * @param new_position 新的播放进度
 *
 */
void Player::onPositionChanged(qint64 new_position)
{
    m_position = new_position;
    emit positionChanged();
}

/**
 * player的媒体总时长发生变化时触发，也就是歌曲切换时会触发
 *
 * @param duration 媒体总时长
 *
 */
void Player::onDurationChanged(qint64 duration)
{
    m_duration = duration;
    emit durationChanged();
}

/**
 * 当播放列表的currentIndex变化时触发
 *
 * @param index 新的currentIndex
 *
 * @return void
 * 
 */
void Player::onCurrentIndexChanged(int index)
{
    // 判断当前播放歌曲的url是不是为空，
    // 无版权的歌曲获取到的url是空的，
    // 这时切换下一首
    if (m_currentPlaylist->currentMedia().request().url().toString().isEmpty()) {
        qDebug() << "当前歌曲无版权，切换下一首";
        next();
        return;
    }
    qDebug() << "playlist current index changed signal : " << index;
    if (index == -1) {
        m_currentPlaylist->setCurrentIndex(0);
    }
    emit playlistCurrentIndexChanged();
}

/**
 * 当播放列表中的歌曲数量发生变化时触发（插入或者删除)
 *
 * @param start 媒体计数的起始索引发生变化
 * @param end 媒体计数变化结束索引
 *
 */
void Player::onMediaCountChanged(int start, int end)
{
    emit mediaCountChanged(m_currentPlaylist->mediaCount());
}

/**************** Set ********************/

/**
 * 设置播放器的音量
 *
 * @param volume 音量大小
 */
void Player::setVolume(int volume)
{
    m_volume = volume;
    m_player->setVolume(m_volume);
    m_settings->setValue("Volume/DefaultVolume", m_volume);
}

/**
 * 设置播放器的静音状态
 *
 * @param mute 静音状态 true 为静音，false 为非静音
 */
void Player::setMute(bool mute)
{
    m_mute = mute;
    m_player->setMuted(m_mute);
    m_settings->setValue("Volume/Mute", m_mute);
}

/**
 * 设置播放器的播放模式
 *
 * @param mode 播放模式
 *
 * @return void
 *
 */
void Player::setPlaybackMode(int mode)
{
    switchPlaybackMode(mode);
    m_currentPlaylist->setPlaybackMode(m_playbackMode);
    m_settings->setValue("Playback/PlaybackMode", mode);
}

/**
 * 设置当前播放列表的ID
 *
 * @param id 播放列表的ID
 */
void Player::setCurrentPlaylistId(const QString &id)
{
    m_currentPlaylistId = id;
}

/**
 * 设置播放器的位置
 *
 * @param newPosition the new position to set
 */
void Player::setPosition(qint64 newPosition)
{
    m_player->setPosition(newPosition);
}

/**************** Get ********************/

/**
 * 获取当前播放音乐的ID
 *
 * @return 当前播放音乐的ID
 */
QString Player::getId()
{
    if (m_currentPlaylist->mediaCount() != 0)
        return m_currentModel->getId(m_currentPlaylist->currentIndex());

    return "";
}

/**
 * 获取当前播放音乐的名字 
 * 
 * @return 当前播放音乐的名字 
 */
QString Player::getName()
{
    if (m_currentPlaylist->mediaCount() != 0) {
        qDebug() << m_currentModel->getTitle(m_currentPlaylist->currentIndex());
        return m_currentModel->getTitle(m_currentPlaylist->currentIndex());
    }

    return "";
}

/**
 * 获取当前播放音乐的作者
 *
 * @return 当前播放音乐的作者
 */
QString Player::getArtist()
{
    if (m_currentPlaylist->mediaCount() != 0)
        return m_currentModel->getAuthor(m_currentPlaylist->currentIndex());

    return "";
}

/**
 * 获取当前播放音乐的图片URL
 *
 * @return 当前播放音乐的图片URL
 */
QString Player::getPic()
{
    if (m_currentPlaylist->mediaCount() != 0)
        return m_currentModel->getImageUrl(m_currentPlaylist->currentIndex());

    return "qrc:/dsg/img/no_music.svg";
}

/**
 * 获取当前播放器的状态
 *
 * @return 当前播放器的状态
 */
bool Player::getPlayState()
{
    return m_playState;
}

/**
 * 获取当前播放歌曲的时长
 *
 * @return 当前播放歌曲的时长
 */
qint64 Player::getDuration()
{
    return m_duration;
}

/**
 * 获取当前播放歌曲的进度
 * 
 * @return 当前播放歌曲的进度
 */
qint64 Player::getPosition()
{
    return m_position;
}

QString Player::getAlbum()
{
    if (m_currentPlaylist->mediaCount() != 0)
        return m_currentModel->getAlbum(m_currentPlaylist->currentIndex());
    return QString();
}

bool Player::getIsVip()
{
    if (m_currentPlaylist->mediaCount() != 0)
        return m_currentModel->getIsVip(m_currentPlaylist->currentIndex());

    return false;
}

/**
 * 获取播放器的音量
 * 
 * @return 播放器的音量
 */
int Player::getVolume()
{
    return m_volume;
}

/**
 * 获取播放器是否静音
 *
 * @return 播放器的静音状态
 */
bool Player::getMute()
{
    return m_mute;
}

/**
 * 获取播放器的播放模式
 *
 * @return 播放器的播放模式
 */
int Player::getPlaybackMode()
{
    return m_playbackMode;
}

/**
 * 获取当前播放歌曲在播放列表中的下标
 *
 * @return 当前播放歌曲在播放列表中的下标
 */
int Player::getCurrentIndex()
{
    qDebug() << "调用，当前播放歌曲的下标：" << m_currentPlaylist->currentIndex();
    return m_currentPlaylist->currentIndex();
}

/**
 * 获取播放列表模型
 * 是qml中Playlist的数据来源
 *
 * @return 播放列表模型
 */
QObject *Player::getPlaylistModel()
{
    return m_currentModel;
}

/**
 * 获取格式化的歌曲时长
 *
 * @return 格式化的歌曲时长
 */
QString Player::getFormatDuration()
{
    QTime time = QTime::fromMSecsSinceStartOfDay(m_duration);
    return time.toString("m:ss");
}

/**
 * 获取格式化的歌曲播放位置
 *
 * @return 格式化的歌曲播放位置
 */
QString Player::getFormatPosition()
{
    QTime time = QTime::fromMSecsSinceStartOfDay(m_position);
    return time.toString("m:ss");
}

/**
 * 获取当前播放列表的媒体数量
 *
 * @return 当前播放列表的媒体数量
 */
int Player::getMediaCount()
{
    return m_currentPlaylist->mediaCount();
}

/**
 * 获取当前播放列表的ID
 *
 * @return 当前播放列表的ID
 */
QString Player::getCurrentPlaylistId()
{
    return m_currentPlaylistId;
}

/**************** Util ********************/

/**
 * 通过停止播放器，重置位置和持续时间，清除播放列表和播放列表模型来清除播放列表。
 *
 */
void Player::clearPlaylist()
{
    stop();

    m_position = 0;
    m_duration = 0;

    m_currentPlaylist->clear();
    m_currentModel->clear();

    emit playlistCleared();
}

/**
 * 切换播放模式
 *
 * @param model 播放模式对应的数字
 *
 * @return void
 */
void Player::switchPlaybackMode(int model)
{
    switch (model) {
    case 1:
        m_playbackMode = QMediaPlaylist::CurrentItemInLoop;
        break;
    case 2:
        m_playbackMode = QMediaPlaylist::Sequential;
        break;
    case 3:
        m_playbackMode = QMediaPlaylist::Loop;
        break;
    case 4:
        m_playbackMode = QMediaPlaylist::Random;
        break;
    default:
        m_playbackMode = QMediaPlaylist::Loop;
        break;
    }
}

Player::~Player()
{
    if (m_api != nullptr) {
        delete m_api;
        m_api = nullptr;
    }
}