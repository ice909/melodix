import "../../router"
import "../widgets"
import QtMultimedia 5.15
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    property int scrollWidth: rootWindow.width - 40
    property int headHeight: rootWindow.height - 140
    property bool isPlaying: false
    property int hotCommentsCount: 0

    function getSimilarityMv() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var data = JSON.parse(reply).mvs;
            if (data.length > 5)
                data = data.slice(0, 5);

            similarityRepeater.model = data;
            initing = false;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/simi/mv?mvid=" + Router.routeCurrent.id);
    }

    function getMvHotComment() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var data = JSON.parse(reply).hotComments;
            hotCommentsCount = data.length;
            repeater.model = data;
            getSimilarityMv();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/comment/hot?id=" + Router.routeCurrent.id + "&type=1");
    }

    function getMvDetail() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var data = JSON.parse(reply).data;
            artistImg.imgSrc = data.artists[0].img1v1Url;
            artistName.text = data.artists[0].name;
            mvName.text = data.name;
            mvInfo.text = "发布：" + data.publishTime + "   播放: " + (data.playCount > 10000 ? data.playCount / 10000 : data.playCount) + "万次";
            getMvHotComment();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/mv/detail?mvid=" + Router.routeCurrent.id);
    }

    function getMvUrl() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            mvVideo.source = JSON.parse(reply).data.url;
            getMvDetail();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/mv/url?id=" + Router.routeCurrent.id);
    }

    Component.onCompleted: {
        console.log("Mv的id为: " + Router.routeCurrent.id);
        getMvUrl();
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: 5 + 20 * 3 + headRect.height + commentsTitleRect.height + commentsRect.height

        Column {
            id: body

            spacing: 20
            x: 20
            y: 5

            Rectangle {
                id: headRect

                color: "transparent"
                width: scrollWidth
                height: headHeight

                Row {
                    anchors.fill: parent
                    spacing: 20

                    Column {
                        spacing: 5

                        Rectangle {
                            id: videoRect

                            color: "transparent"
                            width: (scrollWidth - 20) / 3 * 2.1
                            height: headHeight - 10 - 120

                            Video {
                                id: mvVideo

                                anchors.fill: parent
                                fillMode: VideoOutput.Stretch

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        mvVideo.pause();
                                        isPlaying = !isPlaying;
                                    }
                                }

                                Rectangle {
                                    anchors.fill: parent
                                    color: "black"
                                    visible: !isPlaying

                                    ToolButton {
                                        width: 50
                                        height: 50
                                        icon.name: "details_play"
                                        anchors.centerIn: parent
                                        onClicked: {
                                            mvVideo.play();
                                            isPlaying = !isPlaying;
                                        }
                                    }

                                }

                            }

                        }

                        Rectangle {
                            id: artistRect

                            color: "transparent"
                            width: videoRect.width
                            height: headHeight - 10 - videoRect.height - 60

                            RoundedImage {
                                id: artistImg

                                width: parent.height
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                borderRadius: width
                            }

                            Text {
                                id: artistName

                                font.pixelSize: DTK.fontManager.t6.pixelSize
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: artistImg.right
                                anchors.leftMargin: 10
                            }

                        }

                        Rectangle {
                            width: videoRect.width
                            height: headHeight - 10 - videoRect.height - artistRect.height
                            color: "transparent"

                            Text {
                                id: mvName

                                font.pixelSize: DTK.fontManager.t4.pixelSize
                                anchors.top: parent.top
                            }

                            Text {
                                id: mvInfo

                                font.pixelSize: DTK.fontManager.t8.pixelSize
                                anchors.top: mvName.bottom
                            }

                        }

                    }

                    Rectangle {
                        id: relevantRecommendRect

                        color: "transparent"
                        width: (scrollWidth - 20) / 3 * 0.9
                        height: headHeight

                        Column {
                            anchors.fill: parent
                            spacing: 10

                            Text {
                                text: "相似推荐"
                                font.pixelSize: DTK.fontManager.t4.pixelSize
                                font.bold: true
                                height: 20
                            }

                            Repeater {
                                id: similarityRepeater

                                Rectangle {
                                    width: parent.width
                                    height: (parent.height - 10 * 5 - 20) / 5
                                    color: "transparent"

                                    Row {
                                        anchors.fill: parent
                                        spacing: 10

                                        Rectangle {
                                            width: (parent.width - 10) / 2
                                            height: parent.height - 10
                                            anchors.verticalCenter: parent.verticalCenter
                                            color: "transparent"

                                            RoundedImage {
                                                anchors.fill: parent
                                                imgSrc: modelData.cover
                                            }

                                        }

                                        Rectangle {
                                            width: (parent.width - 10) / 2
                                            height: parent.height - 10
                                            anchors.verticalCenter: parent.verticalCenter
                                            color: "transparent"

                                            Column {
                                                anchors.fill: parent
                                                spacing: 0

                                                Rectangle {
                                                    height: parent.height - 20
                                                    width: parent.width
                                                    color: "transparent"

                                                    Label {
                                                        font.pixelSize: DTK.fontManager.t6.pixelSize
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        font.bold: true
                                                        width: parent.width
                                                        height: parent.height
                                                        wrapMode: Text.Wrap
                                                        elide: Text.ElideRight
                                                        maximumLineCount: 3
                                                        text: modelData.name
                                                    }

                                                }

                                                Rectangle {
                                                    height: 20
                                                    width: parent.width
                                                    color: "transparent"

                                                    Text {
                                                        font.pixelSize: DTK.fontManager.t10.pixelSize
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        text: modelData.artists[0].name
                                                    }

                                                }

                                            }

                                        }

                                    }

                                }

                            }

                        }

                    }

                }

            }

            Rectangle {
                id: commentsTitleRect

                color: "transparent"
                width: scrollWidth
                height: 30

                Text {
                    text: "热门评论"
                    font.pixelSize: DTK.fontManager.t4.pixelSize
                    anchors.verticalCenter: parent.verticalCenter
                }

            }

            Rectangle {
                id: commentsRect

                color: "transparent"
                width: scrollWidth
                height: hotCommentsCount * 72 + 5 * (hotCommentsCount - 1)

                Column {
                    spacing: 5

                    Repeater {
                        id: repeater

                        Rectangle {
                            id: commentItemRect

                            width: scrollWidth
                            height: 72

                            Row {
                                anchors.fill: parent
                                spacing: 10

                                Rectangle {
                                    width: parent.height - 10
                                    height: width
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: "transparent"

                                    RoundedImage {
                                        id: commentsUserId

                                        anchors.fill: parent
                                        imgSrc: modelData.user.avatarUrl
                                        borderRadius: width
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                }

                                Rectangle {
                                    width: parent.width - commentsUserId.width - 10
                                    height: parent.height
                                    color: "transparent"

                                    Column {
                                        spacing: 0
                                        anchors.fill: parent

                                        Rectangle {
                                            width: parent.width
                                            height: 20
                                            color: "transparent"

                                            Text {
                                                id: commentsUserNickName

                                                font.pixelSize: DTK.fontManager.t8.pixelSize
                                                anchors.verticalCenter: parent.verticalCenter
                                                font.bold: true
                                                color: "dodgerblue"
                                                text: modelData.user.nickname + ": "
                                            }

                                        }

                                        Rectangle {
                                            width: parent.width - 50
                                            height: 40
                                            color: "transparent"

                                            Label {
                                                id: commentsUserContent

                                                font.pixelSize: DTK.fontManager.t9.pixelSize
                                                anchors.verticalCenter: parent.verticalCenter
                                                font.bold: true
                                                width: parent.width
                                                height: 35
                                                wrapMode: Text.Wrap
                                                elide: Text.ElideRight
                                                maximumLineCount: 2
                                                text: modelData.content
                                            }

                                        }

                                        Rectangle {
                                            width: parent.width
                                            height: 10
                                            color: "transparent"

                                            Text {
                                                id: commentReleaseTime

                                                font.pixelSize: DTK.fontManager.t10.pixelSize
                                                anchors.verticalCenter: parent.verticalCenter
                                                text: modelData.timeStr
                                            }

                                        }

                                    }

                                }

                            }

                            Rectangle {
                                anchors.top: parent.bottom
                                width: parent.width
                                height: 0.5
                                color: "black"
                            }

                        }

                    }

                }

            }

        }

    }

    Rectangle {
        visible: initing
        anchors.fill: root

        Loading {
            anchors.centerIn: parent
        }

    }

}
