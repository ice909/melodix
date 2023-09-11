#ifndef MELODIX_API_H
#define MELODIX_API_H

#include <MDClientApi.h>
#include <QObject>

using namespace MelodixAPI;

class API : public QObject
{
    Q_OBJECT
public:
    explicit API(QObject *parent = nullptr);
public slots:
    void banner(const QString type);
    void getRecommendedPlaylist(const QString limit);
    void getRecommendedNewSongs(const QString limit);
    void getTopArtists();
    void getRecommendedMv();
signals:
    void bannerCompleted(QJsonArray);
    void recommendedPlaylistCompleted(QJsonArray);
    void recommendedNewSongsCompleted(QJsonArray);
    void topArtistsCompleted(QJsonArray);
    void recommendedMvCompleted(QJsonArray);
private: 
    MDClientApi *apiInstance = nullptr;
};

#endif // MELODIX_API_H