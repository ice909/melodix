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
        Rectangle {
            color: "transparent"
            Layout.fillWidth: true
            height: root.height

            TabButton {
                anchors.centerIn: parent
                height: 36
                visible: !isLyricShow
            }

            MySearchEdit {
                visible: !isLyricShow
                anchors.right: accoutBtn.left
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width / 4.2
            }

            AccountButton {
                id: accoutBtn

                anchors.right: parent.right
                width: parent.height
                height: parent.height
            }

        }

    }

}
