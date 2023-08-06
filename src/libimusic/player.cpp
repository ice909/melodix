#include "player.h"

Player::Player(QObject *parent)
    : QObject(parent)
    , m_settings(new QSettings(QDir::homePath() + "/.config/ice/player.ini", QSettings::IniFormat))
{
    // 读取音量配置
    m_volume = m_settings->value("Volume/DefaultVolume", 50).toInt();
    // 读取静音配置
    m_mute = m_settings->value("Volume/Mute", false).toBool();

    m_player = new QMediaPlayer(this);
    // 设置音量
    m_player->setVolume(m_volume);
    connect(m_player, &QMediaPlayer::positionChanged, this, &Player::onPositionChanged);
    connect(m_player, &QMediaPlayer::durationChanged, this, &Player::onDurationChanged);
}

void Player::addSignleToPlaylist(const QString &url,
                                 const QString &name,
                                 const QString &artist,
                                 const QString &pic)
{
    m_player->setMedia(QUrl(url));
    m_name = name;
    m_artist = artist;
    m_pic = pic;
    emit metaChanged();
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

QString Player::getName()
{
    return m_name;
}

QString Player::getArtist()
{
    return m_artist;
}

QString Player::getPic()
{
    return m_pic;
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
