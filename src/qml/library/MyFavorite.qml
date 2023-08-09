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
        columns: 3
        rows: 4
        columnSpacing: 30
        rowSpacing: 10

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 30 * 2) * 0.333333
                height: (parent.height - 10 * 3) / 4
                color: "transparent"

                RoundedImage {
                    id: img

                    width: parent.height - 5
                    height: parent.height - 5
                    anchors.verticalCenter: parent.verticalCenter
                    imgSrc: modelData.al.picUrl
                }

                Rectangle {
                    anchors.left: img.right
                    anchors.right: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: img.verticalCenter
                    height: parent.height - 10

                    Text {
                        id: title

                        anchors.left: parent.left
                        width: parent.width
                        text: modelData.name
                        elide: Qt.ElideRight
                        font.pixelSize: DTK.fontManager.t7.pixelSize
                    }

                    Text {
                        anchors.top: title.bottom
                        width: parent.width
                        text: modelData.ar[0].name
                        font.pixelSize: DTK.fontManager.t8.pixelSize
                        elide: Qt.ElideRight
                    }

                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onPressed: {
                        //点击时，拿着歌曲id去获取歌曲url
                        getMusicUrl(modelData.id, modelData.name, modelData.al.picUrl, modelData.ar[0].name, formatDuration(modelData.dt));
                    }
                }

            }

        }

    }

}
