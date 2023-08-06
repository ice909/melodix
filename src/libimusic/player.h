#ifndef PLAYER_H
#define PLAYER_H

#include <QDir>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QObject>
#include <QSettings>
#include <QTime>

class Player : public QObject
{
    Q_OBJECT
public:
    explicit Player(QObject *parent = nullptr);
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
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
    Q_INVOKABLE void setVolume(int volume);
    Q_INVOKABLE int getVolume();
    Q_INVOKABLE void setMute(bool mute);
    Q_INVOKABLE bool getMute();
    Q_INVOKABLE int getPlaybackMode();
    Q_INVOKABLE void setPlaybackMode(int mode);

    void playNewlyAddedSong();
signals:
    void metaChanged();
    void playStateChanged();
    void durationChanged();
    void positionChanged();
public slots:
    void onPositionChanged(qint64 new_position);
    void onDurationChanged(qint64 duration);
    void onCurrentIndexChanged(int index);

private:
    QSettings *m_settings = nullptr;
    QMediaPlayer *m_player = nullptr;
    QMediaPlaylist *m_playlist = nullptr;
    bool m_playState = false;
    QList<QString> m_currentImg;
    QList<QString> m_currentSong;
    QList<QString> m_currentArtist;
    qint64 m_position;
    qint64 m_duration;
    int m_volume;
    int m_mute;
    QMediaPlaylist::PlaybackMode m_playbackMode;
};

#endif // PLAYER_H