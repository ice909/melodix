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
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void addSignleToPlaylist(const QString &url,
                                         const QString &name,
                                         const QString &artist,
                                         const QString &pic);
    Q_INVOKABLE QString getName();
    Q_INVOKABLE QString getArtist();
    Q_INVOKABLE QString getPic();
    Q_INVOKABLE bool getPlayState();
signals:
    void metaChanged();
    void playStateChanged();
public slots:

private:
    QMediaPlayer *m_player = nullptr;
    bool m_playState = false;
    QString m_name;
    QString m_artist;
    QString m_pic;
};

#endif // PLAYER_H