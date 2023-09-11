import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool loading: true
    property int scrollWidth: rootWindow.width - 40

    Component.onCompleted: {
        api.banner("0");
        api.getRecommendedPlaylist("10");
        api.getRecommendedNewSongs("9");
        api.getTopArtists();
        api.getRecommendedMv();
        loading = false;
    }

    Connections {
        function onBannerCompleted(res) {
            banner.imgs = res;
        }

        function onRecommendedPlaylistCompleted(res) {
            recommendedPlaylist.lists = res;
        }

        function onRecommendedNewSongsCompleted(res) {
            recommendNewSongs.lists = res;
        }

        function onTopArtistsCompleted(res) {
            hotSigner.lists = res;
        }

        function onRecommendedMvCompleted(res) {
            recommendedMV.lists = res;
        }

        target: api
    }

    // 首页界面
    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: banner.height + recommendedPlaylist.height + recommendNewSongs.height + hotSigner.height + recommendedMV.height + 30 * 4 + 10 * 8 + 5

        Column {
            id: body

            spacing: 10
            x: 20
            y: 5

            Banner {
                id: banner

                width: scrollWidth
                height: scrollWidth / 5.5
            }

            Item {
                width: scrollWidth
                height: 30

                Text {
                    text: "推荐歌单"
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor

                    font {
                        pixelSize: DTK.fontManager.t4.pixelSize
                        bold: true
                    }

                }

            }

            Item {
                width: scrollWidth
                height: ((scrollWidth - 20 * 4) * 0.2 + 30) * 2 + 20

                RecommendPlaylist {
                    id: recommendedPlaylist

                    anchors.fill: parent
                }

            }

            Item {
                width: scrollWidth
                height: 30

                Text {
                    text: "推荐新歌"
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor

                    font {
                        pixelSize: DTK.fontManager.t4.pixelSize
                        bold: true
                    }

                }

            }

            Item {
                width: scrollWidth
                height: (scrollWidth - 100) * 0.33333 * 0.15 * 3 + 20 * 2

                RecommendNewSongs {
                    id: recommendNewSongs

                    anchors.fill: parent
                }

            }

            Item {
                width: scrollWidth
                height: 30

                Text {
                    text: "热门歌手"
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor

                    font {
                        pixelSize: DTK.fontManager.t4.pixelSize
                        bold: true
                    }

                }

            }

            Item {
                width: scrollWidth
                height: (scrollWidth - 80) * 0.2 + 30

                HotSigner {
                    id: hotSigner

                    anchors.fill: parent
                }

            }

            Item {
                width: scrollWidth
                height: 30

                Text {
                    text: "推荐MV"
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor

                    font {
                        pixelSize: DTK.fontManager.t4.pixelSize
                        bold: true
                    }

                }

            }

            Item {
                width: scrollWidth
                height: (scrollWidth - 20) * 0.5 / 2.9

                RecommendMV {
                    id: recommendedMV

                    anchors.fill: parent
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
