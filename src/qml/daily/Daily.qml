import "../../router"
import "../../util"
import "../widgets"
import Melodix.API 1.0
import Melodix.Player 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    // 歌曲数量
    property int count: 0
    // 歌曲列表
    property var songs: []
    // 当前选中的歌曲索引
    property int currentSelectIndex: -1
    property bool isAddToPlaylist: false
    property string currentPlaylistId: "每日推荐"

    function playPlaylistAllMusic(index = -1) {
        // 切换播放列表
        Player.switchToPlaylistMode();
        if (Player.getCurrentPlaylistId() != "" && Player.getCurrentPlaylistId() != currentPlaylistId) {
            Player.clearPlaylist();
            Player.setCurrentPlaylistId(currentPlaylistId);
        }
        for (var i = 0; i < songs.length; i++) {
            Player.addPlaylistToPlaylist(songs[i].id, songs[i].name, Util.spliceSinger(songs[i].ar), songs[i].al.picUrl, Util.formatDuration(songs[i].dt), songs[i].al.name, Util.isVip(songs[i].fee));
        }
        if (index != -1)
            Player.play(index);
        else
            Player.play(0);
        isAddToPlaylist = true;
    }

    function onPlaylistCurrentIndexChanged() {
        currentSelectIndex = Player.getCurrentIndex();
    }

    function onPlaylistCleared() {
        currentSelectIndex = -1;
    }

    Component.onCompleted: {
        API.getDailyRecommendSongs();
        Player.playlistCurrentIndexChanged.connect(onPlaylistCurrentIndexChanged);
        Player.playlistCleared.connect(onPlaylistCleared);
    }
    Component.onDestruction: {
        Player.playlistCurrentIndexChanged.disconnect(onPlaylistCurrentIndexChanged);
        Player.playlistCleared.disconnect(onPlaylistCleared);
    }

    Connections {
        function onDailyRecommendSongsCompleted(res) {
            songs = res.data.dailySongs;
            count = songs.length;
            for (const song of songs) {
                songListModel.append({
                    "song": song
                });
            }
            initing = false;
        }

        target: API
    }

    ListModel {
        id: songListModel
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        Column {
            id: body

            spacing: 20
            x: Util.pageLeftPadding
            y: 5

            Text {
                id: title

                text: "每日推荐"
                font.pixelSize: DTK.fontManager.t3.pixelSize
                color: "#000"
                anchors.left: parent.left
                anchors.leftMargin: 20
            }

            ListView {
                id: listView

                width: scrollWidth
                x: 20
                height: count * 55 + (count - 1) * 5 + 30
                spacing: 5
                model: songListModel
                clip: true

                delegate: ListViewDelegate {
                }

            }

        }

    }

    Rectangle {
        id: loadAnimation

        visible: initing
        anchors.fill: root
        color: Util.pageBackgroundColor

        Loading {
            anchors.centerIn: parent
        }

    }

}
