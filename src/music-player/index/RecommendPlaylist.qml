import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    property alias lists: repeater.model

    Grid {
        id: gridLayout

        anchors.fill: parent
        columns: 5
        columnSpacing: 20
        rowSpacing: 20

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 20 * 4) * 0.2
                height: (parent.height - 40) / 2 + 20
                color: "transparent"

                RoundedImage {
                    id: img

                    width: parent.width
                    height: parent.width
                    imgSrc: modelData.picUrl
                }

                Text {
                    anchors.top: img.bottom
                    anchors.topMargin: 5
                    width: parent.width
                    text: modelData.name
                    elide: Qt.ElideRight
                }

            }

        }

    }

}
