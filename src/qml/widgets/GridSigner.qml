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

        Repeater {
            id: repeater

            Item {
                width: (parent.width - 30 * 4) * 0.2
                height: parent.height

                RoundedImage {
                    id: img

                    width: parent.width
                    height: parent.width
                    imgSrc: modelData.img1v1Url
                    borderRadius: width

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                        }
                        onExited: {
                        }
                        onClicked: {
                            Router.showArtist(modelData.id);
                        }
                    }

                }

                Item {
                    width: parent.width
                    height: 30
                    anchors.top: img.bottom
                    anchors.horizontalCenter: img.horizontalCenter

                    Text {
                        id: title

                        anchors.centerIn: parent
                        font.pixelSize: DTK.fontManager.t5.pixelSize
                        text: modelData.name
                        color: Util.textColor

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
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
