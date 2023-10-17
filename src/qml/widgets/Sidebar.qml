import "../../router"
import "../../util"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    property int selectedIndex: 0

    width: 150
    height: parent.height

    Column {
        anchors.fill: parent
        padding: 5

        ListView {
            id: listView
            width: parent.width - 10
            height: parent.height - 10
            model: Router.routeModel
            spacing: 5

            delegate: ItemDelegate {
                width: parent.width
                height: 36
                checked: index === selectedIndex
                font.pixelSize: 16
                font.bold: true
                backgroundVisible: false

                MouseArea {
                    id: mouseArea

                    acceptedButtons: Qt.LeftButton
                    anchors.fill: parent
                    onPressed: {
                        switch (index) {
                        case 0:
                            Router.showIndex();
                            selectedIndex = index;
                            break;
                        case 1:
                            Router.showDiscover();
                            selectedIndex = index;
                            break;
                        case 2:
                            Router.showLibrary();
                            selectedIndex = index;
                            break;
                        }
                    }
                }
                RowLayout {
                    anchors.fill: parent
                    Image {
                        Layout.leftMargin: 10
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        source: iconName
                    }
                    Label {
                        text: _text
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }
            }

        }

    }

    Connections {
        function onSignalBack() {
            switch (Router.routeCurrent.path) {
            case "index":
                selectedIndex = 0;
                break;
            case "discover":
                selectedIndex = 1;
                break;
            case "library":
                selectedIndex = 2;
                break;
            }
        }

        target: Router
    }

}
