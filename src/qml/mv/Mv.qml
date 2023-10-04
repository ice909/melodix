import "../../router"
import "../../util"
import "../widgets"
import QtMultimedia 5.15
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    property int headHeight: rootWindow.height - 140
    property bool isPlaying: false
    // 热门评论数量
    property int hotCommentsCount: 0

    function getSimilarityMv() {
        function onReply(data) {
            api.onSimiMvCompleted.disconnect(onReply);
            if (data.length > 5)
                data = data.slice(0, 5);

            similarityRepeater.model = data;
            initing = false;
        }

        api.onSimiMvCompleted.connect(onReply);
        api.getSimiMv(Router.routeCurrent.id);
    }

    function getMvHotComment() {
        function onReply(data) {
            api.onHotCommentCompleted.disconnect(onReply);
            hotCommentsCount = data.length;
            commentsRect.lists = data;
            getSimilarityMv();
        }

        api.onHotCommentCompleted.connect(onReply);
        api.getMvHotComment(Router.routeCurrent.id,"1");
    }

    function getMvDetail() {
        function onReply(data) {
            api.onMvDetailCompleted.disconnect(onReply);
            artistImg.imgSrc = data.artists[0].img1v1Url;
            artistName.text = data.artists[0].name;
            mvName.text = data.name;
            mvInfo.text = "发布：" + data.publishTime + "   播放: " + (data.playCount > 10000 ? data.playCount / 10000 : data.playCount) + "万次";
            getMvHotComment();
        }

        api.onMvDetailCompleted.connect(onReply);
        api.getMvDetail(Router.routeCurrent.id);
    }

    function getMvUrl() {
        function onReply(reply) {
            api.onMvUrlCompleted.disconnect(onReply);
            mvVideo.source = reply.url;
            getMvDetail();
        }

        api.onMvUrlCompleted.connect(onReply);
        api.getMvUrl(Router.routeCurrent.id);
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

            Item {
                id: headRect

                width: scrollWidth
                height: headHeight

                Row {
                    anchors.fill: parent
                    spacing: 20

                    Column {
                        spacing: 5

                        Item {
                            id: videoRect

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

                        Item {
                            id: artistRect

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
                                color: Util.textColor
                            }

                        }

                        Item {
                            width: videoRect.width
                            height: headHeight - 10 - videoRect.height - artistRect.height

                            Text {
                                id: mvName

                                font.pixelSize: DTK.fontManager.t4.pixelSize
                                anchors.top: parent.top
                                color: Util.textColor
                            }

                            Text {
                                id: mvInfo

                                font.pixelSize: DTK.fontManager.t8.pixelSize
                                anchors.top: mvName.bottom
                                color: Util.textColor
                            }

                        }

                    }

                    Item {
                        id: relevantRecommendRect

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
                                color: Util.textColor
                            }

                            Repeater {
                                id: similarityRepeater

                                Item {
                                    width: parent.width
                                    height: (parent.height - 10 * 5 - 20) / 5

                                    Row {
                                        anchors.fill: parent
                                        spacing: 10

                                        Item {
                                            width: (parent.width - 10) / 2
                                            height: parent.height - 10
                                            anchors.verticalCenter: parent.verticalCenter

                                            RoundedImage {
                                                anchors.fill: parent
                                                imgSrc: modelData.cover
                                            }

                                        }

                                        Item {
                                            width: (parent.width - 10) / 2
                                            height: parent.height - 10
                                            anchors.verticalCenter: parent.verticalCenter

                                            Column {
                                                anchors.fill: parent
                                                spacing: 0

                                                Item {
                                                    height: parent.height - 20
                                                    width: parent.width

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
                                                        color: Util.textColor
                                                    }

                                                }

                                                Item {
                                                    height: 20
                                                    width: parent.width

                                                    Text {
                                                        font.pixelSize: DTK.fontManager.t10.pixelSize
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        text: modelData.artists[0].name
                                                        color: Util.textColor
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

            Item {
                id: commentsTitleRect

                width: scrollWidth
                height: 30

                Text {
                    text: "热门评论"
                    font.pixelSize: DTK.fontManager.t4.pixelSize
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor
                }

            }

            MvComment {
                id: commentsRect

                width: scrollWidth
                height: hotCommentsCount * 72 + 5 * (hotCommentsCount - 1)

            }

        }

    }

    Rectangle {
        visible: initing
        anchors.fill: root
        color: Util.pageBackgroundColor

        Loading {
            anchors.centerIn: parent
        }

    }

}
