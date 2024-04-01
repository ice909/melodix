import "../../router"
import "../widgets"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Layouts 1.7
import org.deepin.dtk 1.0

WindowButton {
    onClicked: {
        accountMenu.visible = !accountMenu.visible;
    }

    Row {
        anchors.fill: parent

        RoundedImage {
            id: avatarImage

            imgSrc: isLogin ? userAvatar : "qrc:/dsg/img/avatar.svg"
            width: 35
            height: 35
            borderRadius: 35
            anchors.verticalCenter: parent.verticalCenter
        }

        Item {
            width: 10
            height: 10
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: isLogin ? userNickname : "未登录"
        }

    }

    Popup {
        //TODO: 重新布局

        id: accountMenu

        x: root.x - 25
        y: root.height
        visible: false
        width: 150
        // 30 * 2 是按钮高度，10 * 2是spacing ，10是margin-bottom
        height: 30 * 3 + 10 * 2 + 20
        z: 1
        Component.onCompleted: console.log("accountMenu completed")

        ColumnLayout {
            anchors.centerIn: parent
            width: 130
            spacing: 10

            // 个人中心按钮
            Button {
                visible: isLogin
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                text: "个人中心"
                ColorSelector.family: Palette.CrystalColor
                onClicked: {
                    Worker.openUrl("https://music.163.com/#/user/home?id=" + userID);
                    accountMenu.close();
                }
            }

            // 我的消息按钮
            Button {
                visible: isLogin
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                text: "我的消息"
                ColorSelector.family: Palette.CrystalColor
                onClicked: {
                    Worker.openUrl("https://music.163.com/#/msg/m/private");
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
                    Router.showLogin();
                    accountMenu.close();
                }
            }

        }

        background: FloatingPanel {
            blurRadius: 20
        }

    }

    background: Rectangle {
        anchors.fill: parent
        color: "transparent"
    }

}
