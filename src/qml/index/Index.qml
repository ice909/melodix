import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    property int scrollWidth: rootWindow.width - 40

    function getRecommendMV() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            //console.log(JSON.stringify(JSON.parse(reply)))
            recommendMV.lists = JSON.parse(reply).result;
            initing = false;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/personalized/mv");
    }

    function getHotSigner() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            //console.log(JSON.stringify(JSON.parse(reply)))
            hotSigner.lists = JSON.parse(reply).artists;
            getRecommendMV();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/top/artists?limit=5");
    }

    function getRecommendNewSongs() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            //console.log(JSON.stringify(JSON.parse(reply)))
            recommendNewSongs.lists = JSON.parse(reply).result;
            getHotSigner();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/personalized/newsong?limit=6");
    }

    function getRecommendPlaylist() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            //console.log(JSON.stringify(JSON.parse(reply)))
            recommendPlaylist.lists = JSON.parse(reply).result;
            getRecommendNewSongs();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/personalized?limit=10");
    }

    Component.onCompleted: {
        getRecommendPlaylist();
    }

    // 首页界面
    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: recommendPlaylist.height + recommendNewSongs.height + hotSigner.height + recommendMV.height + 30 * 4 + 20 * 7 + 5

        Column {
            id: body

            spacing: 20
            x: 20
            y: 5

            Rectangle {
                width: scrollWidth
                height: 30
                color: "transparent"

                Text {
                    text: "推荐歌单"
                    font.pixelSize: DTK.fontManager.t4.pixelSize
                    anchors.verticalCenter: parent.verticalCenter
                }

            }

            Rectangle {
                width: scrollWidth
                height: ((scrollWidth - 20 * 4) * 0.2 + 30) * 2 + 20
                color: "transparent"

                RecommendPlaylist {
                    id: recommendPlaylist

                    anchors.fill: parent
                }

            }

            Rectangle {
                width: scrollWidth
                height: 30
                color: "transparent"

                Text {
                    text: "推荐新歌"
                    font.pixelSize: DTK.fontManager.t4.pixelSize
                    anchors.verticalCenter: parent.verticalCenter
                }

            }

            Rectangle {
                width: scrollWidth
                height: (scrollWidth - 20) * 0.5 * 0.15 * 3 + 20 * 2
                color: "transparent"

                RecommendNewSongs {
                    id: recommendNewSongs

                    anchors.fill: parent
                }

            }

            Rectangle {
                width: scrollWidth
                height: 30
                color: "transparent"

                Text {
                    text: "热门歌手"
                    font.pixelSize: DTK.fontManager.t4.pixelSize
                    anchors.verticalCenter: parent.verticalCenter
                }

            }

            Rectangle {
                width: scrollWidth
                height: (scrollWidth - 80) * 0.2 + 30
                color: "transparent"

                HotSigner {
                    id: hotSigner

                    anchors.fill: parent
                }

            }

            Rectangle {
                width: scrollWidth
                height: 30
                color: "transparent"

                Text {
                    text: "推荐MV"
                    font.pixelSize: DTK.fontManager.t4.pixelSize
                    anchors.verticalCenter: parent.verticalCenter
                }

            }

            Rectangle {
                width: scrollWidth
                height: (scrollWidth - 20) * 0.5 / 2.9
                color: "transparent"

                RecommendMV {
                    id: recommendMV

                    anchors.fill: parent
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
