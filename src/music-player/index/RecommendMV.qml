import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    property alias lists: repeater.model

    Grid {
        id: gridLayout

        anchors.fill: parent
        columns: 2
        columnSpacing: 20

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 20) * 0.5
                height: width / 2.9
                color: "transparent"

                RoundedImage {
                    id: img

                    width: parent.width
                    height: parent.height - 30
                    imgSrc: modelData.picUrl
                }

                Rectangle {
                    width: parent.width
                    height: 30
                    color: "transparent"
                    anchors.top: img.bottom
                    anchors.horizontalCenter: img.horizontalCenter

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        text: modelData.name
                        elide: Qt.ElideRight
                    }

                }

            }

        }

    }

}
