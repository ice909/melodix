#ifndef MELODIX_API_H
#define MELODIX_API_H

#include <MDClientApi.h>
#include <QObject>
#include <QPointer>

using namespace MelodixAPI;

class API : public QObject
{
    Q_OBJECT
public:
    static API *instance();
    explicit API(QObject *parent = nullptr);
    ~API();

public slots:
    void addCookie();
    void logout();
    void banner(const int type);
    void getRecommendedPlaylist(const int limit);
    void getRecommendedPlaylist(const int limit, const int offset);
    void getRecommendResource();
    void getRecommendedNewSongs(const int limit);
    void getTopArtists();
    void getTopPlaylist(const QString cat, const QString order, const int limit, const int offset);
    void getLoginStatus();
    void getAccountInfo();
    void getUserLikeSongIds(const QString id);
    void getSongUrl(const QString id);
    void getPlaylistDetail(const QString id);
    void getPlaylistSongs(const QString id);
    void getPlaylistSongs(const QString id, const int limit, const int offset);
    void getUserPlaylist(const QString id);
    void getLyric(const QString id);
    void getUserBuyAlbum();
    void getArtistSublist();
    void getArtistDetail(const QString id);
    void getArtistAlbum(const QString id);
    void getArtistSongs(const QString id);
    void search(const QString keyword);
    void search(const QString keyword, const int limit, const int offset);
    void likeMusic(const QString id, const QString like);
    void getQrKey();
    void generateQRCode(const QString unikey);
    void qrCheck(const QString unikey);
    void getCaptcha(const int phone);
    void verifyCaptcha(const int phone, const int captcha);
    void phoneLogin(const int phone, const QString password);
    void phoneLogin(const int phone, const QString password, const int captcha);
    void getUserDetail(const QString uid);
    void getDailyRecommendSongs();
signals:
    void bannerCompleted(QJsonArray);
    void recommendedPlaylistCompleted(QJsonArray);
    void recommendedNewSongsCompleted(QJsonArray);
    void topArtistsCompleted(QJsonArray);
    void topPlaylistCompleted(QJsonObject);
    void loginStatusCompleted(QJsonObject);
    void accountInfoCompleted(QJsonObject);
    void userLikeSongIdsCompleted(QJsonObject);
    void songUrlCompleted(QJsonArray);
    void playlistDetailCompleted(QJsonObject);
    void playlistSongsCompleted(QJsonArray);
    void userPlaylistCompleted(QJsonArray);
    void lyricCompleted(QString);
    void userBuyAlbumCompleted(QJsonArray);
    void artistSublistCompleted(QJsonArray);
    void artistDetailCompleted(QJsonObject);
    void artistAlbumCompleted(QJsonArray);
    void artistSongsCompleted(QJsonArray);
    void searchCompleted(QJsonObject);
    void likeMusicCompleted(QJsonObject);
    void getQrKeyCompleted(QJsonObject);
    void createQRCodeCompleted(QJsonObject);
    void qrCheckCompleted(QJsonObject);
    void sendCaptchaCompleted();
    void verifyCaptchaCompleted(QJsonObject);
    void cellphoneLoginCompleted(QJsonObject);
    void userDetailCompleted(QJsonObject);
    void dailyRecommendSongsCompleted(QJsonArray);

private:
    static QPointer<API> INSTANCE;
    MDClientApi *apiInstance = nullptr;
    MDClientApi *userApiInstance = nullptr;
};

#endif // MELODIX_API_H