#ifndef WORKER_H
#define WORKER_H

#include <QDebug>
#include <QDir>
#include <QObject>
#include <QSettings>

class Worker : public QObject
{
    Q_OBJECT
public:
    explicit Worker(QObject *parent = nullptr);
    ~Worker();

    Q_INVOKABLE QString getCloseAction();
    Q_INVOKABLE QString getIsAsk();
    Q_INVOKABLE void setCloseAction(QString action);
    Q_INVOKABLE void setIsAsk(QString action);

private:
    QSettings *m_settings;
    // 配置件中读取到的关闭窗口行为
    QString m_closeAction;
    QString m_isAsk;
};

#endif // WORKER_H