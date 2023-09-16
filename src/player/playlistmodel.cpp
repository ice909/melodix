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

void PlaylistModel::addSong(const QString &id,
                            const QString &title,
                            const QString &imageUrl,
                            const QString &author,
                            const QString &duration,
                            const bool &isVip)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());

    Song song;
    song.id = id;
    song.title = title;
    song.imageUrl = imageUrl;
    song.author = author;
    song.duration = duration;
    song.isVip = isVip;
    m_songs.append(song);

    endInsertRows();
}

QString PlaylistModel::getId(int index) const
{
    if (index < 0 || index >= m_songs.size()) {
        return QString();
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

bool PlaylistModel::getIsVip(int index) const
{
    if (index < 0 || index >= m_songs.size()) {
        return false;
    }
    return m_songs[index].isVip;
}

QString PlaylistModel::getAllId()
{
    QString ids;
    for (int i = 0; i < m_songs.size() - 1; ++i) {
        ids += m_songs[i].id + ",";
    }
    ids += m_songs[m_songs.size() - 1].id;
    return ids;
}

int PlaylistModel::indexofId(const QString &id) const
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