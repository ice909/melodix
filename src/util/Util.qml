import QtQuick 2.0
import org.deepin.dtk 1.0 as D
import org.deepin.dtk.impl 1.0 as DI
pragma Singleton

Item {
    property string pageBackgroundColor: D.DTK.themeType === DI.ApplicationHelper.LightType ? "#f7f7f7" : "#252525"
    property string textColor: D.DTK.themeType === DI.ApplicationHelper.DarkType ? "#FFFFFF" : ""
    property string libraryButtonBoxBackground: D.DTK.themeType === DI.ApplicationHelper.LightType ? "#F8F8FF" : "#404040"
    property string mouseHoverColor: D.DTK.themeType === DI.ApplicationHelper.LightType ? Qt.rgba(0, 0, 0, 0.2) : Qt.rgba(255, 255, 255, 0.3)
    property string mousePressedColor: D.DTK.themeType === DI.ApplicationHelper.LightType ? Qt.rgba(0, 0, 0, 0.3) : Qt.rgba(255, 255, 255, 0.4)
    property string mouseReleasedColor: D.DTK.themeType === DI.ApplicationHelper.LightType ? Qt.rgba(0, 0, 0, 0.2) : Qt.rgba(255, 255, 255, 0.3)
    property string sidebarBlendColor: D.DTK.themeType === DI.ApplicationHelper.LightType ? "#bbf7f7f7" : "#dd252525"
    property string sidebarRightBorderColor: D.DTK.themeType === DI.ApplicationHelper.LightType ? "#eee7e7e7" : "#ee252525"
    property int pageLeftPadding: 10
    property string sidebarBgColorWhenlyricShow: D.DTK.themeType === DI.ApplicationHelper.LightType ? "#ffffff" : "#252525"

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

    function isVip(fee) {
        return fee === 1;
    }

}
