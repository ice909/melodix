#ifndef PLAYLIST_H
#define PLAYLIST_H

#include <QObject>

class PlaylistModel;
class Playlist : public QObject
{
    Q_OBJECT
public:
    // 播放模式
    enum PlayMode {

        // 单曲循环
        CurrentItemInLoop = 0,
        // 循环播放
        Loop = 1,
        // 随机播放
        Random = 2,
    };

    explicit Playlist(QObject *parent = nullptr);

    void addSong(const int &id,
                 const QString &name,
                 const QString &artist,
                 const QString &pic,
                 const QString &duration,
                 const QString &album);
    // 切换下一首歌曲
    void next();
    // 切换上一首歌曲
    void previous();
    // 为随机播放模式准备随机下标
    int prepareRandomIndex();
    // 设置播放模式
    void setPlayMode(const PlayMode &playMode);
    // 获取播放列表数据
    PlaylistModel *getPlaylistModel();
    // 获取播放列表歌曲数量
    int getSongCount();
    // 设置当前播放歌曲下标
    void setCurrentIndex(const int &index);
    // 获取当前播放歌曲下标
    int getCurrentIndex();
    // 获取当前播放歌曲ID
    int getCurrentId();
    // 获取当前播放歌曲名
    QString getCurrentName();
    // 获取当前播放歌曲作者
    QString getCurrentArtist();
    // 获取当前播放歌曲图片
    QString getCurrentPic();
    // 获取当前播放歌曲所属专辑
    QString getCurrentAlbum();
    // 判断歌曲是否存在于播放列表
    int isSongExist(const int &id);
    // 将指定歌曲移动到最后
    void moveToLast(const int &index);
    // 清空播放列表
    void clear();

signals:
    void currentIndexChanged(int index);
    // 歌曲总数发生变化
    void songCountChanged(int count);

private:
    PlaylistModel *m_playlistModel = nullptr;
    // 当前播放的歌曲在播放列表中的下标
    int m_currentIndex = 0;
    // 播放列表歌曲数量
    int m_songCount = 0;
    // 播放模式
    PlayMode m_playMode = Loop;
    // 当前播放列表的ID
    int m_playlistId = 0;
};

#endif // PLAYLIST_H