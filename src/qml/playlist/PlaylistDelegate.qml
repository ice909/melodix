import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.11
import org.deepin.dtk 1.0

ItemDelegate {
    id: rootDelegate

    property int imgCellRectWidth: 40
    property int timeRectWidth: 54
    property int spacingWidth: 10

    width: 300
    height: 56
    hoverEnabled: true
    checked: index === selectedIndex

    MouseArea {
        id: mouseArea

        acceptedButtons: Qt.RightButton | Qt.LeftButton
        anchors.fill: parent
        onDoubleClicked: {
            playlistView.currentIndex = index;
            selectedIndex = index;
            console.log("index: " + index + " currentIndex: " + playlistView.currentIndex);
            player.play(index);
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        radius: 8
        color: rootDelegate.hovered ? Qt.rgba(0, 0, 0, 0.08) : Qt.rgba(0, 0, 0, 0)

        Row {
            width: parent.width
            height: parent.height
            spacing: 10
            leftPadding: 10
            anchors.centerIn: parent

            RoundedImage {
                id: imagecell

                width: 40
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                imgSrc: model.image
            }

            Item {
                id: musicInfoRect

                width: parent.width - (imgCellRectWidth + timeRectWidth + spacingWidth * 2)
                height: 40
                anchors.verticalCenter: parent.verticalCenter

                Column {
                    width: parent.width
                    height: parent.height
                    spacing: 1
                    anchors.centerIn: parent

                    Label {
                        id: musicNameLabel

                        width: parent.width
                        height: 20
                        elide: Text.ElideRight
                        text: model.title
                        verticalAlignment: Qt.AlignVCenter
                        font: DTK.fontManager.t6
                    }

                    Label {
                        id: musicSingerLabel

                        width: parent.width
                        height: 17
                        elide: Text.ElideRight
                        text: model.author
                        verticalAlignment: Qt.AlignVCenter
                        font: DTK.fontManager.t8
                    }

                }

            }

            Label {
                id: musicTimeLabel

                width: timeRectWidth
                height: parent.height
                elide: Text.ElideRight
                text: model.duration
                verticalAlignment: Qt.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                font: DTK.fontManager.t8
            }

        }

    }

}
