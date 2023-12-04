import "../../router"
import "../../util"
import "../widgets"
import Melodix.Player 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

ItemDelegate {
    id: rootDelegate

    property Menu rightClickMenu

    width: listView.width - 40
    height: 55
    hoverEnabled: true
    backgroundVisible: index % 2 === 0
    checked: index == currentSelectIndex

    MouseArea {
        id: mouseArea

        acceptedButtons: Qt.RightButton | Qt.LeftButton
        anchors.fill: parent
        onDoubleClicked: {
            console.log("clicked index : " + index);
            currentSelectIndex = index;
            if (!isAddToPlaylist)
                playPlaylistAllMusic(index);
            else
                Player.play(index);
        }
        onPressed: {
            if (mouse.button === Qt.RightButton) {
                rightClickMenu.clickIndex = index;
                rightClickMenu.playState = Player.getPlayState();
                rightClickMenu.playIndex = Player.getCurrentIndex();
                rightClickMenu.popup();
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: rootDelegate.hovered ? Qt.rgba(0, 0, 0, 0.08) : Qt.rgba(0, 0, 0, 0)

        RowLayout {
            anchors.fill: parent

            RoundedImage {
                Layout.leftMargin: 10
                imgSrc: modelData.al.picUrl
                height: 45
                width: 45
            }

            Item {
                Layout.preferredWidth: 300
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 5
                height: 45

                Label {
                    id: title

                    width: 280
                    text: modelData.name
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 2.5
                    font.bold: true
                    elide: Qt.ElideRight
                }

                Label {
                    width: 280
                    text: Util.spliceSinger(modelData.ar)
                    anchors.left: parent.left
                    anchors.top: title.bottom
                    elide: Qt.ElideRight
                }

            }

            Label {
                text: modelData.al.name
            }

            Item {
                Layout.fillWidth: true
            }

            Label {
                Layout.rightMargin: 10
                font.bold: true
                text: Util.formatDuration(modelData.dt)
            }

        }

    }

    rightClickMenu: RightClickMenu {
    }

}
