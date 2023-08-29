import "../../router"
import "../../util"
import "../widgets"
import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import org.deepin.dtk 1.0

Item {
    property alias lists: repeater.model

    Grid {
        id: gridLayout

        anchors.fill: parent
        columns: 4
        columnSpacing: 30
        rowSpacing: 10

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 30 * 3) * 0.25
                height: width - 60
                color: "transparent"

                RoundedImage {
                    id: img

                    width: parent.width
                    height: parent.height - 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    imgSrc: modelData.coverUrl
                }

                Rectangle {
                    anchors.top: img.bottom
                    anchors.horizontalCenter: img.horizontalCenter
                    width: img.width
                    height: 30
                    color: "transparent"

                    Text {
                        id: title

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        text: modelData.title
                        elide: Qt.ElideRight
                        font.pixelSize: DTK.fontManager.t7.pixelSize
                        color: Util.textColor
                    }

                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Router.showMv(modelData.vid);
                    }
                }

            }

        }

    }

}
