import "../../router"
import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property string currentPlaylistId: ""
    property int selectedIndex: -1
    property bool initing: true
    property var songs: []
    property var songUrls: []
    property int scrollWidth: rootWindow.width - 40
    // 是否已经将歌单全部歌曲添加到了播放列表
    property bool isAddToPlaylist: false
    // 搜索到的歌曲总量
    property int songListCount: 0
    // 歌曲偏移量
    property int offset: 0
    // 一次加载的歌曲数量
    property int songLimit: 0
    // 是否正在“加载更多”
    property bool loadMore: false
    // 是否加载完全部歌曲
    property bool hasMore: true
    property int imgCellRectWidth: 45
    property int timeRectWidth: 54
    property int spacingWidth: 10
    property int serialNumberWidth: 20

    function getSearchSongsInfo() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var newSongs = JSON.parse(reply).result.songs;
            songs.push(...newSongs);
            for (const song of newSongs) listView.model.append({
                "song": song
            })
            initing = false;
            offset += newSongs.length;
            loadMore = false;
            console.log("加载的歌曲数量: songLimit: " + songLimit + " offset: " + offset + " songs数组长度: " + songs.length);
        }

        if (songListCount - offset > 50) {
            songLimit = 50;
        } else {
            songLimit = songListCount - offset;
            hasMore = false;
        }
        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/cloudsearch?keywords=" + Router.routeCurrent.key + "&offset=" + offset + "&limit=" + songLimit);
    }

    function getSearchResult(offset = 0) {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var result = JSON.parse(reply).result;
            songListCount = result.songCount;
            console.log("搜索到的歌曲共有：" + songListCount + "首");
            getSearchSongsInfo();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/cloudsearch?keywords=" + Router.routeCurrent.key);
    }

    function playSearchAllMusic(index = -1) {
        function onReply(reply) {
            network.onSongUrlRequestFinished.disconnect(onReply);
            var urlList = JSON.parse(reply).data;
            var urlOffset = songUrls.length;
            for (var i = 0; i < urlList.length; i++) {
                var song = urlList[i];
                var songIndex = ids.indexOf(song.id);
                if (songIndex !== -1)
                    songUrls[songIndex + urlOffset] = song.url;

            }
            for (var i = urlOffset; i < songs.length; i++) {
                player.addPlaylistToPlaylist(songUrls[i], songs[i].id, songs[i].name, songs[i].al.picUrl, songs[i].ar[0].name, Util.formatDuration(songs[i].dt));
            }
            if (index != -1)
                player.play(index);
            else
                player.play(0);
            player.setCurrentPlaylistId(currentPlaylistId);
            if (songUrls.length == songListCount)
                isAddToPlaylist = true;

        }

        player.switchToPlaylistMode();
        if (player.getCurrentPlaylistId() != "" && player.getCurrentPlaylistId() != currentPlaylistId) {
            console.log("当前歌单和播放列表中以添加的歌曲不是来自同一个歌单，先清空播放列表，再添加歌曲");
            player.clearPlaylist();
        }
        var ids = [];
        for (var i = songUrls.length; i < songs.length; i++) ids.push(songs[i].id)
        // 将所有id使用逗号连接成一个字符串
        var concatenatedIds = ids.join(',');
        network.onSongUrlRequestFinished.connect(onReply);
        network.getSongUrl(concatenatedIds);
    }

    function onPlaylistCurrentIndexChanged() {
        selectedIndex = player.getCurrentIndex();
    }

    Component.onCompleted: {
        getSearchResult();
        currentPlaylistId = Router.routeCurrent.key;
        player.playlistCurrentIndexChanged.connect(onPlaylistCurrentIndexChanged);
    }
    Component.onDestruction: {
        player.playlistCurrentIndexChanged.disconnect(onPlaylistCurrentIndexChanged);
    }

    ListModel {
        id: songListModel
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: 30 * 2 + 5 + 20 + listView.height
        ScrollBar.vertical.onPositionChanged: () => {
            const position = ScrollBar.vertical.position + ScrollBar.vertical.size;
            if (position > 0.99 && !loadMore && hasMore) {
                console.log("position: " + position + " 滚动到底部，加载更多");
                loadMore = true;
                getSearchSongsInfo();
            }
        }

        Column {
            id: body

            spacing: 20
            x: 20
            y: 5

            Rectangle {
                width: scrollWidth
                height: 30
                color: "transparent"

                Row {
                    anchors.fill: parent
                    spacing: 10
                    leftPadding: 10

                    Rectangle {
                        width: 15
                        height: 30
                        color: "transparent"
                    }

                    Rectangle {
                        width: imgCellRectWidth + (scrollWidth - timeRectWidth - serialNumberWidth - imgCellRectWidth - 10 - 50) / 3
                        height: 30
                        color: "transparent"

                        Label {
                            text: "歌曲名"
                            font.bold: true
                            font.pixelSize: DTK.fontManager.t5.pixelSize
                            anchors.verticalCenter: parent.verticalCenter
                            color: Util.textColor
                        }

                    }

                    Rectangle {
                        width: (scrollWidth - imgCellRectWidth - timeRectWidth - serialNumberWidth - 50 - 10) / 3
                        height: 30
                        color: "transparent"

                        Label {
                            text: "艺人"
                            font.bold: true
                            font.pixelSize: DTK.fontManager.t5.pixelSize
                            anchors.verticalCenter: parent.verticalCenter
                            color: Util.textColor
                        }

                    }

                    Rectangle {
                        width: (scrollWidth - imgCellRectWidth - timeRectWidth - serialNumberWidth - 50 - 10) / 3
                        height: 30
                        color: "transparent"

                        Label {
                            text: "专辑"
                            font.bold: true
                            font.pixelSize: DTK.fontManager.t5.pixelSize
                            anchors.verticalCenter: parent.verticalCenter
                            color: Util.textColor
                        }

                    }

                    Rectangle {
                        width: (scrollWidth - imgCellRectWidth - timeRectWidth - serialNumberWidth - 50 - 10) / 3
                        height: 30
                        color: "transparent"

                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "时长"
                            font.bold: true
                            font.pixelSize: DTK.fontManager.t5.pixelSize
                            color: Util.textColor
                        }

                    }

                }

            }

            ListView {
                id: listView

                width: scrollWidth
                height: offset * 56
                model: songListModel

                delegate: ItemDelegate {
                    width: scrollWidth
                    height: 56
                    backgroundVisible: index % 2 === 0
                    hoverEnabled: true
                    checked: index === selectedIndex

                    MouseArea {
                        id: mouseArea

                        acceptedButtons: Qt.RightButton | Qt.LeftButton
                        anchors.fill: parent
                        onDoubleClicked: {
                            console.log("clicked index : " + index);
                            selectedIndex = index;
                            if (!isAddToPlaylist)
                                playSearchAllMusic(index);
                            else
                                player.play(index);
                        }
                    }

                    RowLayout {
                        anchors.fill: parent

                        Label {
                            id: serialNumber

                            Layout.preferredWidth: 20
                            Layout.leftMargin: 10
                            text: index + 1
                            Layout.alignment: Qt.AlignVCenter
                        }

                        RoundedImage {
                            id: imagecell

                            Layout.preferredWidth: imgCellRectWidth
                            height: imgCellRectWidth
                            Layout.alignment: Qt.AlignVCenter
                            imgSrc: modelData.al.picUrl
                        }

                        Label {
                            id: musicNameLabel

                            Layout.preferredWidth: (scrollWidth - imagecell.width - timeRectWidth - serialNumber.width - imgCellRectWidth - 10 - 50) / 3
                            height: 20
                            elide: Text.ElideRight
                            text: modelData.name
                            Layout.alignment: Qt.AlignVCenter
                            font: DTK.fontManager.t6
                        }

                        Label {
                            id: musicSingerLabel

                            Layout.preferredWidth: (scrollWidth - imagecell.width - timeRectWidth - serialNumber.width - 50 - 10) / 3
                            height: 20
                            elide: Text.ElideRight
                            text: modelData.ar[0].name
                            Layout.alignment: Qt.AlignVCenter
                            font: DTK.fontManager.t6
                        }

                        Label {
                            id: musicAlbumLabel

                            Layout.preferredWidth: (scrollWidth - imagecell.width - timeRectWidth - serialNumber.width - 50 - 10) / 3
                            height: 20
                            elide: Text.ElideRight
                            text: modelData.al.name
                            Layout.alignment: Qt.AlignVCenter
                            font: DTK.fontManager.t6
                        }

                        Label {
                            id: musicTimeLabel

                            Layout.preferredWidth: timeRectWidth
                            height: parent.height
                            elide: Text.ElideRight
                            text: Util.formatDuration(modelData.dt)
                            verticalAlignment: Qt.AlignVCenter
                            Layout.alignment: Qt.AlignVCenter
                            font: DTK.fontManager.t6
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
        color: Util.backgroundColor

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
