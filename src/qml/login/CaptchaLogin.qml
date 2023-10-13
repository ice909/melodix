import "../../util"
import "../widgets"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    property int time: 59

    function verifyCaptcha() {
        // 验证验证码
        function onReply(reply) {
            API.onVerifyCaptchaCompleted.disconnect(onReply);
            if (reply.data === true)
                login();
            else {
                code.text = "";
                code.showAlert = true
            }
        }

        if (phone.text !== "" && code.text != "") {
            API.onVerifyCaptchaCompleted.connect(onReply);
            API.verifyCaptcha(phone.text, code.text);
        }
    }

    function login() {
        function onReply(reply) {
            API.onCellphoneLoginCompleted.disconnect(onReply);
            worker.saveCookie(reply.cookie);
            API.addCookie();
            API.getAccountInfo();
            isLogin = true;
            sendCaptchaTimer.stop();
            root.close();
        }

        if (phone.text !== "" && code.text != "") {
            API.onCellphoneLoginCompleted.connect(onReply);
            API.phoneLogin(phone.text, "", code.text);
        }
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
                    alertText: "验证码有误"
                }

                RecommandButton {
                    id: captchaBtn

                    width: 100
                    text: "获取验证码"
                    enabled: phone.text !== "" && phone.text.length === 11
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: {
                        console.log("获取验证码按钮被点击");
                        API.onSendCaptchaCompleted.connect(onReply);
                        API.getCaptcha(phone.text);
                    }

                    function onReply() {
                        API.onSendCaptchaCompleted.disconnect(onReply);
                        console.log("验证码发送成功");
                        captchaBtn.enabled = false;
                        captchaBtn.text = "59s后重发";
                        sendCaptchaTimer.start();
                    }

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
            onClicked: {
                verifyCaptcha();
            }
        }

        Item {
            Layout.fillHeight: true
        }

    }

    Timer {
        id: sendCaptchaTimer

        repeat: true
        onTriggered: {
            time--;
            if (time !== 0) {
                captchaBtn.text = time + "s后重发";
            } else {
                time = 59;
                captchaBtn.text = "获取验证码";
                captchaBtn.enabled = true;
                sendCaptchaTimer.stop();
            }
        }
    }

}
