import "../../router"
import QtQuick 2.11
import org.deepin.dtk 1.0

// 标题栏的菜单切换按钮
ButtonBox {
    id: root

    ToolButton {
        id: indexBtn

        leftPadding: 10
        rightPadding: 10
        implicitHeight: root.height - 6
        checked: Router.routeCurrent.path === Router.routeIndex.path
        text: qsTr("首页")
        font.weight: Font.Medium
        font.pixelSize: DTK.fontManager.t6.pixelSize
        onClicked: {
            Router.showIndex();
        }
    }

    ToolButton {
        id: discoverBtn

        leftPadding: 10
        rightPadding: 10
        implicitHeight: root.height - 6
        checked: Router.routeCurrent.path === Router.routeDiscover.path
        text: qsTr("发现")
        font.weight: Font.Medium
        font.pixelSize: DTK.fontManager.t6.pixelSize
        onClicked: {
            Router.showDiscover();
        }
    }

    ToolButton {
        id: libraryBtn

        leftPadding: 10
        rightPadding: 10
        implicitHeight: root.height - 6
        checked: Router.routeCurrent.path === Router.routeLibrary.path
        text: qsTr("音乐库")
        font.weight: Font.Medium
        font.pixelSize: DTK.fontManager.t6.pixelSize
        onClicked: {
            Router.showLibrary();
        }
    }

}
