import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    property alias lists: repeater.model

    Grid {
        id: gridLayout

        anchors.fill: parent
        columns: 2
        columnSpacing: width * 0.05

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 20) * 0.47
                height: parent.height + 20
                color: "transparent"

                RoundedImage {
                    id: img

                    width: parent.width - 20
                    height: parent.height - 20
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
