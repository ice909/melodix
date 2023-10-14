import "../../router"
import "../widgets"
import Melodix.API 1.0
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
        // 30 * 2 是按钮高度，10 * 2是spacing ，10是margin-bottom
        height: avatar_item.height + 30 * 2 + 10 * 2 + 20

        ColumnLayout {
            anchors.centerIn: parent
            width: 130
            spacing: 10

            Item {
                id: avatar_item
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

            // 个人中心按钮
            Button {
                visible: isLogin
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                text: "个人中心"
                ColorSelector.family: Palette.CrystalColor
                onClicked: {
                    worker.openUrl("https://music.163.com/#/user/home?id=" + userID);
                    accountMenu.close();
                }
            }

            Button {
                visible: isLogin
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                text: "登出"
                ColorSelector.family: Palette.CrystalColor
                onClicked: {
                    API.logout();
                    userAvatar = "";
                    isLogin = false;
                    accountMenu.close();
                }
            }

            // 登陆按钮
            RecommandButton {
                visible: !isLogin
                Layout.fillWidth: true
                Layout.preferredHeight: 30
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
