import "../../router"
import "../widgets"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Layouts 1.7
import org.deepin.dtk 1.0

WindowButton {
    onClicked: {
        
        console.log("头像被点击")
        if (!isLogin) {
            Router.showLogin();
        } else {
            Router.showUser();
        }
    }

    RoundedImage {
        id: avatarImage

        imgSrc: isLogin ? userAvatar : "qrc:/dsg/img/avatar.svg"
        width: 35
        height: 35
        borderRadius: 35
        anchors.centerIn: parent
    }

    background: Rectangle {
        anchors.fill: parent
        color: "transparent"
    }

}
