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

                RoundedImage {
                    id: img

                    width: parent.width
                    height: parent.width
                    imgSrc: modelData.picUrl
                    borderRadius: height

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Router.showArtist(modelData.id);
                        }
                    }

                }

                Rectangle {
                    width: parent.width
                    anchors.top: img.bottom
                    anchors.horizontalCenter: img.horizontalCenter
                    height: 30
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
