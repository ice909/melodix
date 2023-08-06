#include "player.h"

Player::Player(QObject *parent)
    : QObject(parent)
{
    m_player = new QMediaPlayer(this);
}

void Player::addSignleToPlaylist(const QString &url)
{
    m_player->setMedia(QUrl(url));
    m_player->play();
}