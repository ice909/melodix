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
        columnSpacing: 30
        rowSpacing: 30

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 30 * 4) * 0.2
                height: width + 20
                color: "transparent"

                RoundedImage {
                    id: img

                    width: parent.width
                    height: parent.width
                    imgSrc: modelData.coverImgUrl

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onPressed: {
                            Router.showPlaylistDetail(modelData.id);
                        }
                    }

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
