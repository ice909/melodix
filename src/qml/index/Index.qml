import "../../util"
import "../api"
import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    property int scrollWidth: rootWindow.width - 40

    Component.onCompleted: {
        var promise = new Promise((resolve, reject) => {
            API.getRecommendPlaylist((resp) => {
                resolve(resp.result);
            });
        });
        promise.then((result) => {
            recommendPlaylist.lists = result;
            return new Promise((resolve, reject) => {
                API.getRecommendNewSongs((resp) => {
                    resolve(resp.result);
                });
            });
        }).then((result) => {
            recommendNewSongs.lists = result;
            return new Promise((resolve, reject) => {
                API.getHotSigner((resp) => {
                    resolve(resp.artists);
                });
            });
        }).then((result) => {
            hotSigner.lists = result;
            return new Promise((resolve, reject) => {
                API.getRecommendMV((resp) => {
                    resolve(resp.result);
                });
            });
        }).then((result) => {
            recommendMV.lists = result;
            return new Promise((resolve, reject) => {
                API.getBanner((resp) => {
                    resolve(resp.banners);
                })
            })
        }).then((result) => {
            banner.imgs = result
            initing = false
        })
    }

    // 首页界面
    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: banner.height + recommendPlaylist.height + recommendNewSongs.height + hotSigner.height + recommendMV.height + 30 * 4 + 10 * 8 + 5

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

            Rectangle {
                width: scrollWidth
                height: 30
                color: "transparent"

                Text {
                    text: "推荐歌单"
                    font {
                        pixelSize: DTK.fontManager.t4.pixelSize
                        bold: true
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor
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
                    font {
                        pixelSize: DTK.fontManager.t4.pixelSize
                        bold: true
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor
                }

            }

            Rectangle {
                width: scrollWidth
                height: (scrollWidth - 100) * 0.33333 * 0.15 * 3 + 20 * 2
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
                    font {
                        pixelSize: DTK.fontManager.t4.pixelSize
                        bold: true
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor
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
                    font {
                        pixelSize: DTK.fontManager.t4.pixelSize
                        bold: true
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor
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
        color: Util.pageBackgroundColor

        Loading {
            anchors.centerIn: parent
        }

    }

}
