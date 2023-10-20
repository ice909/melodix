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
    property int count: 0

    Connections {
        function onLoginStatusCompleted(res) {
            API.banner(0);
            if (res.code == 200 && res.account.status == 0 && res.profile != null)
                API.getRecommendResource();
            else
                API.getRecommendedPlaylist(10);
            API.getRecommendedNewSongs(9);
            API.getTopArtists();
            API.getRecommendedMv();
        }

        function onBannerCompleted(res) {
            for (let i = 0; i < res.length; i++) {
                // 左右两个轮播图
                // 左边展示一半，右边展示一半
                if (i % 2 === 0)
                    left_banner.model.append({
                    "img": res[i].imageUrl,
                    "url": res[i].url || ""
                });
                else
                    right_banner.model.append({
                    "img": res[i].imageUrl,
                    "url": res[i].url || ""
                });
            }
            count++;
            if (count === 5)
                loading = false;

        }

        function onRecommendedPlaylistCompleted(res) {
            let newRes = [];
            if (res.length > 10)
                newRes = res.slice(1, 11);
            else
                newRes = res;
            for (const playlist of newRes) recommendedPlaylist.lists.append({
                "playlist": playlist
            })
            count++;
            if (count === 5)
                loading = false;

        }

        function onRecommendedNewSongsCompleted(res) {
            recommendNewSongs.lists = res;
            count++;
            if (count === 5)
                loading = false;

        }

        function onTopArtistsCompleted(res) {
            hotSigner.lists = res;
            count++;
            if (count === 5)
                loading = false;

        }

        function onRecommendedMvCompleted(res) {
            recommendedMV.lists = res;
            count++;
            if (count === 5)
                loading = false;

        }

        target: API
    }

    // 首页界面
    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: left_banner.height + recommendedPlaylist.height + recommendNewSongs.height + hotSigner.height + recommendedMV.height + 30 * 4 + 10 * 8 + 5

        Column {
            id: body

            spacing: 10
            x: Util.pageLeftPadding
            y: 5

            Row {
                width: scrollWidth
                height: scrollWidth / 5.5
                spacing: 10

                Banner {
                    id: left_banner

                    width: scrollWidth / 2 - 10
                    height: scrollWidth / 5.5

                    model: ListModel {
                    }

                }

                Banner {
                    id: right_banner

                    width: scrollWidth / 2 - 10
                    height: scrollWidth / 5.5

                    model: ListModel {
                    }

                }

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
                height: ((scrollWidth - 30 * 4) * 0.2 + 22) * 2 + 30

                GridPlaylists {
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
                height: (scrollWidth - 100) * 0.33333 * 0.15 * 3 + 20 * 2 + 30

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
                height: (scrollWidth - 30 * 4) * 0.2 + 30

                GridSigner {
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
