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
        columns: 2
        columnSpacing: 20

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 20) * 0.5
                height: width / 2.9
                color: "transparent"

                Rectangle {
                    id: imgRect

                    width: parent.width
                    height: parent.height - 30
                    color: "transparent"
                    radius: 5

                    RoundedImage {
                        id: img

                        width: parent.width - 5
                        height: parent.height - 5
                        imgSrc: modelData.picUrl
                        anchors.centerIn: parent

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
                                Router.showMv(modelData.id);
                            }
                        }

                    }

                }

                Rectangle {
                    width: parent.width
                    height: 30
                    color: "transparent"
                    anchors.top: imgRect.bottom
                    anchors.horizontalCenter: imgRect.horizontalCenter

                    Text {
                        id: title

                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        text: modelData.name
                        elide: Qt.ElideRight
                        color: Util.textColor
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onEntered: {
                            title.font.underline = true;
                        }
                        onExited: {
                            title.font.underline = false;
                        }
                        onClicked: {
                            Router.showMv(modelData.id);
                        }
                    }

                }

            }

        }

    }

}
