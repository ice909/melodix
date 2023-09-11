#include "api.h"

#include <QEventLoop>
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

API::API(QObject *parent) : QObject(parent)
{
    apiInstance = new MDClientApi;
    connect(apiInstance,
            &MDClientApi::bannerSignalFull,
            [&](MDHttpRequestWorker *worker, MDBanner_200_response response) {
                emit bannerCompleted(toJsonArray(response.getBanners()));
            });
    connect(apiInstance,
            &MDClientApi::getRecommendedPlaylistSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetRecommendedPlaylist_200_response response) {                
                emit recommendedPlaylistCompleted(toJsonArray(response.getResult()));
            });
    connect(apiInstance,
            &MDClientApi::getRecommendedNewSongsSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetRecommendedNewSongs_200_response response) {
                emit recommendedNewSongsCompleted(toJsonArray(response.getResult()));
            });
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
    connect(apiInstance,
            &MDClientApi::getRecommendedMvSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetRecommendedMv_200_response response) {
                emit recommendedMvCompleted(toJsonArray(response.getResult()));
            });
}

void API::banner(const QString type)
{
    apiInstance->banner(type);
}

void API::getRecommendedPlaylist(const QString limit)
{
    apiInstance->getRecommendedPlaylist(limit);
}

void API::getRecommendedNewSongs(const QString limit)
{
    apiInstance->getRecommendedNewSongs(limit);
}

void API::getTopArtists()
{
    apiInstance->getTopArtists();
}

void API::getRecommendedMv()
{
    apiInstance->getRecommendedMv();
}