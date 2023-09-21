import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    function passwordLogin() {
        function onReply(reply) {
            api.onCellphoneLoginCompleted.disconnect(onReply);
            worker.saveCookie(reply.cookie);
            api.addCookie();
            api.getAccountInfo();
            isLogin = true;
            root.close();
        }

        api.onCellphoneLoginCompleted.connect(onReply);
        api.phoneLogin(phone.text, password.text);
    }

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
                    text: "密码:"
                    font.bold: true
                    width: 50
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                }

                PasswordEdit {
                    id: password

                    width: parent.width - 60
                    placeholderText: "请输入密码"
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
            enabled: phone.text !== "" && password.text !== ""
            Layout.fillWidth: true
            onClicked: {
                passwordLogin();
            }
        }

        Item {
            Layout.fillHeight: true
        }

    }

}
