import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import network 1.0
import org.deepin.dtk 1.0
import player 1.0
import "playlist"
import "router"
import "titlebar"
import "toolbar"

ApplicationWindow {
    // 获取账户信息

    id: rootWindow

    property bool isLogin: false
    property bool isPlaylistShow: false
    property int windowMiniWidth: 1070
    property int windowMiniHeight: 680

    function formatDuration(duration) {
        var minutes = Math.floor(duration / 60000);
        var seconds = Math.floor((duration % 60000) / 1000);
        return minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
    }

    function getTimestamp() {
        return Math.floor(Date.now() / 1000);
    }

    function getAccountInfo() {
        function onReply(reply) {
            network.onAccountReplyFinished.disconnect(onReply);
            titleBar.avatarImg = JSON.parse(reply).profile.avatarUrl;
            console.log("用户头像获取成功");
        }

        network.onAccountReplyFinished.connect(onReply);
        network.accountInfo("/user/account?timestamp=" + getTimestamp());
    }

    function refreshAccount() {
        function onReply(reply) {
            network.onAccountReplyFinished.disconnect(onReply);
            var userData = JSON.parse(reply).data;
            if (userData.code == 200 && userData.account.status == 0 && userData.profile != null) {
                console.log("用户已登录");
                isLogin = true;
                getAccountInfo();
            } else {
                console("还未登录");
                return ;
            }
        }

        network.onAccountReplyFinished.connect(onReply);
        network.accountInfo("/login/status?timestamp=" + getTimestamp());
    }

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
    onActiveChanged: {
        //窗口显示完成后加载播放列表
        if (active && playlistLoader.status === Loader.Null) {
            playlistLoader.setSource("playlist/Playlist.qml");
            playlistLoader.item.width = 320;
            playlistLoader.item.height = rootWindow.height - 90 - 50;
            playlistLoader.item.y = height - playlistLoader.item.height - 80 - 50;
            playlistLoader.item.playlistHided.connect(function() {
                toolbox.updatePlaylistBtnStatus(false);
                isPlaylistShow = false;
            });
        }
    }
    Component.onCompleted: {
        refreshAccount();
    }

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
                width: parent.width
                height: parent.height - 70
            }

        }

        model: ListModel {
            ListElement {
                source: "index/Index.qml"
            }

        }

    }

    Toolbar {
        id: toolbox
    }

    Player {
        id: player
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
            for (var i = pages.count - 1; i > 0; i--) {
                pages.model.remove(i);
            }
            console.log(pages.count);
        }

        target: Router
    }

    Network {
        id: network
    }

    Loader {
        id: playlistLoader
    }

    Loader {
        id: loginDialog
    }

    Connections {
        target: titleBar
        onLoginBtnClicked: {
            loginDialog.setSource("");
            loginDialog.setSource("login/LoginDialog.qml");
        }
    }

    Connections {
        id: toolboxConnect

        target: toolbox
        onPlaylistBtnClicked: {
            if (playlistLoader.status === Loader.Ready) {
                playlistLoader.item.playlistRaise();
                isPlaylistShow = true;
            }
        }
    }

    header: MyTitlebar {
        id: titleBar
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
