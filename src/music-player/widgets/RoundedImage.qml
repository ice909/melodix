import QtGraphicalEffects 1.15
import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    property string imgSrc: ""
    property int borderRadius: 5
    property bool animateOnHover: false

    Image {
        id: image

        anchors.centerIn: parent
        source: imgSrc
        smooth: true
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        antialiasing: true
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

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            if (animateOnHover)
                parent.scale = 1.1;

        }
        onExited: {
            if (animateOnHover)
                parent.scale = 1;

        }
    }

    Behavior on scale {
        PropertyAnimation {
            duration: 200
        }

    }

}
