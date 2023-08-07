import "../router"
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

        imgSrc: avatarImg
        width: 26
        height: 26
        anchors.centerIn: parent
    }

    Popup {
        id: accountMenu

        x: avatarImage.x - 100
        y: parent.height
        width: 226
        height: 80

        ColumnLayout {
            anchors.centerIn: parent
            width: 200
            spacing: 0

            Button {
                visible: isLogin
                Layout.fillWidth: true
                height: 40
                Layout.topMargin: 20
                Layout.bottomMargin: 20
                text: "登出"
                onClicked: {
                    accountMenu.close();
                }
            }
            // 登陆按钮

            RecommandButton {
                visible: !isLogin
                Layout.fillWidth: true
                height: 40
                Layout.topMargin: 20
                Layout.bottomMargin: 20
                text: "登录"
                onClicked: {
                    loginBtnClicked();
                    accountMenu.close();
                }
            }

        }

        background: FloatingPanel {
            blurRadius: 20
        }

    }

}
