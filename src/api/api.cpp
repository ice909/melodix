#include "api.h"
#include "worker.h"

#include <QDateTime>
#include <QDebug>
#include <QRandomGenerator>

template<typename T>
QJsonArray toJsonArray(QList<T> list)
{
    QJsonArray arr;
    for (auto item : list) {
        arr.append(item.asJsonObject());
    }
    return arr;
}

API::API(QObject *parent)
    : QObject(parent)
    , apiInstance(new MDClientApi)
    , apiInstance2(new MDClientApi)
    , userApiInstance(new MDClientApi)
{
    QString cookie = Worker::instance()->getCookie();
    if (!cookie.isEmpty()) {
        userApiInstance->addHeaders("Cookie", cookie);
    }
    connect(apiInstance2,
            &MDClientApi::getTopPlaylistSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetTopPlaylist_200_response response) {
                emit topPlaylistCountCompleted(response.getTotal());
            });
    connect(apiInstance,
            &MDClientApi::getTopPlaylistSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetTopPlaylist_200_response response) {
                emit topPlaylistCompleted(toJsonArray(response.getPlaylists()));
            });
    connect(userApiInstance,
            &MDClientApi::getLoginStatusSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetLoginStatus_200_response response) {
                emit loginStatusCompleted(response.getData().asJsonObject());
            });
    connect(userApiInstance,
            &MDClientApi::getAccountInfoSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetAccountInfo_200_response response) {
                emit accountInfoCompleted(response.getProfile().asJsonObject());
            });
    connect(userApiInstance,
            &MDClientApi::getLikeSongIdSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetLikeSongId_200_response response) {
                emit userLikeSongIdsCompleted(response.asJsonObject());
            });
    connect(userApiInstance,
            &MDClientApi::getSongUrlSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetSongUrl_200_response response) {
                emit songUrlCompleted(toJsonArray(response.getData()));
            });
    connect(apiInstance,
            &MDClientApi::getPlaylistDetailSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetPlaylistDetail_200_response response) {
                emit playlistDetailCompleted(response.getPlaylist().asJsonObject());
            });
    connect(apiInstance,
            &MDClientApi::getPlaylistTrackAllSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetPlaylistTrackAll_200_response response) {
                emit playlistSongsCompleted(toJsonArray(response.getSongs()));
            });
}

void API::banner(const QString type)
{
    apiInstance->banner(type);
    connect(apiInstance,
            &MDClientApi::bannerSignalFull,
            [&](MDHttpRequestWorker *worker, MDBanner_200_response response) {
                emit bannerCompleted(toJsonArray(response.getBanners()));
            });
}

void API::getRecommendedPlaylist(const QString limit)
{
    apiInstance->getRecommendedPlaylist(limit);
    connect(apiInstance,
            &MDClientApi::getRecommendedPlaylistSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetRecommendedPlaylist_200_response response) {
                emit recommendedPlaylistCompleted(toJsonArray(response.getResult()));
            });
}

void API::getRecommendedNewSongs(const QString limit)
{
    apiInstance->getRecommendedNewSongs(limit);
    connect(apiInstance,
            &MDClientApi::getRecommendedNewSongsSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetRecommendedNewSongs_200_response response) {
                emit recommendedNewSongsCompleted(toJsonArray(response.getResult()));
            });
}

void API::getTopArtists()
{
    apiInstance->getTopArtists();
    connect(apiInstance,
            &MDClientApi::getTopArtistsSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetTopArtists_200_response response) {
                QList<MDGetTopArtists_200_response_artists_inner> artists = response.getArtists();
                // 获取的热门歌手共有50个
                // 生成一个0～45的随机数
                QRandomGenerator random;
                int index = random.bounded(45);
                // 从随机数开始取5个
                artists = artists.mid(index, 5);
                emit topArtistsCompleted(toJsonArray(artists));
            });
}

void API::getRecommendedMv()
{
    apiInstance->getRecommendedMv();
    connect(apiInstance,
            &MDClientApi::getRecommendedMvSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetRecommendedMv_200_response response) {
                emit recommendedMvCompleted(toJsonArray(response.getResult()));
            });
}

void API::getTopPlaylistCount(const QString cat)
{
    apiInstance2->getTopPlaylist(cat);
}

void API::getTopPlaylist(const QString cat,
                         const QString order,
                         const QString limit,
                         const QString offset)
{
    apiInstance->getTopPlaylist(cat, order, limit, offset);
}

void API::getLoginStatus()
{
    userApiInstance->getLoginStatus(QString::number(QDateTime::currentMSecsSinceEpoch()));
}

void API::getAccountInfo()
{
    userApiInstance->getAccountInfo(QDateTime::currentMSecsSinceEpoch());
}

void API::getUserLikeSongIds(const QString id)
{
    userApiInstance->getLikeSongId(id);
}

void API::getSongUrl(const QString id)
{
    userApiInstance->getSongUrl(id);
}

void API::getPlaylistDetail(const QString id)
{
    apiInstance->getPlaylistDetail(id);
}

void API::getPlaylistSongs(const QString id, const QString limit, const QString offset)
{
    apiInstance->getPlaylistTrackAll(id, limit, offset);
}

API::~API()
{
    if (apiInstance != nullptr) {
        delete apiInstance;
        apiInstance = nullptr;
    }
    if (apiInstance2 != nullptr) {
        delete apiInstance2;
        apiInstance2 = nullptr;
    }
    if (userApiInstance != nullptr) {
        delete userApiInstance;
        userApiInstance = nullptr;
    }
}