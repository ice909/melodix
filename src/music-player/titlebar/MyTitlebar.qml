import "../router"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0
import org.deepin.dtk.style 1.0 as DS

// 窗口图标和返回按钮
TitleBar {
    id: root

    height: DS.Style.titleBar.height

    // 阴影
    BoxShadow {
        anchors.fill: parent
        shadowBlur: 10
        shadowColor: Qt.rgba(0, 0, 0, 0.03)
        shadowOffsetX: 0
        shadowOffsetY: 4
        hollow: true
    }

    leftContent: Button {
        visible: Router.routeCurrent !== Router.routeIndex
        width: 36
        height: 36
        icon.name: "arrow_ordinary_left"
        icon.width: 7
        icon.height: 12
        onClicked: {
            Router.back();
        }
    }

    content: ColumnLayout {
        Rectangle {
            color: Qt.rgba(0, 0, 0, 0.01)
            Layout.fillWidth: true
            height: root.height

            TabButton {
                anchors.centerIn: parent
                height: 36
            }

        }

    }

}
