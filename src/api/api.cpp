#include "api.h"

#include <QDebug>
#include <QEventLoop>
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
{
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
}