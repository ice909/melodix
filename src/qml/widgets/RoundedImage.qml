import QtGraphicalEffects 1.15
import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    property string imgSrc: ""
    property int borderRadius: 5
    property bool isRotating: false
    property real rotationPosition: 0

    Image {
        id: image

        anchors.centerIn: parent
        source: imgSrc === "" ? "" : (imgSrc + "?param=400y400")
        sourceSize.width: 400
        sourceSize.height: 400
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
        id: opacityMask
        anchors.fill: image
        source: image
        maskSource: mask
        visible: true
        antialiasing: true
    }

    RotationAnimation {
        id: rotationAnimation
        target: opacityMask
        property: "rotation"
        from: rotationPosition
        to: rotationPosition + 360
        duration: 20000
        loops: Animation.Infinite
        running: isRotating
        onStopped: {
            rotationPosition = opacityMask.rotation % 360
        }
    }

}
