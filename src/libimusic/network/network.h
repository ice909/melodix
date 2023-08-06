#ifndef NETWORK_H
#define NETWORK_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QObject>

class Network : public QObject
{
    Q_OBJECT
public:
    explicit Network(QObject *parent = nullptr);
    // qml发起请求函数
    Q_INVOKABLE void makeRequest(QString);
signals:
    void sendReplyFinished(QString);
public slots:
    Q_INVOKABLE void replyFinished(QNetworkReply *reply);

private:
    QNetworkAccessManager *manager = nullptr;
    QString BASE_URL = "http://81.70.119.233:3000";
};

#endif // NETWORK_H