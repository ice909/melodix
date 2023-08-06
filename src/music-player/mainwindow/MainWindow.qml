import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import audio.global 1.0
import org.deepin.dtk 1.0

ApplicationWindow {
    id: rootWindow

    property int windowMiniWidth: 1070
    property int windowMiniHeight: 680

    visible: true
    minimumWidth: windowMiniWidth
    minimumHeight: windowMiniHeight
    width: windowMiniWidth
    height: windowMiniHeight
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    DWindow.enabled: true
    DWindow.alphaBufferSize: 8
    flags: Qt.Window | Qt.WindowMinMaxButtonsHint | Qt.WindowCloseButtonHint | Qt.WindowTitleHint

    header: TitleBar {
    }

    background: Rectangle {
        id: rightBgArea

        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.01)

        BoxShadow {
            anchors.fill: rightBgArea
            shadowOffsetX: 0
            shadowOffsetY: 4
            shadowColor: Qt.rgba(0, 0, 0, 0.05)
            shadowBlur: 10
            cornerRadius: rightBgArea.radius
            spread: 0
            hollow: true
        }

    }

}
