#include "network.h"

Network::Network(QObject *parent)
    : QObject(parent)
    , m_settings(new QSettings(QDir::homePath() + "/.config/ice/user.ini", QSettings::IniFormat))
{
    m_cookie = m_settings->value("cookieData", "").toString();
    parseCookie();
    manager = new QNetworkAccessManager(this);
    connect(manager, &QNetworkAccessManager::finished, this, &Network::replyFinished);
}

void Network::parseCookie()
{
    m_request_cookies.clear();
    if (!m_cookie.isEmpty()) {
        QStringList cookieList = m_cookie.split(';');
        foreach (QString cookieItem, cookieList) {
            cookieItem = cookieItem.trimmed();
            QList<QString> parts = cookieItem.split('=');
            if (parts.length() == 2) {
                QByteArray name = parts[0].trimmed().toUtf8();
                QByteArray value = parts[1].trimmed().toUtf8();
                QNetworkCookie cookie(name, value);
                m_request_cookies.append(cookie);
            }
        }
    }
}

void Network::replyFinished(QNetworkReply *reply)
{
    emit sendReplyFinished(reply->readAll());
}

void Network::onAccountInfoReplyFinished(QNetworkReply *reply)
{
    emit accountReplyFinished(reply->readAll());
}

void Network::makeRequest(QString api)
{
    QNetworkRequest request;
    request.setUrl(QUrl(BASE_URL + api));
    if (!m_cookie.isEmpty()
        && (api.startsWith("/song/url") || api.startsWith("/user/playlist")
            || api.startsWith("/playlist/track/all") || api.startsWith("/digitalAlbum/purchased")
            || api.startsWith("/artist/sublist") || api.startsWith("/mv/sublist"))) {
        // 设置请求头的Cookie值
        request.setHeader(QNetworkRequest::CookieHeader, QVariant::fromValue(m_request_cookies));
    }

    manager->get(request);
}

void Network::accountInfo(QString api)
{
    QNetworkAccessManager *m_manager = new QNetworkAccessManager(this);
    QNetworkRequest request;
    request.setUrl(QUrl(BASE_URL + api));
    if (!m_cookie.isEmpty()) {
        // 设置请求头的Cookie值
        request.setHeader(QNetworkRequest::CookieHeader, QVariant::fromValue(m_request_cookies));
    }
    connect(m_manager, &QNetworkAccessManager::finished, this, &Network::onAccountInfoReplyFinished);
    m_manager->get(request);
}

void Network::getSongUrl(QString id)
{
    QNetworkAccessManager *m_url_manager = new QNetworkAccessManager(this);
    QNetworkRequest request;
    request.setUrl(QUrl(BASE_URL + "/song/url?id=" + id));
    if (!m_cookie.isEmpty()) {
        // 设置请求头的Cookie值
        request.setHeader(QNetworkRequest::CookieHeader, QVariant::fromValue(m_request_cookies));
    }
    connect(m_url_manager, &QNetworkAccessManager::finished, this, &Network::onSongUrlReplyFinished);
    m_url_manager->get(request);
}

void Network::onSongUrlReplyFinished(QNetworkReply *reply)
{
    emit songUrlRequestFinished(reply->readAll());
}

void Network::saveCookie(QString cookie)
{
    m_cookie = cookie;
    m_settings->setValue("cookieData", m_cookie);
    parseCookie();
}

void Network::logout()
{
    m_cookie = "";
    m_settings->setValue("cookieData", m_cookie);
    m_request_cookies.clear();
    qDebug() << "logout: cookie清除完毕";
}