import "../../router"
import "../widgets"
import QtQuick 2.11
import QtQuick.Layouts 1.7
import org.deepin.dtk 1.0

WindowButton {
    onClicked: {
        accountMenu.open();
    }

    RoundedImage {
        id: avatarImage

        imgSrc: isLogin ? userAvatar : "qrc:/dsg/img/avatar.svg"
        width: 30
        height: 30
        borderRadius: 30
        anchors.centerIn: parent
    }

    Popup {
        id: accountMenu

        x: avatarImage.x - 62
        y: parent.height
        width: 150
        height: 120

        ColumnLayout {
            anchors.centerIn: parent
            width: 130
            spacing: 0

            Item {
                width: 48
                height: 48

                RoundedImage {
                    id: avatar_image

                    imgSrc: isLogin ? userAvatar : "qrc:/dsg/img/avatar.svg"
                    width: 48
                    height: 48
                    borderRadius: 48
                }

                Text {
                    anchors.left: avatar_image.right
                    anchors.verticalCenter: avatar_image.verticalCenter
                    anchors.leftMargin: 20
                    color: isLogin ? "black" : "gray"
                    text: isLogin ? userNickname : ""
                }

            }

            Button {
                visible: isLogin
                Layout.fillWidth: true
                height: 40
                Layout.topMargin: 10
                Layout.bottomMargin: 10
                text: "登出"
                onClicked: {
                    network.logout();
                    userAvatar = "";
                    isLogin = false;
                    accountMenu.close();
                }
            }

            // 登陆按钮
            RecommandButton {
                visible: !isLogin
                Layout.fillWidth: true
                height: 40
                Layout.topMargin: 10
                Layout.bottomMargin: 10
                text: "登录"
                onClicked: {
                    loginDialog.setSource("");
                    loginDialog.setSource("../login/LoginDialog.qml");
                    accountMenu.close();
                }
            }

        }

        background: FloatingPanel {
            blurRadius: 20
        }

    }

}
