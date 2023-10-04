import "../../router"
import QtQuick 2.11
import QtQuick.Layouts 1.11
import org.deepin.dtk 1.0

Rectangle {
    property int selectedIndex: 0

    width: 150
    height: parent.height
    color: "transparent"

    Column {
        anchors.fill: parent
        padding: 5

        ListView {
            width: parent.width - 10
            height: parent.height - 10
            model: Router.routeModel
            spacing: 5

            delegate: ItemDelegate {
                width: parent.width
                height: 36
                icon.name: iconName
                checked: index === selectedIndex
                text: _text
                font.pixelSize: 16
                font.bold: true
                backgroundVisible: false
                onClicked: {
                    switch (text) {
                    case "首页":
                        Router.showIndex();
                        selectedIndex = index;
                        break;
                    case "发现":
                        Router.showDiscover();
                        selectedIndex = index;
                        break;
                    case "音乐库":
                        Router.showLibrary();
                        selectedIndex = index;
                        break;
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
