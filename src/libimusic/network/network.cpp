#include "network.h"

Network::Network(QObject *parent)
    : QObject(parent)
{
    manager = new QNetworkAccessManager(this);
    connect(manager, &QNetworkAccessManager::finished, this, &Network::replyFinished);
}

void Network::replyFinished(QNetworkReply *reply)
{
    emit sendReplyFinished(reply->readAll());
}

void Network::makeRequest(QString api)
{
    QNetworkRequest request;
    request.setUrl(QUrl(BASE_URL + api));
    manager->get(request);
}