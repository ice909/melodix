import "../../router"
import "../../util"
import "../widgets"
import Melodix.API 1.0
import Melodix.Player 1.0
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property string currentPlaylistId: ""
    property int currentSelectIndex: -1
    property bool initing: true
    property var songs: []
    // 已经添加到播放列表的歌曲数量
    property int playlistSongCount: 0
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
            API.onSearchCompleted.disconnect(onReply);
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
        API.onSearchCompleted.connect(onReply);
        API.search(Router.routeCurrent.key, limit, offset);
    }

    function getSearchResult(offset = 0) {
        function onReply(result) {
            API.onSearchCompleted.disconnect(onReply);
            songListCount = result.songCount;
            console.log("搜索到的歌曲共有：" + songListCount + "首");
            getSearchSongsInfo();
        }

        API.onSearchCompleted.connect(onReply);
        API.search(Router.routeCurrent.key);
    }

    function playPlaylistAllMusic(index = -1) {
        // 切换播放列表
        Player.switchToPlaylistMode();
        if (Player.getCurrentPlaylistId() != "" && Player.getCurrentPlaylistId() != currentPlaylistId)
            Player.clearPlaylist();

        // 判断点击的歌曲是否已经添加到播放列表
        // 如果添加了直接播放
        if (index != -1 && index < playlistSongCount) {
            Player.play(index);
            return ;
        }
        for (var i = playlistSongCount; i < songs.length; i++) {
            Player.addPlaylistToPlaylist(songs[i].id, songs[i].name, Util.spliceSinger(songs[i].ar), songs[i].pic, Util.formatDuration(songs[i].duration), songs[i].al);
        }
        playlistSongCount = songs.length;
        // 如果没有传入index参数
        // 则说明点击的是播放按钮
        if (index != -1)
            Player.play(index);
        else
            Player.play(0);
        // 给Player类设置当前的播放列表id
        Player.setCurrentPlaylistId(currentPlaylistId);
        // 如果歌曲url总数等于歌单歌曲总数
        // 说明全部歌曲都已经添加到了播放列表
        if (playlistSongCount == songListCount)
            isAddToPlaylist = true;

    }

    function onPlaylistCurrentIndexChanged() {
        currentSelectIndex = Player.getCurrentIndex();
    }

    Component.onCompleted: {
        getSearchResult();
        currentPlaylistId = Router.routeCurrent.key;
        Player.playlistCurrentIndexChanged.connect(onPlaylistCurrentIndexChanged);
    }
    Component.onDestruction: {
        Player.playlistCurrentIndexChanged.disconnect(onPlaylistCurrentIndexChanged);
    }

    ListModel {
        id: songListModel
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: 5 + listView.height
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
            x: Util.pageLeftPadding
            y: 5

            ListView {
                id: listView

                width: scrollWidth
                height: offset * 55
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
