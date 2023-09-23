import "../../router"
import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property string currentPlaylistId: ""
    property int currentSelectIndex: -1
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
    property int limit: 0
    // 是否正在“加载更多”
    property bool loadMore: false
    // 是否加载完全部歌曲
    property bool hasMore: true
    property int imgCellRectWidth: 45
    property int timeRectWidth: 54
    property int spacingWidth: 10
    property int serialNumberWidth: 20

    function getSearchSongsInfo() {
        function onReply(result) {
            api.onSearchCompleted.disconnect(onReply);
            var newSongs = result.songs;
            for (const song of newSongs) {
                songs.push(song);
                listView.model.append({
                    "song": song
                });
            }
            initing = false;
            offset += newSongs.length;
            loadMore = false;
            console.log("加载的歌曲数量: limit: " + limit + " offset: " + offset + " songs数组长度: " + songs.length);
        }

        if (songListCount - offset > 50) {
            limit = 50;
        } else {
            limit = songListCount - offset;
            hasMore = false;
        }
        api.onSearchCompleted.connect(onReply);
        api.search(Router.routeCurrent.key, limit, offset);
    }

    function getSearchResult(offset = 0) {
        function onReply(result) {
            api.onSearchCompleted.disconnect(onReply);
            songListCount = result.songCount;
            console.log("搜索到的歌曲共有：" + songListCount + "首");
            getSearchSongsInfo();
        }

        api.onSearchCompleted.connect(onReply);
        api.search(Router.routeCurrent.key);
    }

    function playPlaylistAllMusic(index = -1) {
        function onReply(data) {
            api.onSongUrlCompleted.disconnect(onReply);
            var urlOffset = songUrls.length;
            for (var i = 0; i < data.length; i++) {
                var song = data[i];
                var songIndex = ids.indexOf(song.id);
                if (songIndex !== -1)
                    songUrls[songIndex + urlOffset] = song.url;

            }
            for (var i = urlOffset; i < songs.length; i++) {
                player.addPlaylistToPlaylist(songUrls[i], songs[i].id, songs[i].name, songs[i].al.picUrl, Util.spliceSinger(songs[i].ar), Util.formatDuration(songs[i].dt), Util.isVip(songs[i].fee));
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
        api.onSongUrlCompleted.connect(onReply);
        api.getSongUrl(concatenatedIds);
    }

    function onPlaylistCurrentIndexChanged() {
        currentSelectIndex = player.getCurrentIndex();
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
        contentHeight: 5 + 20 + listView.height
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

            ListView {
                id: listView

                width: scrollWidth
                height: offset * 56
                model: songListModel

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
