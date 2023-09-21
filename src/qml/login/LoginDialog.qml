import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Popup {
    id: root

    width: 300
    height: 390
    visible: true
    x: (rootWindow.width - width) / 2
    y: (rootWindow.height - height) / 2 - 60
    modal: true
    Component.onCompleted: {
        console.log("登录窗口初始化完成");
    }
    onClosed: {
        console.log("登录窗口关闭");
    }

    Column {
        anchors.fill: parent
        spacing: 5

        ButtonBox {
            id: tabBtn

            anchors.horizontalCenter: parent.horizontalCenter

            ToolButton {
                text: "手机登录"
                checked: true
                checkable: true
                onClicked: {
                    loginLoader.setSource("./CaptchaLogin.qml");
                }
            }

            ToolButton {
                text: "密码登录"
                checkable: true
                onClicked: {
                    loginLoader.setSource("./PasswordLogin.qml");
                }
            }

            ToolButton {
                text: "扫码登录"
                checkable: true
                onClicked: {
                    loginLoader.setSource("./QRCodeLogin.qml");
                }
            }

            background: Rectangle {
                color: Qt.rgba(240, 255, 255, 0.3)
                radius: 8
            }

        }

        Loader {
            id: loginLoader

            width: root.width - 20
            height: root.height - tabBtn.height - 20
            source: "./CaptchaLogin.qml"
        }

    }

    background: FloatingPanel {
        blurRadius: 20
    }

}
