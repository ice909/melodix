import QtQuick 2.0
import org.deepin.dtk 1.0 as D
import org.deepin.dtk.impl 1.0 as DI
pragma Singleton

Item {
    property string pageBackgroundColor: D.DTK.themeType === DI.ApplicationHelper.LightType ? "#fafafa" : "#252525"
    property string textColor: D.DTK.themeType === DI.ApplicationHelper.DarkType ? "#FFFFFF" : ""
    property string libraryButtonBoxBackground: D.DTK.themeType === DI.ApplicationHelper.LightType ? "#F8F8FF" : "#404040"
    property string mouseHoverColor: D.DTK.themeType === DI.ApplicationHelper.LightType ? Qt.rgba(255, 255, 255, 1) : Qt.rgba(255, 255, 255, 0.3)
    property string mousePressedColor: D.DTK.themeType === DI.ApplicationHelper.LightType ? Qt.rgba(0, 0, 0, 0.3) : Qt.rgba(255, 255, 255, 0.4)
    property string mouseReleasedColor: D.DTK.themeType === DI.ApplicationHelper.LightType ? Qt.rgba(0, 0, 0, 0.2) : Qt.rgba(255, 255, 255, 0.3)
    property string sidebarBackgroundColor: "transparent"
    property string sidebarRightBorderColor: D.DTK.themeType === DI.ApplicationHelper.LightType ? "#eee7e7e7" : "#ee252525"
    property int pageLeftPadding: 20

    function getTimestamp() {
        return Date.now();
    }

    function formatTime(time) {
        var date = new Date(time);
        var year = date.getFullYear(); // 年份
        var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 月份（注意要加1，因为月份从0开始）
        var day = date.getDate(); // 日期
        return year + '年' + month + '月' + day + '日';
    }

    function formatDuration(duration) {
        var minutes = Math.floor(duration / 60000);
        var seconds = Math.floor((duration % 60000) / 1000);
        return minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
    }

    function spliceSinger(singer) {
        var singerArr = [];
        for (var i = 0; i < singer.length; i++) {
            singerArr.push(singer[i].name);
        }
        return singerArr.join(",");
    }

    function formatDynamicTime(time) {
        var date = new Date(time);
        var year = date.getFullYear(); // 年份
        var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 月份（注意要加1，因为月份从0开始）
        var day = date.getDate(); // 日期
        // 如果是今年,就不返回年份,只返回月份和日期
        if (year === new Date().getFullYear())
            return month + '-' + day;

        return year + '-' + month + '-' + day;
    }

    // 格式化播放量
    function formatPlayCount(playCount) {
        if (playCount > 1e+08)
            return (playCount / 1e+08).toFixed(1) + "亿";
        else if (playCount > 10000)
            return (playCount / 10000).toFixed(1) + "万";
        else
            return playCount;
    }

    // 格式化视频时长
    function formatVideoDuration(duration) {
        // duration 单位是秒
        var minutes = Math.floor(duration / 60);
        var seconds = Math.floor(duration % 60);
        return (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
    }

}
