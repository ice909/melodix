import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import org.deepin.dtk 1.0

Rectangle {
    property alias lists: repeater.model

    Grid {
        id: gridLayout

        anchors.fill: parent
        columns: 6
        columnSpacing: 10

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 50) * 0.166667
                height: parent.height + 20
                color: "transparent"

                RoundedImage {
                    id: img

                    width: parent.width
                    height: parent.width
                    imgSrc: modelData.picUrl
                    borderRadius: height
                }

                Text {
                    id: title

                    anchors.top: img.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: img.horizontalCenter
                    text: modelData.name
                }

            }

        }

    }

}
