import "../../router"
import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property int scrollWidth: rootWindow.width - 40
    property bool isAddToPlaylist: false
    property string currentPlaylistId: ""
    property var songs: []
    property var songUrls: []
    property int listViewCount: 0
    property int songLimit: 50
    property bool initing: true
    property int currentSelectIndex: -1
    property int playlistSongCount: 0

    function formatTime(time) {
        var date = new Date(time);
        var year = date.getFullYear(); // 年份
        var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 月份（注意要加1，因为月份从0开始）
        var day = date.getDate(); // 日期
        return year + '年' + month + '月' + day + '日';
    }

    function getPlaylistSongsInfo() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            songs = JSON.parse(reply).songs;
            listViewCount = songs.length;
            listView.model = songs;
            initing = false;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/playlist/track/all?id=" + currentPlaylistId + "&limit=" + songLimit);
    }

    function getPlaylistDetail() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var playlist = JSON.parse(reply).playlist;
            coverImg.imgSrc = playlist.coverImgUrl;
            playlistName.text = playlist.name;
            playlistAuthor.text = "Playlist by " + playlist.creator.nickname;
            playlistUpdateTime.text = "最后更新于 " + formatTime(playlist.updateTime) + " · " + playlist.trackIds.length + "首歌";
            if (playlist.description != null)
                playlistDescription.text = playlist.description.replace(/\n/g, ' ');
            else
                playlistDescription.text = "暂无介绍";
            getPlaylistSongsInfo();
            playlistSongCount = playlist.trackIds.length;
            console.log("歌单共有：" + playlist.trackIds.length + "首歌曲");
            if (playlist.trackIds.length > 50)
                songLimit = 50;
            else
                songLimit = playlist.trackIds.length;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/playlist/detail?id=" + currentPlaylistId);
    }

    function playPlaylistAllMusic(index = -1) {
        function onReply(reply) {
            network.onSongUrlRequestFinished.disconnect(onReply);
            var urlList = JSON.parse(reply).data;
            for (var i = 0; i < urlList.length; i++) {
                var song = urlList[i];
                var songIndex = ids.indexOf(song.id);
                if (songIndex !== -1)
                    songUrls[songIndex] = song.url;

            }
            for (var i = 0; i < songs.length; i++) {
                player.addPlaylistToPlaylist(songUrls[i], songs[i].id, songs[i].name, songs[i].al.picUrl, songs[i].ar[0].name, formatDuration(songs[i].dt));
            }
            if (index != -1)
                player.play(index);
            else
                player.play(0);
            player.setCurrentPlaylistId(currentPlaylistId);
            isAddToPlaylist = true;
        }

        player.switchToPlaylistMode();
        if (player.getCurrentPlaylistId() != "" && player.getCurrentPlaylistId() != currentPlaylistId) {
            console.log("当前歌单和播放列表中以添加的歌曲不是来自同一个歌单，先清空播放列表，再添加歌曲");
            player.clearPlaylist();
        }
        var ids = songs.map(function(song) {
            return song.id;
        });
        // 将所有id使用逗号连接成一个字符串
        var concatenatedIds = ids.join(',');
        network.onSongUrlRequestFinished.connect(onReply);
        network.getSongUrl(concatenatedIds);
    }

    function onPlaylistCurrentIndexChanged() {
        currentSelectIndex = player.getCurrentIndex();
    }

    function onPlaylistCleared() {
        currentSelectIndex = -1;
    }

    Component.onCompleted: {
        console.log("跳转歌单id为： " + Router.routeCurrent.id);
        currentPlaylistId = Router.routeCurrent.id;
        getPlaylistDetail();
        player.playlistCurrentIndexChanged.connect(onPlaylistCurrentIndexChanged);
        player.playlistCleared.connect(onPlaylistCleared);
    }
    Component.onDestruction: {
        console.log("歌单详情页销毁，断开信号的连接");
        player.playlistCurrentIndexChanged.disconnect(onPlaylistCurrentIndexChanged);
        player.playlistCleared.disconnect(onPlaylistCleared);
    }

    // 歌单详情页
    ScrollView {
        anchors.fill: parent
        clip: true

        Column {
            id: body

            spacing: 20
            x: 20
            y: 5

            Item {
                width: 20
                height: 20
            }

            Row {
                spacing: 30

                Item {
                    width: 1
                    height: 1
                }

                RoundedImage {
                    id: coverImg

                    width: scrollWidth / 3.9
                    height: width
                }

                Rectangle {
                    width: scrollWidth - coverImg.width - 10 - 30 - 10 - 30
                    height: coverImg.height
                    color: "transparent"

                    Column {
                        anchors.fill: parent
                        spacing: 10

                        Item {
                            width: 10
                            height: 10
                        }

                        Text {
                            id: playlistName

                            width: parent.width
                            height: (parent.height - 40) / 4 - 10
                            font.pixelSize: DTK.fontManager.t3.pixelSize
                            font.bold: true
                        }

                        Rectangle {
                            width: parent.width
                            height: (parent.height - 40) / 4
                            color: "transparent"

                            Text {
                                id: playlistAuthor

                                width: parent.width
                                height: parent.height / 2
                                font.pixelSize: DTK.fontManager.t4.pixelSize
                                font.bold: true
                            }

                            Text {
                                id: playlistUpdateTime

                                anchors.top: playlistAuthor.bottom
                                width: parent.width
                                height: parent.height / 2
                                font.pixelSize: DTK.fontManager.t5.pixelSize
                            }

                        }

                        Label {
                            id: playlistDescription

                            width: parent.width
                            height: (parent.height - 40) / 4 + 10
                            wrapMode: Text.Wrap
                            elide: Text.ElideRight
                            maximumLineCount: 3
                            font.pixelSize: DTK.fontManager.t6.pixelSize
                        }

                        Rectangle {
                            width: parent.width
                            height: (parent.height - 40) / 4
                            color: "transparent"

                            Row {
                                spacing: 20

                                RecommandButton {
                                    width: 80
                                    height: 40
                                    text: "播放"
                                    font.bold: true
                                    font.pixelSize: DTK.fontManager.t6.pixelSize
                                    onClicked: {
                                        console.log("播放按钮点击");
                                        if (!isAddToPlaylist)
                                            playPlaylistAllMusic();
                                        else
                                            player.play(0);
                                    }

                                    icon {
                                        name: "details_play"
                                        width: 25
                                        height: 25
                                    }

                                }

                            }

                        }

                    }

                }

            }

            ListView {
                id: listView

                width: scrollWidth
                x: 20
                height: listViewCount * 55 + (listViewCount - 1) * 5 + 30
                spacing: 5
                clip: true

                delegate: ItemDelegate {
                    width: listView.width - 40
                    height: 55
                    backgroundVisible: false
                    checked: index == currentSelectIndex
                    onClicked: {
                        console.log("clicked index : " + index);
                        currentSelectIndex = index;
                        if (!isAddToPlaylist)
                            playPlaylistAllMusic(index);
                        else
                            player.play(index);
                    }

                    RowLayout {
                        anchors.fill: parent

                        RoundedImage {
                            Layout.leftMargin: 10
                            imgSrc: modelData.al.picUrl
                            height: 45
                            width: 45
                        }

                        Item {
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignVCenter
                            Layout.leftMargin: 5
                            height: 45

                            Label {
                                id: title

                                width: 280
                                text: modelData.name
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.topMargin: 2.5
                                font.bold: true
                                elide: Qt.ElideRight
                            }

                            Label {
                                width: 280
                                text: modelData.ar[0].name
                                anchors.left: parent.left
                                anchors.top: title.bottom
                                elide: Qt.ElideRight
                            }

                        }

                        Label {
                            text: modelData.al.name
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Label {
                            Layout.rightMargin: 10
                            font.bold: true
                            text: rootWindow.formatDuration(modelData.dt)
                        }

                    }

                }

            }

        }

    }

    Rectangle {
        id: loadAnimation

        visible: initing
        anchors.fill: root

        Loading {
            anchors.centerIn: parent
        }

    }

}
