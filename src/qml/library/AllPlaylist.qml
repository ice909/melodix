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

                    width: parent.width
                    height: parent.width
                    color: "transparent"
                    radius: 5

                    RoundedImage {
                        id: img

                        width: parent.height - 10
                        height: parent.height - 10
                        anchors.centerIn: parent
                        imgSrc: modelData.coverImgUrl
                    }

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

                Rectangle {
                    anchors.top: imgRect.bottom
                    anchors.horizontalCenter: imgRect.horizontalCenter
                    width: imgRect.width
                    height: 30
                    color: "transparent"

                    Text {
                        id: title

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        text: modelData.name
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
                            Router.showPlaylistDetail(modelData.id);
                        }
                    }

                }

            }

        }

    }

}
