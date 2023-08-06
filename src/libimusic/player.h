#ifndef PLAYER_H
#define PLAYER_H

#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QObject>
#include <QTime>

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
    Q_INVOKABLE qint64 getPosition();
    Q_INVOKABLE qint64 getDuration();
    Q_INVOKABLE QString getFormatPosition();
    Q_INVOKABLE QString getFormatDuration();
    Q_INVOKABLE bool getPlayState();
signals:
    void metaChanged();
    void playStateChanged();
    void durationChanged();
    void positionChanged();
public slots:
    void onPositionChanged(qint64 new_position);
    void onDurationChanged(qint64 duration);

private:
    QMediaPlayer *m_player = nullptr;
    bool m_playState = false;
    QString m_name;
    QString m_artist;
    QString m_pic;
    qint64 m_position;
    qint64 m_duration;
};

#endif // PLAYER_H