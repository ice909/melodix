import "../../router"
import "../widgets"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Layouts 1.7
import org.deepin.dtk 1.0

WindowButton {

    Label {
        
        anchors.fill: parent
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        text: isLogin ? userNickname : "未登录"
    }    

    onClicked: {
        console.log("nickname clicked");
        accountMenu.visible = !accountMenu.visible;
    }

    Popup {
        id: accountMenu
        //TODO: 重新布局

        x: root.x - 62
        y: root.height
        visible: false
        width: 150
        // 30 * 2 是按钮高度，10 * 2是spacing ，10是margin-bottom
        height: 30 * 3 + 10 * 2 + 20
        z: 1

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
                    loginDialog.setSource("");
                    loginDialog.setSource("../login/LoginDialog.qml");
                    accountMenu.close();
                }
            }

        }

        background: FloatingPanel {
            blurRadius: 20
        }

        
        Component.onCompleted: console.log("accountMenu completed");
        

    }
    background: Rectangle {
        anchors.fill: parent
        color: "transparent"
    }
    
}