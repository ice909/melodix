#include "playlist.h"
#include "playlistmodel.h"

#include <QRandomGenerator>
#include <QTime>

Playlist::Playlist(QObject *parent)
    : QObject(parent)
    , m_playlistModel(new PlaylistModel(this))
{}

void Playlist::addSong(const int &id,
                       const QString &name,
                       const QString &artist,
                       const QString &pic,
                       const QString &duration,
                       const QString &album)
{
    m_playlistModel->addSong(id, name, artist, pic, duration, album);
    m_songCount++;
    emit songCountChanged(m_songCount);
}

void Playlist::next()
{
    switch (m_playMode) {
    case CurrentItemInLoop:
        break;
    case Loop:
        if (m_currentIndex == m_songCount - 1) {
            m_currentIndex = 0;
        } else {
            m_currentIndex++;
        }
        break;
    case Random:
        m_currentIndex = prepareRandomIndex();
        break;
    default:
        break;
    }
    emit currentIndexChanged(m_currentIndex);
}

void Playlist::previous()
{
    switch (m_playMode) {
    case CurrentItemInLoop:
        break;
    case Loop:
        if (m_currentIndex == 0) {
            m_currentIndex = m_songCount - 1;
        } else {
            m_currentIndex--;
        }
        break;
    case Random:
        m_currentIndex = prepareRandomIndex();
        break;
    default:
        break;
    }
    emit currentIndexChanged(m_currentIndex);
}

int Playlist::prepareRandomIndex()
{
    // Generate a random index, 0 <= n < m_songCount
    int randomIndex = QRandomGenerator::global()->bounded(m_songCount);
    // If the random index is equal to the current playing song index, generate a new random index
    while (randomIndex == m_currentIndex) {
        randomIndex = QRandomGenerator::global()->bounded(m_songCount);
    }
    return randomIndex;
}

void Playlist::setPlayMode(const PlayMode &playMode)
{
    m_playMode = playMode;
}

void Playlist::clear()
{
    m_playlistModel->clear();
    m_currentIndex = 0;
    m_songCount = 0;
    emit songCountChanged(m_songCount);
}

int Playlist::getSongCount()
{
    return m_songCount;
}

void Playlist::setCurrentIndex(const int &index)
{
    if (index < 0 || index >= m_songCount) {
        return;
    }
    m_currentIndex = index;
    emit currentIndexChanged(m_currentIndex);
}

int Playlist::getCurrentIndex()
{
    return m_currentIndex;
}

int Playlist::getCurrentId()
{
    return m_playlistModel->getId(m_currentIndex);
}

QString Playlist::getCurrentName()
{
    return m_playlistModel->getTitle(m_currentIndex);
}

QString Playlist::getCurrentArtist()
{
    return m_playlistModel->getAuthor(m_currentIndex);
}

QString Playlist::getCurrentPic()
{
    return m_playlistModel->getImageUrl(m_currentIndex);
}

QString Playlist::getCurrentAlbum()
{
    return m_playlistModel->getAlbum(m_currentIndex);
}

PlaylistModel *Playlist::getPlaylistModel()
{
    return m_playlistModel;
}

int Playlist::isSongExist(const int &id)
{
    return m_playlistModel->indexOfId(id);
}

void Playlist::moveToLast(const int &index)
{
    m_playlistModel->interchangeSong(index, m_songCount - 1);
}