import "../../router"
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
                height: width + 30
                color: "transparent"

                RoundedImage {
                    id: img

                    width: parent.width
                    height: parent.width
                    imgSrc: modelData.picUrl

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onPressed: {
                            Router.showPlaylistDetail(modelData.id);
                        }
                    }

                }

                Rectangle {
                    anchors.top: img.bottom
                    anchors.horizontalCenter: img.horizontalCenter
                    width: img.width
                    height: 30
                    color: "transparent"

                    Text {
                        anchors.left: parent.left
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
