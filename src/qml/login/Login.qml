import "../../util"
import "../widgets"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
    }

    Item {
        id: centerArea
        width: parent.width / 2
        height: parent.height * 0.8
        anchors.centerIn: parent

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

            }

            Loader {
                id: loginLoader

                width: centerArea.width - 20
                height: centerArea.height - tabBtn.height - 20
                source: "./CaptchaLogin.qml"
            }

        }

    }

}
