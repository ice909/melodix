import "../../router"
import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    property bool switching: false
    // 用户的所有歌单
    property var userPlaylists: []
    property string myLikeListId: ""
    property string myLikeSongCount: ""
    property string currentChecked: "全部歌单"
    property int playlistRows: 0

    function checkedAllPlaylist() {
        console.log("获取的歌单数量：" + userPlaylists.length);
        playlistRows = Math.ceil(userPlaylists.length / 5);
        var bottomPlaylists = userPlaylists.slice(1, userPlaylists.length);
        for (const playlist of bottomPlaylists) bottomLoader.item.lists.append({
            "playlist": playlist
        })
        console.log("计算出的歌单行数：" + playlistRows);
        switching = false;
    }

    function getLyric(id) {
        function onReply(reply) {
            api.onLyricCompleted.disconnect(onReply);
            var lines = reply.split("\n");
            var lyrics = [];
            for (var i = 0; i < lines.length; i++) {
                var line = lines[i].trim();
                if (line !== "") {
                    var timestampEnd = line.indexOf("]");
                    var lyric = line.substring(timestampEnd + 1).trim();
                    if (lyric != "")
                        lyrics.push(lyric);

                }
            }
            var randomNumber = Math.floor(Math.random() * (lyrics.length - 4) + 4);
            if ((randomNumber + 2) < lyrics.length) {
                randomLyric1.text = lyrics[randomNumber];
                randomLyric2.text = lyrics[randomNumber + 1];
                randomLyric3.text = lyrics[randomNumber + 2];
            } else {
                randomLyric1.text = lyrics[randomNumber - 2];
                randomLyric2.text = lyrics[randomNumber - 1];
                randomLyric3.text = lyrics[randomNumber];
            }
        }

        api.onLyricCompleted.connect(onReply);
        api.getLyric(id);
    }

    // 获取歌单前12首歌曲
    function getPlayListAllMusic() {
        function onReply(reply) {
            api.onPlaylistSongsCompleted.disconnect(onReply);
            var randomNumber = Math.floor(Math.random() * 12);
            getLyric(reply[randomNumber].id);
            musicCountTitle.text = reply.length + "首歌";
            myFavoriteSongs.lists = reply.slice(0, 12);
            var bottomPlaylists = userPlaylists.slice(1, userPlaylists.length);
            for (const playlist of bottomPlaylists) bottomLoader.item.lists.append({
                "playlist": playlist
            })
            initing = false;
        }

        api.onPlaylistSongsCompleted.connect(onReply);
        api.getPlaylistSongs(myLikeListId);
    }

    // 获取用户购买的专辑
    function getUserAlbum() {
        function onReply(reply) {
            api.onUserBuyAlbumCompleted.disconnect(onReply);
            bottomLoader.item.lists = reply;
            console.log("已购专辑数量：" + reply.length);
            playlistRows = Math.ceil(reply.length / 5);
            console.log("计算出的已购专辑行数：" + playlistRows);
            switching = false;
        }

        api.onUserBuyAlbumCompleted.connect(onReply);
        api.getUserBuyAlbum();
    }

    // 获取收藏的歌手
    function getFollowArtists() {
        function onReply(reply) {
            api.onArtistSublistCompleted.disconnect(onReply);
            console.log("关注艺人数量：" + reply.length);
            playlistRows = Math.ceil(reply.length / 5);
            console.log("计算出的关注艺人行数：" + playlistRows);
            bottomLoader.item.lists = reply;
            switching = false;
        }

        api.onArtistSublistCompleted.connect(onReply);
        api.getArtistSublist();
    }

    function getCollectMvs() {
        function onReply(reply) {
            api.onMvSublistCompleted.disconnect(onReply);
            console.log("收藏MV数量：" + reply.length);
            playlistRows = Math.ceil(reply.length / 5);
            console.log("计算出的收藏MV行数：" + playlistRows);
            bottomLoader.item.lists = reply;
            switching = false;
        }

        api.onMvSublistCompleted.connect(onReply);
        api.getMvSublist();
    }

    Component.onCompleted: {
        api.getUserPlaylist(userID);
    }

    Connections {
        target: api
        function onUserPlaylistCompleted(res) {
            userPlaylists = res;
            console.log("获取的歌单数量：" + userPlaylists.length);
            playlistRows = Math.ceil(userPlaylists.length / 5);
            console.log("计算出的歌单行数：" + playlistRows);
            // 第一个为我喜欢的歌单
            myLikeListId = userPlaylists[0].id;
            myLikeSongCount = userPlaylists[0].trackCount;
            getPlayListAllMusic();
        }
    }

    // 音乐库界面
    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: myFavoriteSongsRect.height + headRect.height + categoryTabRect.height + bottomLoader.height + 5 + 20 * 3

        Column {
            id: body

            spacing: 20
            x: Util.pageLeftPadding
            y: 5

            Item {
                id: headRect

                width: scrollWidth
                height: 50

                RoundedImage {
                    id: avatar_image

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 40
                    imgSrc: userAvatar
                    borderRadius: width
                }

                Text {
                    anchors.left: avatar_image.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    text: userNickname + "的音乐库"
                    font.pixelSize: DTK.fontManager.t3.pixelSize
                    height: 40
                    color: Util.textColor
                }

            }

            Item {
                id: myFavoriteSongsRect

                width: scrollWidth
                height: 220

                Row {
                    anchors.fill: parent
                    spacing: 30

                    Rectangle {
                        id: myFavoriteSongsLeftRect

                        width: parent.width * 0.35
                        height: parent.height
                        color: "#eaeffd"
                        radius: 16

                        Item {
                            width: parent.width - 60
                            height: parent.height - myfavoriteTitle.height - musicCountTitle.height - 50
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.top: parent.top
                            anchors.topMargin: 10

                            Column {
                                anchors.fill: parent

                                Text {
                                    id: randomLyric1

                                    width: parent.width
                                    font.pixelSize: DTK.fontManager.t5.pixelSize
                                    elide: Qt.ElideRight
                                }

                                Text {
                                    id: randomLyric2

                                    width: parent.width
                                    font.pixelSize: DTK.fontManager.t4.pixelSize
                                    font.bold: true
                                    elide: Qt.ElideRight
                                }

                                Text {
                                    id: randomLyric3

                                    width: parent.width
                                    font.pixelSize: DTK.fontManager.t5.pixelSize
                                    elide: Qt.ElideRight
                                }

                            }

                        }

                        Label {
                            id: myfavoriteTitle

                            text: "我喜欢的音乐"
                            color: "#335eea"
                            anchors.left: parent.left
                            anchors.bottom: musicCountTitle.top
                            anchors.leftMargin: 10
                            font.pixelSize: 24
                            font.bold: true
                        }

                        Label {
                            id: musicCountTitle

                            color: "#335eea"
                            opacity: 0.8
                            font.pixelSize: 15
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            anchors.leftMargin: 10
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Router.showFavorite(myLikeListId,myLikeSongCount)
                        }

                    }

                    Item {
                        width: parent.width * 0.65 - 60
                        height: parent.height

                        MyFavorite {
                            id: myFavoriteSongs

                            anchors.fill: parent
                        }

                    }

                }

            }

            Item {
                id: categoryTabRect

                width: scrollWidth
                height: 50

                ButtonBox {
                    anchors.verticalCenter: parent.verticalCenter

                    ToolButton {
                        checkable: true
                        text: "全部歌单"
                        font.pixelSize: 15
                        checked: true
                        onClicked: {
                            switching = true;
                            currentChecked = text;
                            bottomLoader.setSource("../widgets/GridPlaylists.qml");
                            checkedAllPlaylist();
                        }
                    }

                    ToolButton {
                        checkable: true
                        text: "专辑"
                        font.pixelSize: 15
                        onClicked: {
                            switching = true;
                            currentChecked = text;
                            bottomLoader.setSource("");
                            bottomLoader.setSource("./BuyAlbums.qml");
                            getUserAlbum();
                        }
                    }

                    ToolButton {
                        checkable: true
                        text: "艺人"
                        font.pixelSize: 15
                        onClicked: {
                            switching = true;
                            currentChecked = text;
                            bottomLoader.setSource("../widgets/GridSigner.qml");
                            getFollowArtists();
                        }
                    }

                    ToolButton {
                        checkable: true
                        text: "MV"
                        font.pixelSize: 15
                        onClicked: {
                            switching = true;
                            currentChecked = text;
                            bottomLoader.setSource("./CollectMVs.qml");
                            getCollectMvs();
                        }
                    }

                    background: Rectangle {
                        color: Util.libraryButtonBoxBackground
                        radius: 5
                    }

                }

            }

            Loader {
                id: bottomLoader

                width: scrollWidth
                height: currentChecked == "MV" ? ((playlistRows * ((scrollWidth - 30 * 3) * 0.25 - 60)) + (playlistRows - 1) * 10) : playlistRows * ((scrollWidth - 30 * 4) * 0.2 + 25) + (playlistRows - 1) * 30
                source: "../widgets/GridPlaylists.qml"
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

    Rectangle {
        id: switchnimation

        visible: switching
        width: bottomLoader.width
        height: bottomLoader.height
        y: bottomLoader.y
        x: bottomLoader.x
        color: Util.pageBackgroundColor

        Loading {
            anchors.centerIn: parent
        }

    }

}
