#include "api.h"
#include "worker.h"

#include <QDateTime>
#include <QDebug>
#include <QRandomGenerator>

QPointer<API> API::INSTANCE = nullptr;

API *API::instance()
{
    if (INSTANCE.isNull())
        INSTANCE = new API;

    return INSTANCE;
}

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
    addCookie();
    connect(apiInstance,
            &MDClientApi::getTopPlaylistSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetTopPlaylist_200_response response) {
                emit topPlaylistCompleted(response.asJsonObject());
            });
    connect(userApiInstance,
            &MDClientApi::getLoginStatusSignalFull,
            [this](MDHttpRequestWorker *worker, MDGetLoginStatus_200_response response) {
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
            &MDClientApi::getArtistSingleSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetArtistSingle_200_response response) {
                emit artistSongsCompleted(toJsonArray(response.getSongs()));
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
    connect(apiInstance,
            &MDClientApi::getQrKeySignalFull,
            [&](MDHttpRequestWorker *worker, MDGetQrKey_200_response response) {
                emit getQrKeyCompleted(response.getData().asJsonObject());
            });
    connect(apiInstance,
            &MDClientApi::qrCreateSignalFull,
            [&](MDHttpRequestWorker *worker, MDQrCreate_200_response response) {
                emit createQRCodeCompleted(response.getData().asJsonObject());
            });
    connect(apiInstance,
            &MDClientApi::qrCheckSignalFull,
            [&](MDHttpRequestWorker *worker, MDQrCheck_200_response response) {
                emit qrCheckCompleted(response.asJsonObject());
            });
    connect(apiInstance,
            &MDClientApi::sentCaptchaSignalFull,
            [&](MDHttpRequestWorker *worker, MDVerifyCaptcha_200_response response) {
                emit sendCaptchaCompleted();
            });
    connect(apiInstance,
            &MDClientApi::verifyCaptchaSignalFull,
            [&](MDHttpRequestWorker *worker, MDVerifyCaptcha_200_response response) {
                emit verifyCaptchaCompleted(response.asJsonObject());
            });
    connect(apiInstance,
            &MDClientApi::cellphoneLoginSignalFull,
            [&](MDHttpRequestWorker *worker, MDCellphoneLogin_200_response response) {
                emit cellphoneLoginCompleted(response.asJsonObject());
            });
    connect(userApiInstance,
            &MDClientApi::dailySongRecommendSignalFull,
            [&](MDHttpRequestWorker *worker, MDDailySongRecommend_200_response response) {
                emit dailyRecommendSongsCompleted(toJsonArray(response.getData()));
            });
}
void API::banner(const int type)
{
    apiInstance->banner(type);
    connect(apiInstance,
            &MDClientApi::bannerSignalFull,
            [&](MDHttpRequestWorker *worker, MDBanner_200_response response) {
                emit bannerCompleted(toJsonArray(response.getBanners()));
            });
}

void API::getRecommendedPlaylist(const int limit)
{
    apiInstance->getRecommendedPlaylist(limit);
    connect(apiInstance,
            &MDClientApi::getRecommendedPlaylistSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetRecommendedPlaylist_200_response response) {
                emit recommendedPlaylistCompleted(toJsonArray(response.getResult()));
            });
}

void API::getRecommendedPlaylist(const int limit, const int offset)
{
    apiInstance->getRecommendedPlaylist(limit, offset);
    connect(apiInstance,
            &MDClientApi::getRecommendedPlaylistSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetRecommendedPlaylist_200_response response) {
                emit recommendedPlaylistCompleted(toJsonArray(response.getResult()));
            });
}

void API::getRecommendResource()
{
    userApiInstance->getRecommendResource();
    connect(userApiInstance,
            &MDClientApi::getRecommendResourceSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetRecommendResource_200_response response) {
                emit recommendedPlaylistCompleted(toJsonArray(response.getRecommend()));
            });
}

void API::getRecommendedNewSongs(const int limit)
{
    apiInstance->getRecommendedNewSongs(limit);
    connect(apiInstance,
            &MDClientApi::getRecommendedNewSongsSignalFull,
            [&](MDHttpRequestWorker *worker, MDGetRecommendedNewSongs_200_response response) {
                QJsonArray data = toJsonArray(response.getResult());
                emit recommendedNewSongsCompleted(data);
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

void API::getTopPlaylist(const QString cat, const QString order, const int limit, const int offset)
{
    apiInstance->getTopPlaylist(cat, order, limit, offset);
}

void API::getLoginStatus()
{
    userApiInstance->getLoginStatus(QDateTime::currentMSecsSinceEpoch());
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

void API::getPlaylistSongs(const QString id, const int limit, const int offset)
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
    qDebug() << "获取歌词: id: " << id;
    apiInstance->getLyric(id);
}

void API::getUserBuyAlbum()
{
    userApiInstance->getPurchasedAlbum();
}

void API::getArtistSublist()
{
    userApiInstance->getArtistSublist(QDateTime::currentMSecsSinceEpoch());
}

void API::getArtistDetail(const QString id)
{
    apiInstance->getArtistDetail(id);
}

void API::getArtistAlbum(const QString id)
{
    apiInstance->getArtistAlbum(id);
}

void API::getArtistSongs(const QString id)
{
    apiInstance->getArtistSingle(id);
}

void API::search(const QString keyword)
{
    apiInstance->search(keyword);
}

void API::search(const QString keyword, const int limit, const int offset)
{
    apiInstance->search(keyword, limit, offset);
}

void API::likeMusic(const QString id, const QString like)
{
    userApiInstance->likeMusic(id, like, QDateTime::currentMSecsSinceEpoch());
}

void API::getQrKey()
{
    apiInstance->getQrKey(QDateTime::currentMSecsSinceEpoch());
}

void API::generateQRCode(const QString unikey)
{
    apiInstance->qrCreate(unikey, QDateTime::currentMSecsSinceEpoch(), 1);
}

void API::qrCheck(const QString unikey)
{
    apiInstance->qrCheck(unikey, QDateTime::currentMSecsSinceEpoch());
}

void API::getCaptcha(const int phone)
{
    apiInstance->sentCaptcha(phone);
}

void API::verifyCaptcha(const int phone, const int captcha)
{
    apiInstance->verifyCaptcha(phone, captcha);
}

void API::phoneLogin(const int phone, const QString password)
{
    apiInstance->cellphoneLogin(phone, password);
}

void API::phoneLogin(const int phone, const QString password, const int captcha)
{
    apiInstance->cellphoneLogin(phone, password, captcha);
}

void API::getUserDetail(const QString uid)
{
    userApiInstance->getUserDetail(uid);
}

void API::getDailyRecommendSongs()
{
    userApiInstance->dailySongRecommend();
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

void API::addCookie()
{
    QString cookie = Worker::instance()->getCookie();
    if (!cookie.isEmpty()) {
        userApiInstance->addHeaders("Cookie", cookie);
    }
}

void API::logout()
{
    userApiInstance->addHeaders("Cookie", "");
    Worker::instance()->setCookie("");
    qDebug() << "cookie已清除";
}