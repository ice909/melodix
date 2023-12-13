#ifndef DATA_FORMATTER_H
#define DATA_FORMATTER_H

#include <QJsonArray>
#include <QJsonObject>
#include <QObject>

class DataFormatter : public QObject
{
public:
    enum DataType {
        ArtistSingle = 1,
        PlaylistSongs = 2,
        RecommendNewSongs = 3,
        DailyRecommendSongs = 4,
        Search = 5,
    };
    DataFormatter(QObject *parent = nullptr);
    QJsonArray format(const QJsonArray &data, const DataType type);
    QJsonObject format(const QJsonObject &data, const DataType type);

private:
    QJsonArray reformatArtistSingle(const QJsonArray &data);
    QJsonArray reformatRecommendNewSongs(const QJsonArray &data);
    QJsonArray reformatDialayRecommendSongs(const QJsonArray &data);
    QJsonObject reformatSearch(const QJsonObject &data);
    QJsonObject createSongObject(int id,
                                 const QString &name,
                                 const QJsonArray &artists,
                                 const QString &pic,
                                 const QString &album,
                                 int duration);
    QJsonObject parseSongData(const QJsonObject &data);
};

#endif // DATA_FORMATTER_H