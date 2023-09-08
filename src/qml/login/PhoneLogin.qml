import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    anchors.fill: parent

    ColumnLayout {
        anchors.fill: parent

        Item {
            height: 50
            width: 50
        }

        Item {
            width: parent.width
            height: 50

            Row {
                anchors.fill: parent
                spacing: 5

                Label {
                    text: "手机号:"
                    font.bold: true
                    width: 50
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                }

                LineEdit {
                    id: phone

                    width: parent.width - 60
                    placeholderText: "请输入手机号"
                    anchors.verticalCenter: parent.verticalCenter
                }

            }

        }

        Item {
            width: parent.width
            height: 50

            Row {
                anchors.fill: parent
                spacing: 5

                Label {
                    text: "验证码:"
                    font.bold: true
                    width: 50
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                }

                LineEdit {
                    id: code

                    anchors.leftMargin: 15
                    width: 115
                    placeholderText: "请输入验证码"
                    anchors.verticalCenter: parent.verticalCenter
                }

                RecommandButton {
                    width: 100
                    text: "获取验证码"
                    anchors.verticalCenter: parent.verticalCenter
                }

            }

        }

        Item {
            height: 10
        }

        RecommandButton {
            id: loginBtn

            text: "登录"
            enabled: phone.text !== "" && code.text !== ""
            Layout.fillWidth: true
        }

        Text {
            text: "网易风控，暂时无法登录"
            font.pixelSize: 18
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "请使用二维码登录"
            font.pixelSize: 18
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            Layout.fillHeight: true
        }

    }

}
