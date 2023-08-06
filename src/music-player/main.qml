import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import org.deepin.dtk 1.0
import "router"
import "titlebar"

ApplicationWindow {
    id: rootWindow

    property int windowMiniWidth: 1070
    property int windowMiniHeight: 680

    visible: true
    minimumWidth: windowMiniWidth
    minimumHeight: windowMiniHeight
    width: windowMiniWidth
    height: windowMiniHeight
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    DWindow.enabled: true
    DWindow.alphaBufferSize: 8
    flags: Qt.Window | Qt.WindowMinMaxButtonsHint | Qt.WindowCloseButtonHint | Qt.WindowTitleHint

    Repeater {
        id: pages

        onItemAdded: {
            const index = pages.count - 1;
            const model = pages.model.get(index);
            const loader = pages.itemAt(index).children[0];
            loader.setSource(model.source);
        }

        Rectangle {
            anchors.fill: parent

            Loader {
                anchors.fill: parent
            }

        }

        model: ListModel {
            ListElement {
                source: "index/Index.qml"
            }

        }

    }

    Connections {
        // 路由导航，添加一个页面
        function onSignalNavigate(route) {
            pages.model.append({
                "source": route.component
            });
        }

        // 路由反馈，删除一个页面
        function onSignalBack() {
            pages.model.remove(pages.count - 1);
        }

        // 回到首页，清空多于页面，释放内存
        function onSignalGoHome(route) {
            console.log("go home");
            pages.model.clear();
            pages.model.append({
                "source": route.component
            });
        }

        target: Router
    }

    header: MyTitlebar {
    }

    background: Rectangle {
        id: _background

        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.01)

        BoxShadow {
            anchors.fill: _background
            shadowOffsetX: 0
            shadowOffsetY: 4
            shadowColor: Qt.rgba(0, 0, 0, 0.05)
            shadowBlur: 10
            cornerRadius: _background.radius
            spread: 0
            hollow: true
        }

    }

}
