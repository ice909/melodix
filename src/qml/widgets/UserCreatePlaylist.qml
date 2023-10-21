import "../../router"
import "../../util"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root
    property alias lists: userCreatePlaylistGrid.lists
    property int playlistRows: 0

    width: scrollWidth
    height: userCreatePlaylistTitle.height + userCreatePlaylistGrid.height + 20    

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
            height: playlistRows * ((scrollWidth - 30 * 4) * 0.2 + 25) + (playlistRows - 1) * 30
        }
    }
}