#include "playlistmodel.h"

PlaylistModel::PlaylistModel(QObject *parent)
    : QAbstractListModel(parent)
{}

int PlaylistModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_songs.count();
}

QVariant PlaylistModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 || index.row() >= m_songs.count())
        return QVariant();

    const Song &song = m_songs.at(index.row());

    // 根据角色返回相应的数据
    switch (role) {
    case IdRole:
        return song.id;
    case TitleRole:
        return song.title;
    case ImageRole:
        return song.imageUrl;
    case AuthorRole:
        return song.author;
    case DurationRole:
        return song.duration;
    case AlbumRole:
        return song.album;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> PlaylistModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[TitleRole] = "title";
    roles[ImageRole] = "image";
    roles[AuthorRole] = "author";
    roles[DurationRole] = "duration";
    return roles;
}

void PlaylistModel::addSong(const int &id,
                            const QString &title,
                            const QString &author,
                            const QString &imageUrl,
                            const QString &duration,
                            const QString &album)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());

    Song song;
    song.id = id;
    song.title = title;
    song.author = author;
    song.imageUrl = imageUrl;
    song.duration = duration;
    song.album = album;
    m_songs.append(song);

    endInsertRows();
}

int PlaylistModel::getId(int index) const
{
    if (index < 0 || index >= m_songs.size()) {
        return 0;
    }
    return m_songs[index].id;
}

QString PlaylistModel::getTitle(int index) const
{
    if (index < 0 || index >= m_songs.size()) {
        return QString();
    }

    return m_songs[index].title;
}

QString PlaylistModel::getImageUrl(int index) const
{
    if (index < 0 || index >= m_songs.size()) {
        return QString();
    }
    return m_songs[index].imageUrl;
}

QString PlaylistModel::getAuthor(int index) const
{
    if (index < 0 || index >= m_songs.size()) {
        return QString();
    }
    return m_songs[index].author;
}

QString PlaylistModel::getDuration(int index) const
{
    if (index < 0 || index >= m_songs.size()) {
        return QString();
    }
    return m_songs[index].duration;
}

QString PlaylistModel::getAlbum(int index) const
{
    if (index < 0 || index >= m_songs.size()) {
        return QString();
    }
    return m_songs[index].album;
}

QString PlaylistModel::getAllId()
{
    QString ids;
    for (int i = 0; i < m_songs.size() - 1; ++i) {
        ids += QString::number(m_songs[i].id) + ",";
    }
    ids += m_songs[m_songs.size() - 1].id;
    return ids;
}

int PlaylistModel::indexOfId(const int &id) const
{
    int index = -1;
    for (int i = 0; i < m_songs.size(); ++i) {
        if (m_songs[i].id == id) {
            index = i;
            break;
        }
    }
    return index;
}

void PlaylistModel::clear()
{
    beginResetModel();
    m_songs.clear();
    endResetModel();
}

void PlaylistModel::interchangeSong(const int index, const int to)
{
    // 交换两个Song
    m_songs.move(index, to);
    QModelIndex topLeft = createIndex(0, 0);
    QModelIndex bottomRight = createIndex(m_songs.count() - 1, 0);
    emit dataChanged(topLeft, bottomRight);
}