import "../widgets"
import "../../util"
import QtQuick 2.11
import QtQuick.Layouts 1.7
import org.deepin.dtk 1.0

WindowButton {
    id: noticeButton

    RoundedImage {
        id: avatarImage

        imgSrc: Util.noticeIcon
        width: 25
        height: 25
        borderRadius: 0
        anchors.centerIn: parent
    }

    onClicked: {
        // 处理通知按钮点击事件
    }
    
}
