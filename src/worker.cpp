#include "worker.h"

#include <QDebug>
#include <QDesktopServices>
#include <QDir>
#include <QUrl>

QPointer<Worker> Worker::INSTANCE = nullptr;

Worker *Worker::instance()
{
    if (INSTANCE.isNull())
        INSTANCE = new Worker;

    return INSTANCE;
}

Worker::Worker(QObject *parent)
    : QObject(parent)
    , m_settings(
          new QSettings(QDir::homePath() + "/.config/ice/user.ini", QSettings::IniFormat, this))
{
    m_closeAction = m_settings->value("closeAction", 1).toString();
    m_isAsk = m_settings->value("isAsk", 1).toString();
    m_cookie = m_settings->value("cookie", "").toString();
}

QString Worker::getCookie()
{
    return m_cookie;
}

void Worker::saveCookie(QString cookie)
{
    if (!cookie.isEmpty()) {
        QStringList cookieList = cookie.split(';');
        foreach (QString cookieItem, cookieList) {
            cookieItem = cookieItem.trimmed();
            QList<QString> parts = cookieItem.split('=');
            if (parts.length() == 2) {
                QByteArray name = parts[0].trimmed().toUtf8();
                QByteArray value = parts[1].trimmed().toUtf8();
                if (name == "MUSIC_U") {
                    // 保存cookie到配置文件
                    setCookie(cookieItem);
                    return;
                }
            }
        }
    }
}

void Worker::setCookie(QString cookie)
{
    m_cookie = cookie;
    m_settings->setValue("cookie", m_cookie);
}

QString Worker::getCloseAction()
{
    return m_closeAction;
}

QString Worker::getIsAsk()
{
    return m_isAsk;
}

void Worker::setCloseAction(QString action)
{
    m_closeAction = action;
    m_settings->setValue("closeAction", m_closeAction);
}

void Worker::setIsAsk(QString action)
{
    m_isAsk = action;
    m_settings->setValue("isAsk", m_isAsk);
}

void Worker::openUrl(QString url)
{
    if (url.isEmpty())
        return;
    QDesktopServices::openUrl(QUrl(url));
}

Worker::~Worker() {}