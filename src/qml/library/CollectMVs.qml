import "../../router"
import "../../util"
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
        columns: 4
        columnSpacing: 30
        rowSpacing: 10

        Repeater {
            id: repeater

            Item {
                width: (parent.width - 30 * 3) * 0.25
                height: width - 60

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
                        anchors.centerIn: parent
                        imgSrc: modelData.coverUrl
                    }

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
                            Router.showMv(modelData.vid);
                        }
                    }

                }

                Item {
                    anchors.top: imgRect.bottom
                    anchors.horizontalCenter: imgRect.horizontalCenter
                    width: imgRect.width
                    height: 30

                    Text {
                        id: title

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        text: modelData.title
                        elide: Qt.ElideRight
                        font.pixelSize: DTK.fontManager.t7.pixelSize
                        color: Util.textColor
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            title.font.underline = true;
                        }
                        onExited: {
                            title.font.underline = false;
                        }
                        onClicked: {
                            Router.showMv(modelData.vid);
                        }
                    }

                }

            }

        }

    }

}
