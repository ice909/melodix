import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import org.deepin.dtk 1.0

Item {
    property alias lists: repeater.model

    Grid {
        id: gridLayout

        anchors.fill: parent
        columns: 3
        columnSpacing: 50
        rowSpacing: 20

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 100) * 0.33333
                height: width * 0.15
                color: "transparent"
                radius: 5

                Row {
                    anchors.fill: parent
                    spacing: 10

                    RoundedImage {
                        id: img

                        width: parent.height - 5
                        height: parent.height - 5
                        anchors.verticalCenter: parent.verticalCenter
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
                                font.pixelSize: DTK.fontManager.t6.pixelSize
                                color: Util.textColor
                            }

                            Text {
                                width: infoRect.width
                                text: modelData.song.artists[0].name
                                font.pixelSize: DTK.fontManager.t7.pixelSize
                                elide: Qt.ElideRight
                                color: Util.textColor
                            }

                        }

                    }

                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: {
                        color = Qt.rgba(0, 0, 0, 0.1);
                    }
                    onExited: {
                        color = "transparent";
                    }
                    onPressed: {
                        color = Qt.rgba(0, 0, 0, 0.2);
                    }
                    onReleased: {
                        color = Qt.rgba(0, 0, 0, 0.1);
                    }
                    onClicked: {
                        //点击新歌时，获取歌曲id，拿着歌曲id去获取歌曲url
                        getMusicUrl(modelData.id, modelData.song.name, modelData.picUrl, modelData.song.artists[0].name, Util.formatDuration(modelData.song.duration));
                    }
                }

            }

        }

    }

}
