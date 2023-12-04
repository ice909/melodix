import "../../util"
import "../widgets"
import Melodix.Player 1.0
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    property alias lists: repeater.model

    Grid {
        id: gridLayout

        anchors.fill: parent
        columns: 4
        rows: 3
        columnSpacing: 30
        rowSpacing: 10

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 30 * 3) * 0.25
                height: width / 4
                color: "transparent"
                radius: 5

                RoundedImage {
                    id: img

                    width: parent.height - 5
                    height: parent.height - 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    imgSrc: modelData.al.picUrl
                }

                Item {
                    id: infoRect

                    width: parent.width - img.width - 10
                    anchors.left: img.right
                    anchors.right: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: img.verticalCenter
                    height: parent.height - 10

                    Column {
                        anchors.centerIn: parent
                        spacing: 5

                        Text {
                            id: title

                            width: infoRect.width
                            text: modelData.name
                            elide: Qt.ElideRight
                            font.pixelSize: DTK.fontManager.t7.pixelSize
                            color: Util.textColor
                        }

                        Text {
                            width: infoRect.width
                            text: modelData.ar[0].name
                            font.pixelSize: DTK.fontManager.t8.pixelSize
                            elide: Qt.ElideRight
                            color: Util.textColor
                        }

                    }

                }

                BoxShadow {
                    id: imgShadow

                    visible: false
                    anchors.fill: parent
                    shadowBlur: 8
                    shadowColor: palette.highlight
                    spread: 1.5
                    shadowOffsetX: 0
                    shadowOffsetY: 0
                    cornerRadius: 5
                    hollow: true
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        imgShadow.visible = true;
                    }
                    onExited: {
                        imgShadow.visible = false;
                    }
                    onClicked: {
                        Player.addSingleToPlaylist(modelData.id, modelData.name, modelData.ar[0].name, modelData.al.picUrl, Util.formatDuration(modelData.dt), modelData.al.name, Util.isVip(modelData.fee));
                    }
                }

            }

        }

    }

}
