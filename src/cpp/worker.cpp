#include "worker.h"

QPointer<Worker> Worker::INSTANCE = nullptr;

Worker* Worker::instance(){
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

Worker::~Worker() {}