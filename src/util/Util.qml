import QtQuick 2.0
import org.deepin.dtk 1.0
pragma Singleton

Item {
    property string pageBackgroundColor: DTK.themeType === ApplicationHelper.LightType ? "#f7f7f7" : "#252525"
    property string backgroundColor: DTK.themeType === ApplicationHelper.LightType ? "transparent" : "#252525"
    property string textColor: DTK.themeType === ApplicationHelper.DarkType ? "#FFFFFF" : ""
    property string libraryButtonBoxBackground: DTK.themeType === ApplicationHelper.LightType ? "#F8F8FF" : "#404040"

    function getTimestamp() {
        return Math.floor(Date.now() / 1000);
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

}
