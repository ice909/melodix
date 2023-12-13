#include "dataformatter.h"

DataFormatter::DataFormatter(QObject *parent)
    : QObject(parent)
{}

QJsonArray DataFormatter::format(const QJsonArray &data, const DataFormatter::DataType type)
{
    QJsonArray arr;
    switch (type) {
    case ArtistSingle:
        return reformatArtistSingle(data);
    case PlaylistSongs:
        return reformatArtistSingle(data);
    case RecommendNewSongs:
        return reformatRecommendNewSongs(data);
    case DailyRecommendSongs:
        return reformatDialayRecommendSongs(data);
    default:
        return QJsonArray();
    }
}

QJsonObject DataFormatter::format(const QJsonObject &data, const DataFormatter::DataType type)
{
    switch (type) {
    case Search:
        return reformatSearch(data);
    default:
        return QJsonObject();
    }
}

QJsonArray DataFormatter::reformatArtistSingle(const QJsonArray &data)
{
    QJsonArray arr;
    for (auto item : data) {
        arr.append(parseSongData(item.toObject()));
    }
    return arr;
}

QJsonArray DataFormatter::reformatRecommendNewSongs(const QJsonArray &data)
{
    QJsonArray arr;
    for (auto item : data) {
        QJsonObject obj = item.toObject();
        int id = obj["id"].toInt();
        QString name = obj["name"].toString();
        QString pic = obj["picUrl"].toString();
        QJsonObject _song = obj["song"].toObject();
        QJsonArray artists = _song["artists"].toArray();
        QString album = _song["album"].toObject()["name"].toString();
        int duration = _song["duration"].toInt();
        QJsonObject song = createSongObject(id, name, artists, pic, album, duration);
        arr.append(song);
    }
    return arr;
}

QJsonArray DataFormatter::reformatDialayRecommendSongs(const QJsonArray &data)
{
    QJsonArray arr;
    for (auto item : data) {
        arr.append(parseSongData(item.toObject()));
    }
    return arr;
}

QJsonObject DataFormatter::reformatSearch(const QJsonObject &data)
{
    QJsonObject obj;
    QJsonArray newSongs;
    int songCount = data["songCount"].toInt();
    QJsonArray songs = data["songs"].toArray();
    for (auto item : songs) {
        newSongs.append(parseSongData(item.toObject()));
    }
    obj.insert("songs", newSongs);
    obj.insert("songCount", songCount);
    return obj;
}

QJsonObject DataFormatter::createSongObject(int id,
                                            const QString &name,
                                            const QJsonArray &artists,
                                            const QString &pic,
                                            const QString &album,
                                            int duration)
{
    QJsonObject song;
    song.insert("id", id);
    song.insert("name", name);
    song.insert("ar", artists);
    song.insert("pic", pic);
    song.insert("al", album);
    song.insert("duration", duration);
    return song;
}

QJsonObject DataFormatter::parseSongData(const QJsonObject &data)
{
    int id = data["id"].toInt();
    QString name = data["name"].toString();
    QJsonArray artists = data["ar"].toArray();
    QJsonObject al = data["al"].toObject();
    QString pic = al["picUrl"].toString();
    QString album = al["name"].toString();
    int duration = data["dt"].toInt();

    return createSongObject(id, name, artists, pic, album, duration);
    ;
}