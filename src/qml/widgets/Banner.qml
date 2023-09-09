import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property alias imgs: bannerView.model

    Timer {
        id: timer

        running: true
        repeat: true
        interval: 3000
        onTriggered: {
            bannerView.incrementCurrentIndex();
        }
    }

    PathView {
        id: bannerView

        anchors.fill: parent
        clip: true
        pathItemCount: 3
        path: bannerPath
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5

        delegate: Item {
            id: delegateItem

            width: bannerView.width * 0.5
            height: bannerView.height
            z: PathView.z ? PathView.z : 0
            scale: PathView.scale ? PathView.scale : 1

            RoundedImage {
                id: image

                imgSrc: modelData.imageUrl + "?param=" + image.width + "y" + image.height
                width: delegateItem.width
                height: delegateItem.height
                borderRadius: 10
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (bannerView.currentIndex !== index) {
                        bannerView.currentIndex = index;
                    } else {
                        console.log(imgs[index].url);
                        Qt.openUrlExternally(imgs[index].url);
                    }
                }
            }

        }

    }

    PageIndicator {
        id: pageIndicator

        count: bannerView.count
        currentIndex: bannerView.currentIndex
        spacing: 10

        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        delegate: Rectangle {
            width: 10
            height: 10
            radius: 10
            color: index == bannerView.currentIndex ? palette.highlight : "gainsboro"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    bannerView.currentIndex = index;
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: 200
                }

            }

        }

    }

    Path {
        id: bannerPath

        startX: 0
        startY: bannerView.height / 2 - 10

        PathAttribute {
            name: 'z'
            value: 0
        }

        PathAttribute {
            name: 'scale'
            value: 0.6
        }

        PathLine {
            x: bannerView.width / 2
            y: bannerView.height / 2 - 10
        }

        PathAttribute {
            name: 'z'
            value: 2
        }

        PathAttribute {
            name: 'scale'
            value: 0.85
        }

        PathLine {
            x: bannerView.width
            y: bannerView.height / 2 - 10
        }

        PathAttribute {
            name: 'z'
            value: 0
        }

        PathAttribute {
            name: 'scale'
            value: 0.6
        }

    }

}
