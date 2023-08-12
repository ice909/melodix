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
        columns: 5
        columnSpacing: 30
        rowSpacing: 10

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 30 * 4) * 0.2
                height: width + 30
                color: "transparent"

                RoundedImage {
                    id: img

                    width: parent.height - 30
                    height: parent.height - 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    imgSrc: modelData.img1v1Url
                    borderRadius: height
                }

                Rectangle {
                    anchors.top: img.bottom
                    anchors.horizontalCenter: img.horizontalCenter
                    width: img.width
                    height: 30
                    color: "transparent"

                    Text {
                        id: title

                        anchors.centerIn: parent
                        text: modelData.name
                        font.pixelSize: DTK.fontManager.t5.pixelSize
                    }

                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onPressed: {
                    }
                }

            }

        }

    }

}
