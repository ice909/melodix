import "../../router"
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

    function getRecommendedPlaylist(res) {
        function onReply(res) {
            API.onRecommendedPlaylistCompleted.disconnect(onReply);
            let newRes = [];
            if (res.length > 10)
                newRes = res.slice(1, 11);
            else
                newRes = res;
            for (const playlist of newRes) recommendedPlaylist.lists.append({
                "playlist": playlist
            })
            count++;
            if (count === 4)
                loading = false;

        }

        API.onRecommendedPlaylistCompleted.connect(onReply);
        if (res.code == 200 && res.account.status == 0 && res.profile != null)
            API.getRecommendResource();
        else
            API.getRecommendedPlaylist(10);
    }

    Connections {
        function onLoginStatusCompleted(res) {
            API.banner(0);
            getRecommendedPlaylist(res);
            API.getRecommendedNewSongs(9);
            API.getTopArtists();
        }

        function onBannerCompleted(res) {
            for (let i = 0; i < res.length; i++) {
                // 左右两个轮播图
                // 左边展示一半，右边展示一半
                if (i % 2 === 0)
                    left_banner.model.append({
                    "img": res[i].imageUrl,
                    "url": res[i].url || "https://music.163.com"
                });
                else
                    right_banner.model.append({
                    "img": res[i].imageUrl,
                    "url": res[i].url || "https://music.163.com"
                });
            }
            count++;
            if (count === 4)
                loading = false;

        }

        function onRecommendedNewSongsCompleted(res) {
            recommendNewSongs.lists = res;
            count++;
            if (count === 4)
                loading = false;

        }

        function onTopArtistsCompleted(res) {
            hotSigner.lists = res;
            count++;
            if (count === 4)
                loading = false;

        }

        target: API
    }

    // 首页界面
    ScrollView {
        id: indexScroll

        width: root.width
        height: root.height
        clip: true

        Column {
            id: indexColumn

            x: Util.pageLeftPadding
            y: 5
            spacing: 10

            Row {
                width: scrollWidth
                height: width / 5.5
                spacing: 20

                Banner {
                    id: left_banner

                    width: (parent.width - 20) / 2
                    height: parent.height

                    model: ListModel {
                    }

                }

                Banner {
                    id: right_banner

                    width: (parent.width - 20) / 2
                    height: parent.height

                    model: ListModel {
                    }

                }

            }

            Item {
                width: scrollWidth
                height: 40

                Text {
                    text: "推荐歌单"
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor

                    font {
                        pixelSize: DTK.fontManager.t4.pixelSize
                        bold: true
                    }

                }

                ToolButton {
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    height: 30
                    text: "查看全部"
                    onClicked: {
                        sidebar.pageSelectedIndex = 1;
                        Router.showDiscover(true);
                    }
                }

            }

            Item {
                width: scrollWidth
                height: ((scrollWidth - 30 * 4) * 0.2 + 30) * 2 + 30

                GridPlaylists {
                    id: recommendedPlaylist

                    anchors.fill: parent
                }

            }

            Item {
                width: scrollWidth
                height: 40

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

                GridSong {
                    id: recommendNewSongs

                    anchors.fill: parent
                }

            }

            Item {
                width: scrollWidth
                height: 40

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
                height: 10
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
