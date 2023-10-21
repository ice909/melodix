import "../../util"
import "../widgets"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool loading: true
    property int userLevel: 0
    property string musicianPic: ""
    property string musicianDesc: ""
    property int followsCount: 0
    property int followedsCount: 0

    function getUserPlaylist() {
        function onReply(res) {
            API.onUserPlaylistCompleted.disconnect(onReply);
            let createCount = 0;
            let collectCount = 0;
            for (const playlist of res) {
                if (playlist.creator.userId == userID) {
                    // 满足条件,说明是自己创建的歌单
                    contentLoader.item.createLists.append({
                        "playlist": playlist
                    });
                    createCount++;
                } else {
                    // 否则是收藏的歌单
                    contentLoader.item.collectLists.append({
                        "playlist": playlist
                    });
                    collectCount++;
                }
            }
            contentLoader.item.createPlaylistRows = Math.ceil(createCount / 5);
            contentLoader.item.collectPlaylistRows = Math.ceil(collectCount / 5);
            loading = false;
        }

        API.onUserPlaylistCompleted.connect(onReply);
        API.getUserPlaylist(userID);
    }

    Component.onCompleted: API.getUserDetail(userID)

    Connections {
        function onUserDetailCompleted(data) {
            userLevel = data.level;
            musicianPic = data.identify.imageUrl;
            musicianDesc = data.identify.imageDesc;
            followsCount = data.profile.follows;
            followedsCount = data.profile.followeds;
            getUserPlaylist();
        }

        target: API
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: headRect.height + contentRect.height + 10

        Column {
            id: body

            spacing: 10
            x: Util.pageLeftPadding
            y: 5

            UserHeaderRegion {
                id: headRect

                width: scrollWidth
                height: scrollWidth * 0.23
            }

            Rectangle {
                id: contentRect

                width: scrollWidth
                height: btnBox.height + 20 + contentLoader.height
                color: "yellow"

                Column {
                    anchors.fill: parent
                    spacing: 20

                    ButtonBox {
                        id: btnBox

                        ToolButton {
                            leftPadding: 20
                            rightPadding: 20
                            text: "歌单"
                            font.pixelSize: 18
                            font.bold: checked ? true : false
                            checked: true
                            checkable: true
                        }

                        ToolButton {
                            leftPadding: 20
                            rightPadding: 20
                            text: "动态"
                            font.pixelSize: 18
                            font.bold: checked ? true : false
                            checkable: true
                        }

                        ToolButton {
                            leftPadding: 20
                            rightPadding: 20
                            text: "播客"
                            font.pixelSize: 18
                            font.bold: checked ? true : false
                            checkable: true
                        }

                        background: Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                        }

                    }

                    Loader {
                        id: contentLoader

                        width: scrollWidth
                        height: item.height
                        source: "../widgets/UserPlaylist.qml"
                    }

                }

            }

        }

    }

    Rectangle {
        visible: loading
        anchors.fill: root
        color: Util.pageBackgroundColor

        Loading {
            anchors.centerIn: parent
        }

    }

}
