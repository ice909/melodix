import "../../router"
import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    property ListModel lists

    Grid {
        id: gridLayout

        anchors.fill: parent
        columns: 5
        columnSpacing: 30
        rowSpacing: 30

        Repeater {
            id: repeater

            model: lists

            Rectangle {
                width: (parent.width - 30 * 4) * 0.2
                height: width + 20
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
                        height: parent.width - 10
                        anchors.centerIn: parent
                        imgSrc: modelData.coverImgUrl

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onEntered: {
                                imgRect.color = Qt.rgba(0, 0, 0, 0.2);
                            }
                            onExited: {
                                imgRect.color = "transparent";
                            }
                            onPressed: {
                                imgRect.color = Qt.rgba(0, 0, 0, 0.3);
                            }
                            onReleased: {
                                imgRect.color = Qt.rgba(0, 0, 0, 0.2);
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
                        id: hotPlaylistTitle

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        text: modelData.name
                        elide: Qt.ElideRight

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onEntered: {
                                hotPlaylistTitle.font.underline = true;
                            }
                            onExited: {
                                hotPlaylistTitle.font.underline = false;
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

    lists: ListModel {
    }

}
