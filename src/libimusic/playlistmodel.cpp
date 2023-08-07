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
    case TitleRole:
        return song.title;
    case ImageRole:
        return song.imageUrl;
    case AuthorRole:
        return song.author;
    case DurationRole:
        return song.duration;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> PlaylistModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[ImageRole] = "image";
    roles[AuthorRole] = "author";
    roles[DurationRole] = "duration";
    return roles;
}

void PlaylistModel::addSong(const QString &title,
                            const QString &imageUrl,
                            const QString &author,
                            const QString &duration)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());

    Song song;
    song.title = title;
    song.imageUrl = imageUrl;
    song.author = author;
    song.duration = duration;
    m_songs.append(song);

    endInsertRows();
}

void PlaylistModel::clear()
{
    beginResetModel();
    m_songs.clear();
    endResetModel();
}