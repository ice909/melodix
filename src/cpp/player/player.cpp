#include "player.h"

Player::Player(QObject *parent)
    : QObject(parent)
    , m_player(new QMediaPlayer(this))
    , m_playlistModel(new PlaylistModel(this))
    , m_playlist(new QMediaPlaylist(this))
    , m_singleTrackModel(new PlaylistModel(this))
    , m_singleTrackPlaylist(new QMediaPlaylist(this))
    , m_settings(
          new QSettings(QDir::homePath() + "/.config/ice/player.ini", QSettings::IniFormat, this))
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
                qDebug() << "播放器错误: " << error;
                stop();
            });

    connect(m_playlist, &QMediaPlaylist::loadFailed, [=]() {
        qDebug() << "播放列表加载失败";
        stop();
    });
}

void Player::addSignleToPlaylist(const QString &url,
                                 const QString &id,
                                 const QString &name,
                                 const QString &pic,
                                 const QString &artist,
                                 const QString &duration)
{
    m_singleTrackPlaylist->addMedia(QUrl(url));
    m_singleTrackModel->addSong(id, name, pic, artist, duration);
    if (m_currentModel != m_singleTrackModel) {
        switchToSingleTrackMode();
    }
    emit mediaCountChanged(m_singleTrackModel->rowCount());
    play(m_currentPlaylist->mediaCount() - 1);
}

void Player::addPlaylistToPlaylist(const QString &url,
                                   const QString &id,
                                   const QString &name,
                                   const QString &pic,
                                   const QString &artist,
                                   const QString &duration)
{
    m_playlist->addMedia(QUrl(url));
    m_playlistModel->addSong(id, name, pic, artist, duration);
    if (m_currentModel != m_playlistModel) {
        switchToPlaylistMode();
    }
}

void Player::switchToSingleTrackMode()
{
    if (m_currentPlaylist != m_singleTrackPlaylist) {
        m_currentPlaylist = m_singleTrackPlaylist;
        m_currentModel = m_singleTrackModel;
        m_player->setPlaylist(m_currentPlaylist);
        // 切换到当前播放列表需要把另一个播放列表清空
        m_playlist->clear();
        m_playlistModel->clear();
    }
}

void Player::switchToPlaylistMode()
{
    if (m_currentPlaylist != m_playlist) {
        m_currentPlaylist = m_playlist;
        m_currentModel = m_playlistModel;
        m_player->setPlaylist(m_currentPlaylist);
        // 切换到当前播放列表需要把另一个播放列表清空
        m_singleTrackPlaylist->clear();
        m_singleTrackModel->clear();
    }
}

/************* Controller *****************/

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

void Player::pause()
{
    m_player->pause();
    m_playState = false;
    emit playStateChanged();
}

void Player::stop()
{
    m_player->stop();
    m_playState = false;
    emit playStateChanged();
}

void Player::next()
{
    pause();
    m_currentPlaylist->next();
    qDebug() << "切换下一首：" << m_currentPlaylist->currentIndex();
    play();
}

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

void Player::setVolume(int volume)
{
    m_volume = volume;
    m_player->setVolume(m_volume);
    m_settings->setValue("Volume/DefaultVolume", m_volume);
}

void Player::setMute(bool mute)
{
    m_mute = mute;
    m_player->setMuted(m_mute);
    m_settings->setValue("Volume/Mute", m_mute);
}

void Player::setPlaybackMode(int mode)
{
    switchPlaybackMode(mode);
    m_currentPlaylist->setPlaybackMode(m_playbackMode);
    m_settings->setValue("Playback/PlaybackMode", mode);
}

void Player::setCurrentPlaylistId(const QString &id)
{
    m_currentPlaylistId = id;
}

void Player::setPosition(qint64 newPosition)
{
    m_player->setPosition(newPosition);
}

/**************** Get ********************/

QString Player::getId()
{
    if (m_currentPlaylist->mediaCount() != 0)
        return m_currentModel->getId(m_currentPlaylist->currentIndex());

    return "";
}

QString Player::getName()
{
    if (m_currentPlaylist->mediaCount() != 0)
        return m_currentModel->getTitle(m_currentPlaylist->currentIndex());

    return "";
}

QString Player::getArtist()
{
    if (m_currentPlaylist->mediaCount() != 0)
        return m_currentModel->getAuthor(m_currentPlaylist->currentIndex());

    return "";
}

QString Player::getPic()
{
    if (m_currentPlaylist->mediaCount() != 0)
        return m_currentModel->getImageUrl(m_currentPlaylist->currentIndex());

    return "qrc:/dsg/img/no_music.svg";
}

bool Player::getPlayState()
{
    return m_playState;
}

qint64 Player::getDuration()
{
    return m_duration;
}

qint64 Player::getPosition()
{
    return m_position;
}

int Player::getVolume()
{
    return m_volume;
}

bool Player::getMute()
{
    return m_mute;
}

int Player::getPlaybackMode()
{
    return m_playbackMode;
}

int Player::getPlaylistSize()
{
    return m_currentPlaylist->mediaCount();
}

int Player::getCurrentIndex()
{
    qDebug() << "调用，当前播放歌曲的下标：" << m_currentPlaylist->currentIndex();
    return m_currentPlaylist->currentIndex();
}

QObject *Player::getPlaylistModel()
{
    return m_currentModel;
}

QString Player::getFormatDuration()
{
    QTime time = QTime::fromMSecsSinceStartOfDay(m_duration);
    return time.toString("m:ss");
}

QString Player::getFormatPosition()
{
    QTime time = QTime::fromMSecsSinceStartOfDay(m_position);
    return time.toString("m:ss");
}

int Player::getMediaCount()
{
    return m_currentPlaylist->mediaCount();
}

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

void Player::addAllSongsToPlaylist() {}