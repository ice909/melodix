#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QPointer>
#include <QSettings>

class Worker : public QObject
{
    Q_OBJECT
public:
    static Worker *instance();
    explicit Worker(QObject *parent = nullptr);
    ~Worker();

public slots:

    QString getCloseAction();
    QString getIsAsk();
    void setCloseAction(QString action);
    void setIsAsk(QString action);
    // 获取cookie
    QString getCookie();
    // 设置cookie,保存到配置文件
    void setCookie(QString cookie);
    // 登录成功之后，保存cookie
    void saveCookie(QString cookie);
    // 打开网站
    void openUrl(QString url);

private:
    static QPointer<Worker> INSTANCE;
    QSettings *m_settings;
    // 配置件中读取到的关闭窗口行为
    QString m_closeAction;
    QString m_isAsk;
    QString m_cookie;
};

#endif // WORKER_H