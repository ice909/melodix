#ifndef PLAYER_H
#define PLAYER_H

#include <QJsonArray>
#include <QMediaPlayer>
#include <QObject>
#include <QSettings>

#include "playlist.h"

class API;
class PlaylistModel;
class MprisPlayer;
class Player : public QObject
{
    Q_OBJECT
public:
    static Player *instance();
    explicit Player(QObject *parent = nullptr);
    ~Player();

public slots:
    // 播放
    void play();
    // 播放指定下标的歌曲
    void play(int index);
    // 暂停
    void pause();
    // 停止
    void stop();
    // 播放或暂停
    void playOrPause();
    // 下一首
    void next();
    // 上一首
    void previous();
    // 添加单个歌曲到播放列表
    void addSingleToPlaylist(const int &id,
                             const QString &name,
                             const QString &artist,
                             const QString &pic,
                             const QString &duration,
                             const QString &album,
                             const bool &isVip);

    // 添加歌单所有歌曲到播放列表
    void addPlaylistToPlaylist(const int &id,
                               const QString &name,
                               const QString &artist,
                               const QString &pic,
                               const QString &duration,
                               const QString &album,
                               const bool &isVip);
    // 获取当前正在播放的歌曲ID
    int getId();
    // 获取当前正在播放的歌曲名
    QString getName();
    // 获取当前正在播放的歌曲作者
    QString getArtist();
    // 获取当前正在播放的歌曲图片Url
    QString getPic();
    // 获取当前歌曲播放进度
    qint64 getPosition();
    // 获取当前歌曲总时长
    qint64 getDuration();
    // 获取当前播放歌曲所属的专辑名
    QString getAlbum();
    // 获取格式化成字符串的歌曲播放进度
    QString getFormatPosition();
    // 获取格式化成字符串的歌曲总时长
    QString getFormatDuration();
    // 获取当前歌曲是否为VIP歌曲
    bool getIsVip();
    // 获取播放状态
    bool getPlayState();
    // 获取播放模式
    int getPlaybackMode();
    // 获取是否静音
    bool getMute();
    // 获取当前播放歌曲的下标
    int getCurrentIndex();
    // 获取音量
    int getVolume();
    // 获取播放列表数据
    QObject *getPlaylistModel();
    // 获取播放列表媒体数量
    int getMediaCount();
    // 获取当前播放列表第一首歌曲的id
    QString getCurrentPlaylistId();
    // 设置当前音乐播放进度
    void setPosition(qint64 newPosition);
    // 设置音量
    void setVolume(int volume);
    // 设置是否静音
    void setMute(bool mute);
    // 设置播放模式
    void setPlaybackMode(int mode);
    // 设置当前播放歌单Id
    void setCurrentPlaylistId(const QString &id);
    // 清空播放列表
    void clearPlaylist();
    // 切换到单曲的播放列表
    void switchToSingleTrackMode();
    // 根据歌曲ID去请求歌曲Url
    void getSongUrlById(const int &id);
    // 切换到歌单的播放列表
    void switchToPlaylistMode();
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
    void onMediaCountChanged(int count);
    // 获取歌曲Url,请求完成
    void onSongUrlReady(const QJsonArray &response);
    void onMediaStatusChanged(QMediaPlayer::MediaStatus status);

private:
    void initDBus();
    QVariantMap getMetadata();

private:
    // 当前播放歌曲的下标
    int m_currentIndex = 0;

    static QPointer<Player> INSTANCE;
    API *m_api = nullptr;
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
    Playlist::PlayMode m_playbackMode;
    // 单曲播放列表
    Playlist *m_singleTrackPlaylist = nullptr;
    // 歌单播放列表
    Playlist *m_playlist = nullptr;
    // 当前播放列表
    Playlist *m_currentPlaylist = nullptr;

    // 当前播放歌单的id
    QString m_currentPlaylistId = "";

    MprisPlayer *m_mprisPlayer = nullptr;
};

#endif // PLAYER_H