import QtQuick 2.11
import QtQuick.Layouts 1.7
import org.deepin.dtk 1.0

DialogWindow {
    id: closeDialogWin

    property string closeAction: "1"
    property bool isAsk
    property bool isMinimize: false

    signal minimizeToSystemTray()

    width: 400
    height: 230
    icon: "melodix"
    modality: Qt.ApplicationModal

    Column {
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        spacing: 5

        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            font: DTK.fontManager.t5
            text: "请选择您的操作"
        }

        ButtonGroup {
            buttons: column.children
        }

        Column {
            id: column

            width: parent.width
            spacing: 5

            RadioButton {
                id: minimizeBtn

                width: parent.width
                height: 30
                padding: 5
                text: "最小化到系统托盘"
                font: DTK.fontManager.t6
                checked: true
                onClicked: {
                    closeAction = 1;
                }
            }

            RadioButton {
                id: closeBtn

                width: parent.width
                height: 30
                padding: 5
                text: "退出"
                font: DTK.fontManager.t6
                onClicked: {
                    closeAction = 2;
                }
            }

        }

        CheckBox {
            width: parent.width
            height: 30
            padding: 5
            text: "不再询问"
            font: DTK.fontManager.t6
            onClicked: {
                if (checked)
                    isAsk = true;
                else
                    isAsk = false;
            }
        }

        Row {
            width: parent.width
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                width: 180
                height: 30
                text: "取消"
                onClicked: {
                    closeDialogWin.close();
                }
            }

            Button {
                width: 180
                height: 30
                text: "确定"
                onClicked: {
                    Worker.setCloseAction(closeAction);
                    if (isAsk)
                        Worker.setIsAsk("2");
                    else
                        Worker.setIsAsk("1");
                    if (closeAction == "1") {
                        isMinimize = true;
                        close();
                        minimizeToSystemTray();
                    }
                    if (closeAction == "2")
                        Qt.quit();

                }
            }

        }

    }

}
