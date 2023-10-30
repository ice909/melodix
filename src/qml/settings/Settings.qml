import "../../util"
import "../widgets"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool loading: true

    TabBar {
        id: tabBar

        anchors.top: parent.top

        TabButton {
            text: "通用"
        }

    }

    StackLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: tabBar.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 4
        currentIndex: tabBar.currentIndex

        Common {
        }

    }

    Rectangle {
        visible: loading
        anchors.fill: root
        color: Util.pageBackgroundColor

        Loading {
            anchors.centerIn: parent
        }

    }

}
