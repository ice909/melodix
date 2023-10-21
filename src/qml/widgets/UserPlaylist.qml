import "../../router"
import "../../util"
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
    height: userCreatePlaylistTitle.height + userCreatePlaylistGrid.height + userCollectPlaylistTitle.height + userCollectPlaylistGrid.height + 20 * 3

    Column {
        anchors.fill: parent
        spacing: 20
        x: Util.pageLeftPadding
        y: 5

        Text {
            id: userCreatePlaylistTitle

            text: "我创建的歌单"
            font.pixelSize: 20
            font.bold: true
        }

        GridPlaylists {
            id: userCreatePlaylistGrid

            width: parent.width
            height: createPlaylistRows * ((scrollWidth - 30 * 4) * 0.2 + 25) + (createPlaylistRows - 1) * 30
        }

        Text {
            id: userCollectPlaylistTitle

            text: "我收藏的歌单"
            font.pixelSize: 20
            font.bold: true
        }

        GridPlaylists {
            id: userCollectPlaylistGrid

            width: parent.width
            height: collectPlaylistRows * ((scrollWidth - 30 * 4) * 0.2 + 25) + (collectPlaylistRows - 1) * 30
        }

    }

}
