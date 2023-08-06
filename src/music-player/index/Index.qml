import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    // 首页界面
    ScrollView {
        anchors.fill: parent
        clip: true

        Column {
            id: body

            spacing: 30
            x: 20
            width: rootWindow.width - 40
            height: rootWindow.height

            Button {
                text: "首页"
            }

        }

    }

}
