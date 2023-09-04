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
        columns: 5
        columnSpacing: 30
        rowSpacing: 10

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 30 * 4) * 0.2
                height: width + 30
                color: "transparent"

                Rectangle {
                    id: imgRect

                    width: parent.height - 30
                    height: parent.height - 30
                    color: "transparent"
                    radius: width

                    RoundedImage {
                        id: img

                        width: parent.height - 5
                        height: parent.height - 5
                        anchors.centerIn: parent
                        imgSrc: modelData.img1v1Url
                        borderRadius: height
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
                            Router.showArtist(modelData.id);
                        }
                    }

                }

                Rectangle {
                    anchors.top: imgRect.bottom
                    anchors.horizontalCenter: imgRect.horizontalCenter
                    width: imgRect.width
                    height: 30
                    color: "transparent"

                    Text {
                        id: title

                        anchors.centerIn: parent
                        text: modelData.name
                        font.pixelSize: DTK.fontManager.t5.pixelSize
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
                            Router.showArtist(modelData.id);
                        }
                    }

                }

            }

        }

    }

}
