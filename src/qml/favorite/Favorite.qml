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

    // 歌单所有歌曲是否以经全部添加到了播放列表
    property bool isAddToPlaylist: false
    property string myFavoriteId: ""
    // 歌单歌曲总数
    property int playlistSongAllCount: 0
    // 当前播放的歌曲在歌单中的索引
    property int currentSelectIndex: -1
    // 保存添加到listview的数据
    property var songs: []
    // 已经添加到播放列表的歌曲数量
    property int playlistSongCount: 0
    // 一次取出的歌曲数量
    property int limit: 0
    // 偏移量
    property int offset: 0
    // 是否正在“加载更多”
    property bool loadMore: false
    // 是否加载完全部歌曲
    property bool hasMore: true
    property bool initing: true

    function playPlaylistAllMusic(index = -1) {
        Player.switchToPlaylistMode();
        if (Player.getCurrentPlaylistId() != "" && Player.getCurrentPlaylistId() != myFavoriteId) {
            console.log("当前歌单和播放列表中以添加的歌曲不是来自同一个歌单，先清空播放列表，再添加歌曲");
            Player.clearPlaylist();
        }
        // 判断点击的歌曲是否已经添加到播放列表
        // 如果添加了直接播放
        if (index != -1 && index < playlistSongCount) {
            Player.play(index);
            return ;
        }
        // 点击的歌曲不在播放列表中
        // 将不在播放列表中的歌曲添加到播放列表
        for (var i = playlistSongCount; i < songs.length; i++) {
            Player.addPlaylistToPlaylist(songs[i].id, songs[i].name, Util.spliceSinger(songs[i].ar), songs[i].al.picUrl, Util.formatDuration(songs[i].dt), songs[i].al.name);
        }
        playlistSongCount = songs.length;
        // 如果没有传入index参数
        // 则说明点击的是播放按钮
        if (index != -1)
            Player.play(index);
        else
            Player.play(0);
        // 给Player类设置当前的播放列表id
        Player.setCurrentPlaylistId(myFavoriteId);
        // 如果playlistSongCount等于歌单歌曲总数
        // 说明全部歌曲都已经添加到了播放列表
        if (playlistSongCount == playlistSongAllCount)
            isAddToPlaylist = true;

    }

    function getMyFavoriteSongs() {
        function onReply(newSongs) {
            API.onPlaylistSongsCompleted.disconnect(onReply);
            for (const song of newSongs) {
                songs.push(song);
                songListModel.append({
                    "song": song
                });
            }
            offset += newSongs.length;
            loadMore = false;
            initing = false;
            console.log("加载的歌曲数量: limit: " + limit + " offset: " + offset + " songs数组长度: " + songs.length);
        }

        if (playlistSongAllCount - offset > 50) {
            limit = 50;
        } else {
            limit = playlistSongAllCount - offset;
            hasMore = false;
        }
        API.onPlaylistSongsCompleted.connect(onReply);
        API.getPlaylistSongs(myFavoriteId, limit, offset);
    }

    function onPlaylistCurrentIndexChanged() {
        currentSelectIndex = Player.getCurrentIndex();
    }

    function onPlaylistCleared() {
        currentSelectIndex = -1;
    }

    Component.onCompleted: {
        playlistSongAllCount = Router.routeCurrent.count;
        myFavoriteId = Router.routeCurrent.id;
        Player.playlistCurrentIndexChanged.connect(onPlaylistCurrentIndexChanged);
        Player.playlistCleared.connect(onPlaylistCleared);
        getMyFavoriteSongs();
    }
    Component.onDestruction: {
        Player.playlistCurrentIndexChanged.disconnect(onPlaylistCurrentIndexChanged);
        Player.playlistCleared.disconnect(onPlaylistCleared);
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
            x: Util.pageLeftPadding
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
                height: offset * 55 + (offset - 1) * 5 + 30
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
