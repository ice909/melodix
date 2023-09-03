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

        Repeater {
            id: repeater

            Rectangle {
                width: (parent.width - 80) * 0.2
                height: width + 30
                color: "transparent"

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
                        imgSrc: modelData.picUrl
                        borderRadius: height
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
                                Router.showArtist(modelData.id);
                            }
                        }

                    }

                }

                Rectangle {
                    width: parent.width
                    height: 30
                    anchors.top: imgRect.bottom
                    anchors.horizontalCenter: imgRect.horizontalCenter
                    color: "transparent"

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
