#include "network.h"

Network::Network(QObject *parent)
    : QObject(parent)
    , m_settings(new QSettings(QDir::homePath() + "/.config/ice/user.ini", QSettings::IniFormat))
{
    m_cookie = m_settings->value("cookieData", "").toString();
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
    manager = new QNetworkAccessManager(this);
    connect(manager, &QNetworkAccessManager::finished, this, &Network::replyFinished);
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
    if (m_request_cookies.size() > 0 && (api.startsWith("/login/status"))) {
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
    if (m_request_cookies.size() > 0) {
        // 设置请求头的Cookie值
        request.setHeader(QNetworkRequest::CookieHeader, QVariant::fromValue(m_request_cookies));
    }
    connect(m_manager, &QNetworkAccessManager::finished, this, &Network::onAccountInfoReplyFinished);
    m_manager->get(request);
}

void Network::saveCookie(QString cookie)
{
    m_cookie = cookie;
    m_settings->setValue("cookieData", m_cookie);
}