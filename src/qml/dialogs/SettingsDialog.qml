import QtQuick 2.11
import QtQuick.Layouts 1.7
import org.deepin.dtk 1.0

Item {
    id: root

    signal closed()

    DialogWindow {
        id: win

        icon: "melodix"
        title: "设置"
        height: 400
        width: 400
        onClosing: {
            root.closed();
        }
        Component.onCompleted: {
            var action = Worker.getCloseAction();
            var isAsk = Worker.getIsAsk();
            if (isAsk == "1")
                asktRB.checked = true;
            else if (action == "1")
                minRB.checked = true;
            else if (action == "2")
                exitRB.checked = true;
            show();
        }

        ScrollView {
            anchors.fill: parent
            clip: true

            Column {
                id: body

                spacing: 20
                y: 5

                Item {
                    width: win.width
                    height: 30

                    Text {
                        text: "关闭主窗口"
                        font.pixelSize: DTK.fontManager.t4.pixelSize
                        anchors.verticalCenter: parent.verticalCenter
                    }

                }

                Item {
                    width: win.width
                    height: 30

                    RadioButton {
                        id: minRB

                        anchors.verticalCenter: parent.verticalCenter
                        width: 150 // 控件宽度没自适应
                        text: "最小化到系统托盘"
                        font.pixelSize: DTK.fontManager.t7.pixelSize
                        onClicked: {
                            Worker.setCloseAction("1");
                            Worker.setIsAsk("2");
                        }
                    }

                    RadioButton {
                        id: exitRB

                        anchors.verticalCenter: parent.verticalCenter
                        width: 100 // 控件宽度没自适应
                        anchors.left: minRB.right
                        text: "退出"
                        font.pixelSize: DTK.fontManager.t7.pixelSize
                        onClicked: {
                            Worker.setCloseAction("2");
                            Worker.setIsAsk("2");
                        }
                    }

                    RadioButton {
                        id: asktRB

                        anchors.verticalCenter: parent.verticalCenter
                        width: 100 // 控件宽度没自适应
                        anchors.left: exitRB.right
                        text: "总是询问"
                        font.pixelSize: DTK.fontManager.t7.pixelSize
                        onClicked: {
                            Worker.setIsAsk("1");
                        }
                    }

                }

            }

        }

    }

}
