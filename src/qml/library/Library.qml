import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    property int scrollWidth: rootWindow.width - 40
    property var userPlaylists: []
    property string myLikeListId: ""
    property string currentChecked: "全部歌单"
    property int playlistRowCount: 0

    function checkedAllPlaylist() {
        console.log("获取的歌单数量：" + userPlaylists.length);
        playlistRowCount = Math.ceil(userPlaylists.length / 5);
        console.log("计算出的歌单行数：" + playlistRowCount);
    }

    // 获取用户歌单
    function getUserPlayLists() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            userPlaylists = JSON.parse(reply).playlist;
            console.log("获取的歌单数量：" + userPlaylists.length);
            playlistRowCount = Math.ceil(userPlaylists.length / 5);
            console.log("计算出的歌单行数：" + playlistRowCount);
            // 第一个为我喜欢的歌单
            myLikeListId = userPlaylists[0].id;
            getPlayListAllMusic();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/user/playlist?uid=" + userID + "&timestamp=" + getTimestamp());
    }

    // 获取歌单前12首歌曲
    function getPlayListAllMusic() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var datas = JSON.parse(reply).songs;
            musicCountTitle.text = datas.length + "首歌";
            myFavoriteSongs.lists = datas.slice(0, 12);
            userAllPlaylist.lists = userPlaylists.slice(1, userPlaylists.length);
            initing = false;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/playlist/track/all?id=" + myLikeListId + "&timestamp=" + getTimestamp());
    }

    // 获取用户购买的专辑
    function getUserAlbum() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var datas = JSON.parse(reply).paidAlbums;
            userBuyAlbum.lists = datas;
            console.log("已购专辑数量：" + datas.length);
            playlistRowCount = Math.ceil(datas.length / 5);
            console.log("计算出的已购专辑行数：" + playlistRowCount);
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/digitalAlbum/purchased?timestamp=" + getTimestamp());
    }

    // 获取收藏的歌手
    function getFollowArtists() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var datas = JSON.parse(reply).data;
            console.log("关注艺人数量：" + datas.length);
            playlistRowCount = Math.ceil(datas.length / 5);
            console.log("计算出的关注艺人行数：" + playlistRowCount);
            userFollowArtists.lists = datas;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/artist/sublist?timestamp=" + getTimestamp());
    }

    function getCollectMvs() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var datas = JSON.parse(reply).data;
            console.log("关注艺人数量：" + datas.length);
            playlistRowCount = Math.ceil(datas.length / 5);
            console.log("计算出的关注艺人行数：" + playlistRowCount);
            userCollectMVs.lists = datas;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/mv/sublist?timestamp=" + getTimestamp());
    }

    Component.onCompleted: {
        getUserPlayLists();
    }

    // 音乐库界面
    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: myloveRect.height + headRect.height + categoryTabRect.height + bottomDataRect.height + 5 + 20 * 3

        Column {
            id: body

            spacing: 20
            x: 20
            y: 5

            Rectangle {
                id: headRect

                width: scrollWidth
                height: 50
                color: "transparent"

                RoundedImage {
                    id: avatar_image

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 40
                    imgSrc: userImg
                    borderRadius: width
                }

                Text {
                    anchors.left: avatar_image.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    text: userNickname + "的音乐库"
                    font.pixelSize: DTK.fontManager.t3.pixelSize
                    height: 40
                }

            }

            Rectangle {
                id: myloveRect

                width: scrollWidth
                height: 220
                color: "transparent"

                Row {
                    anchors.fill: parent
                    spacing: 30

                    Rectangle {
                        id: myloveLeftRect

                        width: parent.width * 0.35
                        height: parent.height
                        color: "#eaeffd"
                        radius: 16

                        Label {
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

                    }

                    Rectangle {
                        width: parent.width * 0.65 - 60
                        height: parent.height
                        color: "transparent"

                        MyFavorite {
                            id: myFavoriteSongs

                            anchors.fill: parent
                        }

                    }

                }

            }

            Rectangle {
                id: categoryTabRect

                width: scrollWidth
                height: 50
                color: "transparent"

                ButtonBox {
                    anchors.verticalCenter: parent.verticalCenter

                    ToolButton {
                        checkable: true
                        text: "全部歌单"
                        font.pixelSize: 15
                        checked: true
                        font.bold: checked ? true : false
                        onClicked: {
                            currentChecked = text;
                            checkedAllPlaylist();
                        }
                    }

                    ToolButton {
                        checkable: true
                        text: "专辑"
                        font.pixelSize: 15
                        onClicked: {
                            currentChecked = text;
                            getUserAlbum();
                        }
                    }

                    ToolButton {
                        checkable: true
                        text: "艺人"
                        font.pixelSize: 15
                        onClicked: {
                            currentChecked = text;
                            getFollowArtists();
                        }
                    }

                    ToolButton {
                        checkable: true
                        text: "MV"
                        font.pixelSize: 15
                        onClicked: {
                            currentChecked = text;
                            getCollectMvs();
                        }
                    }

                    background: Rectangle {
                        color: "#F8F8FF"
                        radius: 5
                    }

                }

            }

            Rectangle {
                id: bottomDataRect

                width: scrollWidth
                height: currentChecked == "MV" ? ((playlistRowCount * ((scrollWidth - 30 * 3) * 0.25 - 60)) + (playlistRowCount - 1) * 10) : ((playlistRowCount * ((scrollWidth - 30 * 4) * 0.2 + 30)) + (playlistRowCount - 1) * 10)
                color: "transparent"

                AllPlaylist {
                    id: userAllPlaylist

                    anchors.fill: parent
                    visible: currentChecked == "全部歌单"
                }

                BuyAlbums {
                    id: userBuyAlbum

                    anchors.fill: parent
                    visible: currentChecked == "专辑"
                }

                FollowArtists {
                    id: userFollowArtists

                    anchors.fill: parent
                    visible: currentChecked == "艺人"
                }

                CollectMVs {
                    id: userCollectMVs

                    anchors.fill: parent
                    visible: currentChecked == "MV"
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
