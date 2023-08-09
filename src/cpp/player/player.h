#ifndef PLAYER_H
#define PLAYER_H

#include <QDir>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QObject>
#include <QSettings>
#include <QTime>

#include "network.h"
#include "playlistmodel.h"

class Player : public QObject
{
    Q_OBJECT
public:
    explicit Player(QObject *parent = nullptr);
    // 播放
    Q_INVOKABLE void play();
    // 播放指定下标的歌曲
    Q_INVOKABLE void play(int index);
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
                                         const QString &id,
                                         const QString &name,
                                         const QString &artist,
                                         const QString &pic,
                                         const QString &duration);

    // 添加歌单所有歌曲到播放列表
    Q_INVOKABLE void addPlaylistToPlaylist(const QString &url,
                                           const QString &id,
                                           const QString &namem,
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
    // 获取播放模式
    Q_INVOKABLE int getPlaybackMode();
    // 获取是否静音
    Q_INVOKABLE bool getMute();
    // 获取播放列表中的歌曲数量
    Q_INVOKABLE int getPlaylistSize();
    // 获取当前播放歌曲的下标
    Q_INVOKABLE int getCurrentIndex();
    // 获取音量
    Q_INVOKABLE int getVolume();
    // 获取播放列表数据
    Q_INVOKABLE QObject *getPlaylistModel();
    // 获取播放列表媒体数量
    Q_INVOKABLE int getMediaCount();
    // 设置音量
    Q_INVOKABLE void setVolume(int volume);
    // 设置是否静音
    Q_INVOKABLE void setMute(bool mute);
    // 设置播放模式
    Q_INVOKABLE void setPlaybackMode(int mode);
    // 添加歌单所有歌曲到播放列表
    Q_INVOKABLE void addAllSongsToPlaylist();
    // 清空播放列表
    Q_INVOKABLE void clearPlaylist();
    // 切换到单曲的播放列表
    Q_INVOKABLE void switchToSingleTrackMode();
    // 切换到歌单的播放列表
    Q_INVOKABLE void switchToPlaylistMode();
signals:
    void playStateChanged();
    void durationChanged();
    void positionChanged();
    void mediaCountChanged(int newMediaCount);
    void playlistCurrentIndexChanged();
    // 播放列表已被清空
    void playlistCleared();

private:
    void switchPlaybackMode(int mode);
public slots:
    void onPositionChanged(qint64 new_position);
    void onDurationChanged(qint64 duration);
    void onCurrentIndexChanged(int index);
    void onMediaCountChanged(int start, int end);
    void onSongUrlReplyFinished(QByteArray);

private:
    // 播放器配置文件
    QSettings *m_settings = nullptr;
    QMediaPlayer *m_player = nullptr;
    // 播放状态
    bool m_playState = false;
    // 播放进度
    qint64 m_position;
    // 总时长
    qint64 m_duration;
    // 音量
    int m_volume;
    // 是否静音
    int m_mute;
    // 播放模式
    QMediaPlaylist::PlaybackMode m_playbackMode;
    // 单曲播放列表
    QMediaPlaylist *m_singleTrackPlaylist = nullptr;
    PlaylistModel *m_singleTrackModel = nullptr;
    // 歌单播放列表
    QMediaPlaylist *m_playlist = nullptr;
    PlaylistModel *m_playlistModel = nullptr;
    // 当前播放列表
    PlaylistModel *m_currentModel = nullptr;
    QMediaPlaylist *m_currentPlaylist = nullptr;

    Network *m_network = nullptr;
};

#endif // PLAYER_H