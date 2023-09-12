import "../../router"
import "../../util"
import QtQuick 2.11
import QtQuick.Controls 2.4
import org.deepin.dtk 1.0

Item {
    property alias lists: repeater.model

    Grid {
        id: gridLayout

        anchors.fill: parent
        columns: 5
        columnSpacing: 30
        rowSpacing: 15

        Repeater {
            id: repeater

            Item {
                width: (scrollWidth - 30 * 4) * 0.2
                height: width + 30

                Rectangle {
                    id: imgRect

                    width: parent.width
                    height: parent.width
                    color: "transparent"
                    radius: width

                    RoundedImage {
                        id: img

                        width: parent.width - 10
                        height: parent.width - 10
                        imgSrc: modelData.img1v1Url
                        borderRadius: height
                        anchors.centerIn: parent

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

                }

                Item {
                    width: parent.width
                    height: 30
                    anchors.top: imgRect.bottom
                    anchors.horizontalCenter: imgRect.horizontalCenter

                    Text {
                        id: title

                        anchors.centerIn: parent
                        font.pixelSize: DTK.fontManager.t4.pixelSize
                        text: modelData.name
                        color: Util.textColor

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

}
