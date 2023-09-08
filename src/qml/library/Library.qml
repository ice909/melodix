import "../widgets"
import "../../router"
import "../../util"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    property bool switching: false
    property int scrollWidth: rootWindow.width - 40
    // 用户的所有歌单
    property var userPlaylists: []
    property string myLikeListId: ""
    property string currentChecked: "全部歌单"
    property int playlistRows: 0

    function checkedAllPlaylist() {
        console.log("获取的歌单数量：" + userPlaylists.length);
        playlistRows = Math.ceil(userPlaylists.length / 5);
        bottomLoader.item.lists = userPlaylists.slice(1, userPlaylists.length);
        console.log("计算出的歌单行数：" + playlistRows);
        switching = false;
    }

    function getLyric(id) {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var lrc = JSON.parse(reply).lrc.lyric;
            var lines = lrc.split("\n");
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

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/lyric?id=" + id);
    }

    // 获取用户歌单
    function getUserPlayLists() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            userPlaylists = JSON.parse(reply).playlist;
            console.log("获取的歌单数量：" + userPlaylists.length);
            playlistRows = Math.ceil(userPlaylists.length / 5);
            console.log("计算出的歌单行数：" + playlistRows);
            // 第一个为我喜欢的歌单
            myLikeListId = userPlaylists[0].id;
            getPlayListAllMusic();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/user/playlist?uid=" + userID + "&timestamp=" + Util.getTimestamp());
    }

    // 获取歌单前12首歌曲
    function getPlayListAllMusic() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var randomNumber = Math.floor(Math.random() * 12);
            var datas = JSON.parse(reply).songs;
            getLyric(datas[randomNumber].id);
            musicCountTitle.text = datas.length + "首歌";
            myFavoriteSongs.lists = datas.slice(0, 12);
            bottomLoader.item.lists = userPlaylists.slice(1, userPlaylists.length);
            initing = false;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/playlist/track/all?id=" + myLikeListId + "&timestamp=" + Util.getTimestamp());
    }

    // 获取用户购买的专辑
    function getUserAlbum() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var datas = JSON.parse(reply).paidAlbums;
            bottomLoader.item.lists = datas;
            console.log("已购专辑数量：" + datas.length);
            playlistRows = Math.ceil(datas.length / 5);
            console.log("计算出的已购专辑行数：" + playlistRows);
            switching = false;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/digitalAlbum/purchased?timestamp=" + Util.getTimestamp());
    }

    // 获取收藏的歌手
    function getFollowArtists() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var datas = JSON.parse(reply).data;
            console.log("关注艺人数量：" + datas.length);
            playlistRows = Math.ceil(datas.length / 5);
            console.log("计算出的关注艺人行数：" + playlistRows);
            bottomLoader.item.lists = datas;
            switching = false;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/artist/sublist?timestamp=" + Util.getTimestamp());
    }

    function getCollectMvs() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var datas = JSON.parse(reply).data;
            //console.log(JSON.stringify(JSON.parse(reply)))
            console.log("收藏MV数量：" + datas.length);
            playlistRows = Math.ceil(datas.length / 5);
            console.log("计算出的收藏MV行数：" + playlistRows);
            bottomLoader.item.lists = datas;
            switching = false;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/mv/sublist?timestamp=" + Util.getTimestamp());
    }

    Component.onCompleted: {
        getUserPlayLists();
    }

    // 音乐库界面
    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: myFavoriteSongsRect.height + headRect.height + categoryTabRect.height + bottomLoader.height + 5 + 20 * 3

        Column {
            id: body

            spacing: 20
            x: 20
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
                            onClicked: Router.showFavorite();
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
                            bottomLoader.setSource("./AllPlaylist.qml")
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
                            bottomLoader.setSource("./BuyAlbums.qml")
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
                            bottomLoader.setSource("./FollowArtists.qml")
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
                            bottomLoader.setSource("./CollectMVs.qml")
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
                height: currentChecked == "MV" ? ((playlistRows * ((scrollWidth - 30 * 3) * 0.25 - 60)) + (playlistRows - 1) * 10) : ((playlistRows * ((scrollWidth - 30 * 4) * 0.2 + 30)) + (playlistRows - 1) * 10)
                source: "./AllPlaylist.qml"

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
