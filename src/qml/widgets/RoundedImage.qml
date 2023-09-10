import QtGraphicalEffects 1.15
import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    property string imgSrc: ""
    property int borderRadius: 5

    Image {
        id: image

        anchors.centerIn: parent
        source: imgSrc
        smooth: true
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        antialiasing: true
        asynchronous: true
        visible: false
    }

    Rectangle {
        id: mask

        anchors.fill: parent
        color: "black"
        radius: borderRadius
        visible: false
        smooth: true
        antialiasing: true
    }

    OpacityMask {
        anchors.fill: image
        source: image
        maskSource: mask
        visible: true
        antialiasing: true
    }

}
