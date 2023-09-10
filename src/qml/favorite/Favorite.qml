import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property int scrollWidth: rootWindow.width - 40
    // 歌单所有歌曲是否以经全部添加到了播放列表
    property bool isAddToPlaylist: false
    property string myFavoriteId: ""
    property int playlistAllSongsCount: 0
    property int listViewCount: 0
    property int currentSelectIndex: -1
    // 保存添加到listview的数据
    property var songs: []
    // 保存添加到播放列表的歌曲url,以及可以作为判断已经添加到播放列表的歌曲数
    property var songUrls: []
    property bool initing: true
    // 一次取出的歌曲数量
    property int songlimit: 0
    // 偏移量
    property int offset: 0
    // 是否正在“加载更多”
    property bool loadMore: false
    // 是否加载完全部歌曲
    property bool hasMore: true

    function playPlaylistMusic(index = -1) {
        function onReply(reply) {
            network.onSongUrlRequestFinished.disconnect(onReply);
            var urlList = JSON.parse(reply).data;
            var urlOffset = songUrls.length;
            for (var i = 0; i < urlList.length; i++) {
                var song = urlList[i];
                songUrls[i + urlOffset] = song.url;

            }
            for (var i = urlOffset; i < songs.length; i++) {
                player.addPlaylistToPlaylist(songUrls[i], songs[i].id, songs[i].name, songs[i].al.picUrl, Util.spliceSinger(songs[i].ar), Util.formatDuration(songs[i].dt), Util.isVip(songs[i].fee));
            }
            if (index != -1)
                player.play(index);
            else
                player.play(0);
            player.setCurrentPlaylistId(myFavoriteId);
            if (songUrls.length == playlistAllSongsCount)
                isAddToPlaylist = true;

        }

        player.switchToPlaylistMode();
        if (player.getCurrentPlaylistId() != "" && player.getCurrentPlaylistId() != myFavoriteId) {
            console.log("当前歌单和播放列表中以添加的歌曲不是来自同一个歌单，先清空播放列表，再添加歌曲");
            player.clearPlaylist();
        }
        if (index != -1 && index < songUrls.length) {
            player.play(index);
            return;
        }
        var ids = [];
        for (var i = songUrls.length; i < songs.length; i++) ids.push(songs[i].id)
        // 将所有id使用逗号连接成一个字符串
        var concatenatedIds = ids.join(',');
        network.onSongUrlRequestFinished.connect(onReply);
        network.getSongUrl(concatenatedIds);
    }

    function getMyFavoriteSongs() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var newSongs = JSON.parse(reply).songs;
            songs.push(...newSongs);
            for (const song of newSongs) {
                songListModel.append({
                    "song": song
                });
            }
            listViewCount += newSongs.length;
            offset += newSongs.length;
            loadMore = false;
            initing = false;
            console.log("加载的歌曲数量: songlimit: " + songlimit + " offset: " + offset + " songs数组长度: " + songs.length);
        }

        if (playlistAllSongsCount - offset > 50) {
            songlimit = 50;
        } else {
            songlimit = playlistAllSongsCount - offset;
            hasMore = false;
        }
        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/playlist/track/all?id=" + myFavoriteId + "&limit=" + songlimit + "&offset=" + offset);
    }

    function getUserPlayLists() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var userPlaylists = JSON.parse(reply).playlist;
            // 第一个为我喜欢的歌单
            playlistAllSongsCount = userPlaylists[0].trackCount;
            myFavoriteId = userPlaylists[0].id;
            getMyFavoriteSongs();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/user/playlist?uid=" + userID + "&timestamp=" + Util.getTimestamp());
    }

    function onPlaylistCurrentIndexChanged() {
        currentSelectIndex = player.getCurrentIndex();
    }

    function onPlaylistCleared() {
        currentSelectIndex = -1;
    }

    Component.onCompleted: {
        player.playlistCurrentIndexChanged.connect(onPlaylistCurrentIndexChanged);
        player.playlistCleared.connect(onPlaylistCleared);
        getUserPlayLists();
    }
    Component.onDestruction: {
        player.playlistCurrentIndexChanged.disconnect(onPlaylistCurrentIndexChanged);
        player.playlistCleared.disconnect(onPlaylistCleared);
    }

    ListModel {
        id: songListModel
    }

    // 歌单详情页
    ScrollView {
        anchors.fill: parent
        clip: true
        ScrollBar.vertical.onPositionChanged: () => {
            const position = ScrollBar.vertical.position + ScrollBar.vertical.size;
            if (position > 0.99 && !loadMore && hasMore) {
                console.log("position: " + position + " 滚动到底部，加载更多");
                loadMore = true;
                getMyFavoriteSongs();
            }
        }

        Column {
            spacing: 20
            x: 20
            y: 5

            Item {
                width: scrollWidth
                height: 40

                Row {
                    anchors.fill: parent
                    spacing: 10

                    RoundedImage {
                        height: parent.height
                        width: height
                        borderRadius: height
                        imgSrc: userAvatar
                    }

                    Text {
                        text: userNickname + "喜欢的音乐"
                        font.pixelSize: DTK.fontManager.t3.pixelSize
                        color: Util.textColor
                    }

                }

            }

            ListView {
                id: listView

                width: scrollWidth
                x: 20
                height: listViewCount * 55 + (listViewCount - 1) * 5 + 30
                spacing: 5
                model: songListModel
                clip: true

                delegate: ItemDelegate {
                    width: listView.width - 40
                    height: 55
                    backgroundVisible: false
                    checked: index == currentSelectIndex
                    onClicked: {
                        console.log("点击的歌曲索引: " + index);
                        currentSelectIndex = index;
                        if (!isAddToPlaylist)
                            playPlaylistMusic(index);
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
                                text: Util.spliceSinger(modelData.ar)
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
                            text: Util.formatDuration(modelData.dt)
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
        color: Util.pageBackgroundColor

        Loading {
            anchors.centerIn: parent
        }

    }

    BusyIndicator {
        id: indicator

        visible: loadMore
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        running: true
        width: 20
        height: 20
    }

}
