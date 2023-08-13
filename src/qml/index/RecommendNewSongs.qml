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

                Row {
                    anchors.fill: parent
                    spacing: 10

                    RoundedImage {
                        id: img

                        width: parent.height
                        height: parent.height
                        imgSrc: modelData.picUrl
                    }

                    Rectangle {
                        id: infoRect

                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - img.width - 10
                        height: parent.height - 15
                        color: "transparent"

                        Column {
                            anchors.centerIn: parent
                            spacing: 5

                            Text {
                                width: infoRect.width
                                text: modelData.song.name
                                elide: Qt.ElideRight
                                font.pixelSize: DTK.fontManager.t5.pixelSize
                            }

                            Text {
                                width: infoRect.width
                                text: modelData.song.artists[0].name
                                font.pixelSize: DTK.fontManager.t6.pixelSize
                                elide: Qt.ElideRight
                            }

                        }

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
