#include "player.h"

Player::Player(QObject *parent)
    : QObject(parent)
    , m_playlistModel(new PlaylistModel(this))
    , m_settings(new QSettings(QDir::homePath() + "/.config/ice/player.ini", QSettings::IniFormat))
{
    // 读取音量配置
    m_volume = m_settings->value("Volume/DefaultVolume", 50).toInt();
    // 读取静音配置
    m_mute = m_settings->value("Volume/Mute", false).toBool();
    // 读取播放模式配置 把第一种播放模式去除，只要后面三种
    int playbackMode = m_settings->value("Playback/PlaybackMode", 3).toInt();
    switch (playbackMode) {
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

    m_player = new QMediaPlayer(this);
    m_playlist = new QMediaPlaylist(this);
    m_player->setPlaylist(m_playlist);
    m_playlist->setPlaybackMode(m_playbackMode);

    // 设置音量
    m_player->setVolume(m_volume);
    connect(m_player, &QMediaPlayer::positionChanged, this, &Player::onPositionChanged);
    connect(m_player, &QMediaPlayer::durationChanged, this, &Player::onDurationChanged);
    connect(m_playlist, &QMediaPlaylist::currentIndexChanged, this, &Player::onCurrentIndexChanged);
    connect(m_playlist, &QMediaPlaylist::mediaInserted, this, &Player::onMediaCountChanged);
    connect(m_playlist, &QMediaPlaylist::mediaRemoved, this, &Player::onMediaCountChanged);
}

void Player::addSignleToPlaylist(const QString &url,
                                 const QString &name,
                                 const QString &artist,
                                 const QString &pic,
                                 const QString &duration)
{
    m_playlist->addMedia(QUrl(url));
    m_currentSong.append(name);
    m_currentArtist.append(artist);
    m_currentImg.append(pic);

    m_playlistModel->addSong(name, pic, artist, duration);

    playNewlyAddedSong();
}

void Player::playNewlyAddedSong()
{
    m_playlist->setCurrentIndex(m_playlist->mediaCount() - 1);
    play();
}

void Player::playNewlyAddedSong(int index)
{
    m_playlist->setCurrentIndex(index);
    play();
}

void Player::play()
{
    QMediaPlayer::MediaStatus status = m_player->mediaStatus();
    if (status == QMediaPlayer::UnknownMediaStatus || status == QMediaPlayer::EndOfMedia
        || status == QMediaPlayer::InvalidMedia)
        return;
    m_player->play();
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
    m_playlist->next();
    qDebug() << "next" << m_playlist->currentIndex();
    play();
}

void Player::previous()
{
    pause();
    m_playlist->previous();
    play();
}

QString Player::getName()
{
    if (m_playlist->mediaCount() != 0)
        return m_currentSong[m_playlist->currentIndex()];

    return "";
}

QString Player::getArtist()
{
    if (m_playlist->mediaCount() != 0)
        return m_currentArtist[m_playlist->currentIndex()];

    return "";
}

QString Player::getPic()
{
    if (m_playlist->mediaCount() != 0)
        return m_currentImg[m_playlist->currentIndex()];

    return "";
}

bool Player::getPlayState()
{
    return m_playState;
}

void Player::onPositionChanged(qint64 new_position)
{
    m_position = new_position;
    emit positionChanged();
}

void Player::onDurationChanged(qint64 duration)
{
    m_duration = duration;
    emit durationChanged();
}

qint64 Player::getDuration()
{
    return m_duration;
}

qint64 Player::getPosition()
{
    return m_position;
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

void Player::setPlaybackMode(int mode)
{
    switch (mode) {
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
    m_playlist->setPlaybackMode(m_playbackMode);
    m_settings->setValue("Playback/PlaybackMode", mode);
}

void Player::onCurrentIndexChanged(int index)
{
    qDebug() << "current index changed" << index;
    if (index == -1) {
        m_playlist->setCurrentIndex(0);
    }
    emit playlistCurrentIndexChanged();
}

QObject *Player::getPlaylistModel()
{
    return m_playlistModel;
}

int Player::getPlaylistSize()
{
    return m_playlist->mediaCount();
}

void Player::onMediaCountChanged(int start, int end)
{
    emit mediaCountChanged(m_playlist->mediaCount());
}

int Player::getCurrentIndex()
{
    qDebug() << "current index" << m_playlist->currentIndex();
    return m_playlist->currentIndex();
}
