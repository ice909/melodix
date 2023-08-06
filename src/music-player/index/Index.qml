import "."
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property int scrollWidth: rootWindow.width - 40

    function getRecommendMV() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            //console.log(JSON.stringify(JSON.parse(reply)))
            recommendMV.lists = JSON.parse(reply).result;
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
        network.makeRequest("/top/artists?limit=6");
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
        contentHeight: recommendPlaylist.height + recommendNewSongs.height + hotSigner.height + recommendMV.height + 20 * 5 + 20 * 8

        Column {
            id: body

            spacing: 20
            x: 20
            y: 5

            Text {
                text: "推荐歌单"
                font.pixelSize: DTK.fontManager.t4.pixelSize
                height: 20
            }

            RecommendPlaylist {
                id: recommendPlaylist

                width: scrollWidth
                height: 440
            }

            Text {
                text: "推荐新歌"
                font.pixelSize: DTK.fontManager.t4.pixelSize
                height: 20
            }

            RecommendNewSongs {
                id: recommendNewSongs

                width: scrollWidth
                height: 240
            }

            Text {
                text: "热门歌手"
                font.pixelSize: DTK.fontManager.t4.pixelSize
                height: 20
            }

            HotSigner {
                id: hotSigner

                width: scrollWidth
                height: 200
            }

            Text {
                text: "推荐MV"
                font.pixelSize: DTK.fontManager.t4.pixelSize
                height: 20
            }

            RecommendMV {
                id: recommendMV

                width: scrollWidth
                height: 150
            }

        }

    }

}
