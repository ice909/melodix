import QtQuick 2.0
import QtQuick.Controls 2.4
import org.deepin.dtk 1.0

Control {
    id: root

    property ListModel model

    Rectangle {
        id: main

        anchors.fill: parent
        visible: false

        Component {
            id: delegate

            Item {
                id: item

                Image {
                    id: raw

                    width: root.width
                    height: root.height
                    source: img
                }

            }

        }

        PathView {
            id: pathView

            model: root.model
            delegate: delegate

            path: Path {
                startX: -root.width
                startY: 0

                PathLine {
                    x: (model.count - 1) * root.width
                    y: 0
                }

            }

        }

    }

    Rectangle {
        id: mask

        width: root.width
        height: root.height
        radius: 10
        visible: false
    }

    OpacityMask {
        width: root.width
        height: root.height
        source: main
        maskSource: mask

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                let index = pathView.currentIndex + 1;
                if (index >= pathView.count)
                    index = 0;

                Qt.openUrlExternally(root.model.get(index).url);
            }
        }

    }

    Timer {
        id: timer

        interval: 3000
        repeat: true
        running: true
        onTriggered: {
            pathView.incrementCurrentIndex();
        }
    }

}
