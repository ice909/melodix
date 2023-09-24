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

                    Item {
                        width: parent.height + 2
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter

                        RoundedImage {
                            id: img

                            width: parent.height - 3
                            height: parent.height - 3
                            anchors.left: parent.left
                            anchors.leftMargin: 2
                            imgSrc: modelData.picUrl
                            anchors.verticalCenter: parent.verticalCenter
                        }

                    }

                    Item {
                        id: infoRect

                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - img.width - 10
                        height: parent.height - 15

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
                                text: Util.spliceSinger(modelData.song.artists)
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
                        color = Util.mouseHoverColor;
                    }
                    onExited: {
                        color = "transparent";
                    }
                    onPressed: {
                        color = Util.mousePressedColor;
                    }
                    onReleased: {
                        color = Util.mouseReleasedColor;
                    }
                    onClicked: {
                        //点击新歌时，获取歌曲id，拿着歌曲id去获取歌曲url
                        getMusicUrl(modelData.id, modelData.song.name, modelData.picUrl, Util.spliceSinger(modelData.song.artists), Util.formatDuration(modelData.song.duration), modelData.song.album.name, Util.isVip(modelData.song.fee));
                    }
                }

            }

        }

    }

}
