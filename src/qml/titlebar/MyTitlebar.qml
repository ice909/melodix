import "../../router"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0
import org.deepin.dtk.style 1.0 as DS

// 窗口图标和返回按钮
TitleBar {
    id: root

    signal lrcHideBtnClicked()

    height: DS.Style.titleBar.height
    embedMode: false
    hoverEnabled: false
    icon.name: isLyricShow ? "" : "melodix"

    leftContent: ToolButton {
        visible: Router.routeCurrent !== Router.routeIndex || isLyricShow
        width: 36
        height: 36
        icon.name: isLyricShow ? "go-down" : "arrow_ordinary_left"
        icon.width: 12
        icon.height: 12
        onClicked: {
            if (!isLyricShow)
                Router.back();
            else
                lrcHideBtnClicked();
        }
    }

    content: ColumnLayout {
        Item {
            Layout.fillWidth: true
            height: root.height

            MySearchEdit {
                visible: !isLyricShow
                anchors.centerIn: parent
                width: parent.width / 3
            }

            NickNameButton {
                id: nickNameBtn

                anchors.right: parent.right
                width: 100
                height: parent.height
            }

        }

    }

    menu: Menu {
        x: 0
        y: 0
        width: 200

        ThemeMenu {
            width: 200
        }

        MenuItem {
            id: settingsControl

            text: "设置"
            onTriggered: {
                Router.showSettings();
            }
        }

        QuitAction {
            text: "退出"
            onTriggered: {
                Qt.quit();
            }
        }

    }

}
