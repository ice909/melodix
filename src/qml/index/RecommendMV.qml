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

                RoundedImage {
                    id: img

                    width: parent.width
                    height: parent.height - 30
                    imgSrc: modelData.picUrl

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onPressed: {
                            Router.showMv(modelData.id);
                        }
                    }

                }

                Rectangle {
                    width: parent.width
                    height: 30
                    color: "transparent"
                    anchors.top: img.bottom
                    anchors.horizontalCenter: img.horizontalCenter

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        text: modelData.name
                        elide: Qt.ElideRight
                        color: Util.textColor
                    }

                }

            }

        }

    }

}
