#ifndef PLAYER_H
#define PLAYER_H

#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QObject>

class Player : public QObject
{
    Q_OBJECT
public:
    explicit Player(QObject *parent = nullptr);
    Q_INVOKABLE void addSignleToPlaylist(const QString &url);

private:
    QMediaPlayer *m_player = nullptr;
};

#endif // PLAYER_H