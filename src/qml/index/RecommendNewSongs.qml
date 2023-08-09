import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import org.deepin.dtk 1.0

Rectangle {
    property alias lists: repeater.model

    Grid {
        id: gridLayout

        anchors.fill: parent
        columns: 2
        columnSpacing: 20
        rowSpacing: 20

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 20) * 0.5
                height: width * 0.15
                color: "transparent"

                RoundedImage {
                    id: img

                    width: parent.height
                    height: parent.height
                    imgSrc: modelData.picUrl
                }

                Rectangle {
                    anchors.left: img.right
                    anchors.right: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: img.verticalCenter
                    height: img.height - 15
                    color: "transparent"

                    Text {
                        id: title

                        anchors.left: parent.left
                        anchors.topMargin: 5
                        width: parent.width
                        text: modelData.song.name
                        elide: Qt.ElideRight
                        font.pixelSize: DTK.fontManager.t5.pixelSize
                    }

                    Text {
                        anchors.top: title.bottom
                        anchors.topMargin: 5
                        width: parent.width
                        text: modelData.song.artists[0].name
                        font.pixelSize: DTK.fontManager.t6.pixelSize
                        elide: Qt.ElideRight
                    }

                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onPressed: {
                        //点击新歌时，获取歌曲id，拿着歌曲id去获取歌曲url
                        getMusicUrl(modelData.id, modelData.song.name, modelData.picUrl, modelData.song.artists[0].name, formatDuration(modelData.song.duration));
                    }
                }

            }

        }

    }

}
