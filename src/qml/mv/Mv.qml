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
    property bool isPlaying: true

    function getMvDetail() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var data = JSON.parse(reply).data;
            artistImg.imgSrc = data.artists[0].img1v1Url;
            artistName.text = data.artists[0].name;
            mvName.text = data.name;
            mvInfo.text = "发布：" + data.publishTime + "   播放: " + (data.playCount > 10000 ? data.playCount / 10000 : data.playCount) + "万次";
            initing = false;
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
        contentHeight: 5 + 20 + headRect.height

        Column {
            id: body

            spacing: 20
            x: 20
            y: 5

            Rectangle {
                id: headRect

                color: "black"
                width: scrollWidth
                height: headHeight

                Row {
                    anchors.fill: parent
                    spacing: 20

                    Column {
                        spacing: 0

                        Rectangle {
                            id: videoRect

                            color: "yellow"
                            width: (scrollWidth - 20) / 3 * 2.1
                            height: headHeight - 120

                            Video {
                                id: mvVideo

                                anchors.fill: parent
                                fillMode: VideoOutput.Stretch

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if (isPlaying)
                                            mvVideo.pause();
                                        else
                                            mvVideo.play();
                                        isPlaying = !isPlaying;
                                    }
                                }

                            }

                        }

                        Rectangle {
                            id: artistRect

                            color: "red"
                            width: videoRect.width
                            height: headHeight - videoRect.height - 60

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
                            height: headHeight - videoRect.height - artistRect.height
                            color: "green"

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

                        color: "blue"
                        width: (scrollWidth - 20) / 3 * 0.9
                        height: headHeight
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
