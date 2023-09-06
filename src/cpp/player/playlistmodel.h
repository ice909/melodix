#ifndef PLAYLISTMODEL_H
#define PLAYLISTMODEL_H

#include <QAbstractListModel>
#include <QDebug>
#include <QList>
#include <QObject>
#include <QUrl>

class PlaylistModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit PlaylistModel(QObject *parent = nullptr);

    QString getId(int index) const;
    QString getTitle(int index) const;
    QString getImageUrl(int index) const;
    QString getAuthor(int index) const;
    QString getDuration(int index) const;
    int indexofId(const QString &id) const;

    // 定义角色枚举
    enum PlaylistRoles {
        IdRole = Qt::UserRole + 1,
        TitleRole,
        ImageRole,
        AuthorRole,
        DurationRole
    };

    // 重写 QAbstractListModel 的成员函数
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    // 自定义方法用于添加歌曲
    void addSong(const QString &id,
                 const QString &title,
                 const QString &imageUrl,
                 const QString &author,
                 const QString &duration);

    // 清空模型
    void clear();

    // 获取所有id,使用,号拼接成一个字符串
    QString getAllId();

private:
    struct Song
    {
        QString id;
        QString title;
        QString imageUrl;
        QString author;
        QString duration;
    };

    QList<Song> m_songs;
    QStringList m_musicIds;
};

#endif // PLAYLISTMODEL_H
