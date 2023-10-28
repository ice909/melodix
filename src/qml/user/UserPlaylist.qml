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

    property alias createLists: userCreatePlaylistGrid.lists
    property alias collectLists: userCollectPlaylistGrid.lists
    property int createPlaylistRows: 0
    property int collectPlaylistRows: 0

    width: scrollWidth
    height: userCreatePlaylistsRect.height + userCollectPlaylistsRect.height + 20 + 10
    Component.onDestruction: console.log("UserPlaylists destroyed")

    Column {
        anchors.fill: parent
        spacing: 20
        x: Util.pageLeftPadding
        y: 5

        Rectangle {
            id: userCreatePlaylistsRect

            color: "#fff"
            radius: 10
            width: parent.width
            height: userCreatePlaylistTitle.height + userCreatePlaylistGrid.height + 20

            Column {
                width: parent.width - 20
                height: parent.height - 10
                spacing: 10
                x: 10
                y: 5

                Item {
                    width: 0
                    height: 0
                }

                Text {
                    id: userCreatePlaylistTitle

                    text: "我创建的歌单"
                    font.pixelSize: 20
                    font.bold: true
                    x: 10
                }

                GridPlaylists {
                    id: userCreatePlaylistGrid

                    width: parent.width
                    height: createPlaylistRows * ((width - 30 * 4) * 0.2 + 21) + (createPlaylistRows - 1) * 30
                }

            }

            BoxShadow {
                anchors.fill: parent
                shadowBlur: 6
                shadowColor: Qt.rgba(0, 0, 0, 0.2)
                shadowOffsetX: 0
                shadowOffsetY: 1
                cornerRadius: parent.radius
                hollow: true
            }

        }

        Rectangle {
            id: userCollectPlaylistsRect

            color: "#fff"
            radius: 10
            width: parent.width
            height: userCollectPlaylistTitle.height + userCollectPlaylistGrid.height + 20

            Column {
                width: parent.width - 20
                height: parent.height - 10
                spacing: 10
                x: 10
                y: 5

                Item {
                    width: 0
                    height: 0
                }

                Text {
                    id: userCollectPlaylistTitle

                    text: "我收藏的歌单"
                    font.pixelSize: 20
                    font.bold: true
                    x: 10
                }

                GridPlaylists {
                    id: userCollectPlaylistGrid

                    width: parent.width
                    height: collectPlaylistRows * ((width - 30 * 4) * 0.2 + 21) + (collectPlaylistRows - 1) * 30
                }

            }

            BoxShadow {
                anchors.fill: parent
                shadowBlur: 6
                shadowColor: Qt.rgba(0, 0, 0, 0.2)
                shadowOffsetX: 0
                shadowOffsetY: 1
                cornerRadius: parent.radius
                hollow: true
            }

        }

    }

}
