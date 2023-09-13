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
    , userApiInstance(new MDClientApi)
{
    QString cookie = Worker::instance()->getCookie();
    if (!cookie.isEmpty()) {
        userApiInstance->addHeaders("Cookie", cookie);
    }
    connect(apiInstance,
            &MDClientApi::getTopPlaylistSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetTopPlaylist_200_response response) {
                emit topPlaylistCompleted(response.asJsonObject());
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
    connect(userApiInstance,
            &MDClientApi::getUserPlaylistSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetUserPlaylist_200_response response) {
                emit userPlaylistCompleted(toJsonArray(response.getPlaylist()));
            });
    connect(apiInstance,
            &MDClientApi::getLyricSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetLyric_200_response response) {
                emit lyricCompleted(response.getLrc().getLyric());
            });
    connect(userApiInstance,
            &MDClientApi::getPurchasedAlbumSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetPurchasedAlbum_200_response response) {
                emit userBuyAlbumCompleted(toJsonArray(response.getPaidAlbums()));
            });
    connect(userApiInstance,
            &MDClientApi::getArtistSublistSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetArtistSublist_200_response response) {
                emit artistSublistCompleted(toJsonArray(response.getData()));
            });
    connect(userApiInstance,
            &MDClientApi::getMvSublistSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetMvSublist_200_response response) {
                emit mvSublistCompleted(toJsonArray(response.getData()));
            });
    connect(apiInstance,
            &MDClientApi::getArtistDetailSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetArtistDetail_200_response response) {
                emit artistDetailCompleted(response.getData().asJsonObject());
            });
    connect(apiInstance,
            &MDClientApi::getArtistAlbumSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetArtistAlbum_200_response response) {
                emit artistAlbumCompleted(toJsonArray(response.getHotAlbums()));
            });
    connect(apiInstance,
            &MDClientApi::getArtistMvSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetArtistMv_200_response response) {
                emit artistMvCompleted(toJsonArray(response.getMvs()));
            });
    connect(apiInstance,
            &MDClientApi::getArtistSingleSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetArtistSingle_200_response response) {
                emit artistSongsCompleted(toJsonArray(response.getHotSongs()));
            });
    connect(apiInstance,
            &MDClientApi::getMvUrlSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetMvUrl_200_response response) {
                emit mvUrlCompleted(response.getData().asJsonObject());
            });
    connect(apiInstance,
            &MDClientApi::getMvDetailSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetMvDetail_200_response response) {
                emit mvDetailCompleted(response.getData().asJsonObject());
            });
    connect(apiInstance,
            &MDClientApi::getHotCommentSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetHotComment_200_response response) {
                emit hotCommentCompleted(toJsonArray(response.getHotComments()));
            });
    connect(apiInstance,
            &MDClientApi::getSimiMvSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetSimiMv_200_response response) {
                emit simiMvCompleted(toJsonArray(response.getMvs()));
            });
    connect(apiInstance,
            &MDClientApi::searchSignalFull,
            [&](MDHttpRequestWorker *worker, MDSearch_200_response response) {
                emit searchCompleted(response.getResult().asJsonObject());
            });
    connect(userApiInstance,
            &MDClientApi::likeMusicSignalFull,
            [&](MDHttpRequestWorker *worker, MDLikeMusic_200_response response) {
                emit likeMusicCompleted(response.asJsonObject());
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
                // 从随机数开始取5个
                artists = artists.mid(QRandomGenerator::global()->bounded(45), 5);
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

void API::getPlaylistSongs(const QString id)
{
    apiInstance->getPlaylistTrackAll(id);
}

void API::getUserPlaylist(const QString id)
{
    userApiInstance->getUserPlaylist(id);
}

void API::getLyric(const QString id)
{
    apiInstance->getLyric(id);
}

void API::getUserBuyAlbum()
{
    userApiInstance->getPurchasedAlbum();
}

void API::getArtistSublist()
{
    userApiInstance->getArtistSublist(QString::number(QDateTime::currentMSecsSinceEpoch()));
}

void API::getMvSublist()
{
    userApiInstance->getMvSublist(QString::number(QDateTime::currentMSecsSinceEpoch()));
}

void API::getArtistDetail(const QString id)
{
    apiInstance->getArtistDetail(id);
}

void API::getArtistAlbum(const QString id)
{
    apiInstance->getArtistAlbum(id);
}

void API::getArtistMv(const QString id)
{
    apiInstance->getArtistMv(id);
}

void API::getArtistSongs(const QString id)
{
    apiInstance->getArtistSingle(id);
}

void API::getMvUrl(const QString id)
{
    apiInstance->getMvUrl(id);
}

void API::getMvDetail(const QString id)
{
    apiInstance->getMvDetail(id);
}

void API::getMvHotComment(const QString id, const QString type)
{
    apiInstance->getHotComment(id, type);
}

void API::getSimiMv(const QString id)
{
    apiInstance->getSimiMv(id);
}

void API::search(const QString keyword)
{
    apiInstance->search(keyword);
}

void API::search(const QString keyword, const QString limit, const QString offset)
{
    apiInstance->search(keyword, limit, offset);
}

void API::likeMusic(const QString id,const QString like)
{
    userApiInstance->likeMusic(id,like,QString::number(QDateTime::currentMSecsSinceEpoch()));
}

API::~API()
{
    if (apiInstance != nullptr) {
        delete apiInstance;
        apiInstance = nullptr;
    }
    if (userApiInstance != nullptr) {
        delete userApiInstance;
        userApiInstance = nullptr;
    }
}