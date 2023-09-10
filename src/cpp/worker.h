#ifndef WORKER_H
#define WORKER_H

#include <QDebug>
#include <QDir>
#include <QObject>
#include <QSettings>
#include <QPointer>

class Worker : public QObject
{
    Q_OBJECT
public:
    static Worker *instance();
    explicit Worker(QObject *parent = nullptr);
    ~Worker();

    Q_INVOKABLE QString getCloseAction();
    Q_INVOKABLE QString getIsAsk();
    Q_INVOKABLE void setCloseAction(QString action);
    Q_INVOKABLE void setIsAsk(QString action);
    // 其他对象调用，获取cookie
    Q_INVOKABLE QString getCookie();
    // 设置cookie,保存到配置文件
    Q_INVOKABLE void setCookie(QString cookie);
    // 登录成功之后，保存cookie
    Q_INVOKABLE void saveCookie(QString cookie);

private:
    static QPointer<Worker> INSTANCE;
    QSettings *m_settings;
    // 配置件中读取到的关闭窗口行为
    QString m_closeAction;
    QString m_isAsk;
    QString m_cookie;
};

#endif // WORKER_H