import "../../util"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    // 播放量组件
    property int duration: 0

    width: duraionIcon.width + durationLabel.width + 5
    height: 30

    Row {
        anchors.fill: parent
        spacing: 5

        RoundedImage {
            id: duraionIcon

            width: 20
            height: 20
            imgSrc: "qrc:/dsg/img/bar-chart.svg"
            anchors.verticalCenter: parent.verticalCenter
            isLocal: true
        }

        Label {
            id: durationLabel

            text: Util.formatVideoDuration(duration)
            color: "#fff"
            anchors.verticalCenter: parent.verticalCenter
        }

    }

}
