#ifndef PLAYER_H
#define PLAYER_H

#include <QDir>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QObject>
#include <QSettings>
#include <QTime>

#include "playlistmodel.h"

class Player : public QObject
{
    Q_OBJECT
public:
    explicit Player(QObject *parent = nullptr);
    // 播放
    Q_INVOKABLE void play();
    // 暂停
    Q_INVOKABLE void pause();
    // 停止
    Q_INVOKABLE void stop();
    // 下一首
    Q_INVOKABLE void next();
    // 上一首
    Q_INVOKABLE void previous();
    // 添加单个歌曲到播放列表
    Q_INVOKABLE void addSignleToPlaylist(const QString &url,
                                         const QString &name,
                                         const QString &artist,
                                         const QString &pic,
                                         const QString &duration);
    // 获取当前正在播放的歌曲名
    Q_INVOKABLE QString getName();
    // 获取当前正在播放的歌曲作者
    Q_INVOKABLE QString getArtist();
    // 获取当前正在播放的歌曲图片Url
    Q_INVOKABLE QString getPic();
    // 获取当前歌曲播放进度
    Q_INVOKABLE qint64 getPosition();
    // 获取当前歌曲总时长
    Q_INVOKABLE qint64 getDuration();
    // 获取格式化成字符串的歌曲播放进度
    Q_INVOKABLE QString getFormatPosition();
    // 获取格式化成字符串的歌曲总时长
    Q_INVOKABLE QString getFormatDuration();
    // 获取播放状态
    Q_INVOKABLE bool getPlayState();
    // 设置音量
    Q_INVOKABLE void setVolume(int volume);
    // 获取音量
    Q_INVOKABLE int getVolume();
    // 设置是否静音
    Q_INVOKABLE void setMute(bool mute);
    // 获取是否静音
    Q_INVOKABLE bool getMute();
    // 获取播放模式
    Q_INVOKABLE int getPlaybackMode();
    // 设置播放模式
    Q_INVOKABLE void setPlaybackMode(int mode);
    // 获取播放列表数据
    Q_INVOKABLE QObject *getPlaylistModel();
    // 获取播放列表中的歌曲数量
    Q_INVOKABLE int getPlaylistSize();
    // 获取当前播放歌曲的下标
    Q_INVOKABLE int getCurrentIndex();
    // 播放指定下标的歌曲
    Q_INVOKABLE void playNewlyAddedSong(int index);
    // 播放新添加的歌曲
    void playNewlyAddedSong();
    // 清空播放列表
    Q_INVOKABLE void clearPlaylist();
signals:
    void playStateChanged();
    void durationChanged();
    void positionChanged();
    void mediaCountChanged(int newMediaCount);
    void playlistCurrentIndexChanged();
    // 播放列表已被清空
    void playlistCleared();
public slots:
    void onPositionChanged(qint64 new_position);
    void onDurationChanged(qint64 duration);
    void onCurrentIndexChanged(int index);
    void onMediaCountChanged(int start, int end);

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

    PlaylistModel *m_playlistModel = nullptr;
};

#endif // PLAYER_H