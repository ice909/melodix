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
    ~API();
public slots:
    void banner(const QString type);
    void getRecommendedPlaylist(const QString limit);
    void getRecommendedNewSongs(const QString limit);
    void getTopArtists();
    void getRecommendedMv();
    void getTopPlaylistCount(const QString cat);
    void getTopPlaylist(const QString cat,
                        const QString order,
                        const QString limit,
                        const QString offset);
    void getLoginStatus();
    void getAccountInfo();
    void getUserLikeSongIds(const QString id);
signals:
    void bannerCompleted(QJsonArray);
    void recommendedPlaylistCompleted(QJsonArray);
    void recommendedNewSongsCompleted(QJsonArray);
    void topArtistsCompleted(QJsonArray);
    void recommendedMvCompleted(QJsonArray);
    void topPlaylistCountCompleted(qint32);
    void topPlaylistCompleted(QJsonArray);
    void loginStatusCompleted(QJsonObject);
    void accountInfoCompleted(QJsonObject);
    void userLikeSongIdsCompleted(QJsonObject);

private:
    MDClientApi *apiInstance = nullptr;
    MDClientApi *apiInstance2 = nullptr;
    MDClientApi *userApiInstance = nullptr;
};

#endif // MELODIX_API_H