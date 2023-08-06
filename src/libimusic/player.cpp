#include "player.h"

Player::Player(QObject *parent)
    : QObject(parent)
{
    m_player = new QMediaPlayer(this);
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
