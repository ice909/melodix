#ifndef GLOBAL_H
#define GLOBAL_H

#include "libimusic_global.h"

#include <QObject>

class LIBIMUSICSHARED_EXPORT Global : public QObject
{
    Q_OBJECT
    Q_ENUMS(PlaybackStatus)
    Q_ENUMS(PlaybackMode)
    Q_ENUMS(MimeType)
    Q_ENUMS(PlaylistSortType)
public:
    enum PlaybackStatus {
        Idle = 0,  //闲置
        Opening,   //开放
        Buffering, //缓冲
        Playing,   //播放
        Paused,    //暂停
        Stopped,   //停止
        Ended,     //结束
        Error      //错误
    };
    enum PlaybackMode {
        RepeatNull = -1, //不循环
        RepeatAll,       //列表循环
        RepeatSingle,    //单曲循环
        Shuffle,         //随机
    };
    enum MimeType {
        MimeTypeOther = -1, //其他类型
        MimeTypeLocal,      //本地类型
        MimeTypeCDA,        //CDA类型
        MimeTypeNet         //网络类型
    };

    enum PlaylistSortType {
        SortByNull = -1,  //不排序
        SortByAddTimeASC, //按添加时间升序排序
        SortByTitleASC,   //按标题升序排序
        SortByArtistASC,  //按艺术家升序排序
        SortByAblumASC,   //按专辑升序排序
        SortByCustomASC,  //按自定义升序排序
        SortByAddTimeDES, //按添加时间降序排序
        SortByTitleDES,   //按标题降序排序
        SortByArtistDES,  //按艺术家降序排序
        SortByAblumDES,   //按专辑降序排序
        SortByCustomDES,  //按自定义降序排序
        SortByAddTime,    //按添加时间排序 //10
        SortByTitle,      //按标题排序
        SortByArtist,     //按艺术家排序
        SortByAblum,      //按专辑排序
        SortByCustom,     //按自定义排序
    };

    explicit Global(QObject *parent = nullptr);

    // 设置应用名称
    static void setAppName(const QString &name);
    // 获取应用名称
    static QString getAppName();
};
Q_DECLARE_METATYPE(Global::PlaybackStatus)
Q_DECLARE_METATYPE(Global::PlaybackMode)
Q_DECLARE_METATYPE(Global::MimeType)
Q_DECLARE_METATYPE(Global::PlaylistSortType)

#endif // GLOBAL_H