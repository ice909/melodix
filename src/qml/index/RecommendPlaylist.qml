import "../../router"
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
        columns: 5
        columnSpacing: 20
        rowSpacing: 20

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 20 * 4) * 0.2
                height: width + 30
                color: "transparent"

                Rectangle {
                    id: imgRect

                    width: parent.width
                    height: parent.width
                    color: "transparent"
                    radius: 5

                    RoundedImage {
                        id: img

                        width: parent.width - 10
                        height: parent.height - 10
                        anchors.centerIn: parent
                        imgSrc: modelData.picUrl

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onEntered: {
                                imgRect.color = Util.mouseHoverColor;
                            }
                            onExited: {
                                imgRect.color = "transparent";
                            }
                            onPressed: {
                                imgRect.color = Util.mousePressedColor;
                            }
                            onReleased: {
                                imgRect.color = Util.mouseReleasedColor;
                            }
                            onClicked: {
                                Router.showPlaylistDetail(modelData.id);
                            }
                        }

                    }

                }

                Rectangle {
                    anchors.top: imgRect.bottom
                    anchors.horizontalCenter: imgRect.horizontalCenter
                    width: imgRect.width - 10
                    anchors.leftMargin: 10
                    height: 30
                    color: "transparent"

                    Text {
                        id: playlistTitle

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        text: modelData.name
                        elide: Qt.ElideRight
                        color: Util.textColor
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            playlistTitle.font.underline = true;
                        }
                        onExited: {
                            playlistTitle.font.underline = false;
                        }
                        onClicked: {
                            Router.showPlaylistDetail(modelData.id);
                        }
                    }

                }

            }

        }

    }

}
