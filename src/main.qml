import Qt.labs.platform 1.1 as P
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import network 1.0
import org.deepin.dtk 1.0
import player 1.0
import "qml/playlist"
import "qml/titlebar"
import "qml/toolbar"
import "router"
import "util"

ApplicationWindow {
    // 获取账户信息

    id: rootWindow

    property bool isLogin: false
    property string userAvatar: ""
    property string userNickname: ""
    property string userID: ""
    // 我喜欢的所有歌曲的id
    property var userFavoriteSongsID: []
    property bool isPlaylistShow: false
    property bool isLyricShow: false
    property int windowMiniWidth: 1070
    property int windowMiniHeight: 680

    function getMusicUrl(id, name, pic, artist, duration, isVip) {
        function onReply(reply) {
            network.onSongUrlRequestFinished.disconnect(onReply);
            player.addSignleToPlaylist(JSON.parse(reply).data[0].url, id, name, pic, artist, duration, isVip);
        }

        network.onSongUrlRequestFinished.connect(onReply);
        network.getSongUrl(id);
    }

    function getUserFavoriteSongID() {
        function onReply(reply) {
            network.onAccountReplyFinished.disconnect(onReply);
            userFavoriteSongsID = JSON.parse(reply).ids;
        }

        network.onAccountReplyFinished.connect(onReply);
        network.accountInfo("/likelist?uid=" + userID);
    }

    function getAccountInfo() {
        function onReply(reply) {
            network.onAccountReplyFinished.disconnect(onReply);
            userAvatar = JSON.parse(reply).profile.avatarUrl;
            userNickname = JSON.parse(reply).profile.nickname;
            userID = JSON.parse(reply).profile.userId;
            console.log("用户头像 昵称 ID获取成功");
            getUserFavoriteSongID();
        }

        network.onAccountReplyFinished.connect(onReply);
        network.accountInfo("/user/account?timestamp=" + Util.getTimestamp());
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
                console.log("还未登录");
                return ;
            }
        }

        network.onAccountReplyFinished.connect(onReply);
        network.accountInfo("/login/status?timestamp=" + Util.getTimestamp());
    }

    function onMediaCountChanged(count) {
        if (count == 0) {
            trayPreAction.enabled = false;
            trayNextAction.enabled = false;
            trayPlayBtn.enabled = false;
        } else {
            trayPreAction.enabled = true;
            trayNextAction.enabled = true;
            trayPlayBtn.enabled = true;
        }
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
            playlistLoader.setSource("qml/playlist/Playlist.qml");
            playlistLoader.item.width = 320;
            playlistLoader.item.height = rootWindow.height - 90 - 50;
            playlistLoader.item.y = height - playlistLoader.item.height - 80 - 50;
            playlistLoader.item.playlistHided.connect(function() {
                toolbox.updatePlaylistBtnStatus(false);
                isPlaylistShow = false;
            });
        }
    }
    onClosing: {
        if (closeDlgLoader.status === Loader.Null)
            closeDlgLoader.setSource("qml/dialogs/CloseDialog.qml");

        if (closeDlgLoader.item.isMinimize) {
            closeDlgLoader.item.isMinimize = false;
            return ;
        }
        var isAsk = worker.getIsAsk();
        if (isAsk == "2") {
            if (worker.getCloseAction() == "2")
                Qt.quit();

        } else {
            close.accepted = false;
            closeDlgLoader.item.show();
        }
    }
    Component.onCompleted: {
        refreshAccount();
    }

    Loader {
        id: closeDlgLoader
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
            visible: !isLyricShow
            color: Util.pageBackgroundColor

            Loader {
                width: parent.width
                height: parent.height - 70
            }

        }

        model: ListModel {
            ListElement {
                source: "qml/index/Index.qml"
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
        function onSignalNavigate(route, overlay) {
            if (overlay)
                pages.model.remove(pages.count - 1);

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

        width: 320
        height: parent.height - 90
        z: 5
    }

    Loader {
        id: lrcWindowLoader
    }

    Loader {
        id: loginDialog
    }

    Connections {
        id: toolboxConnect

        function onPlaylistBtnClicked() {
            if (playlistLoader.status === Loader.Ready) {
                playlistLoader.item.playlistRaise();
                isPlaylistShow = true;
            }
        }

        function onLyricToggleClicked() {
            if (lrcWindowLoader.status === Loader.Null) {
                lrcWindowLoader.setSource("qml/lyric/Lyric.qml");
                lrcWindowLoader.item.y = -50;
            }
            if (lrcWindowLoader.status === Loader.Ready)
                lrcWindowLoader.item.lyricWindowUp();

        }

        target: toolbox
    }

    Connections {
        function onLrcHideBtnClicked() {
            if (lrcWindowLoader.status === Loader.Null) {
                lrcWindowLoader.setSource("LyricWindow.qml");
                lrcWindowLoader.item.y = -50;
            }
            if (lrcWindowLoader.status === Loader.Ready)
                lrcWindowLoader.item.lyricWindowUp();

        }

        target: titleBar
    }

    Connections {
        function onMinimizeToSystemTray() {
            close();
        }

        target: closeDlgLoader.item
    }

    P.SystemTrayIcon {
        id: systemTray

        function onPlayStateChanged() {
            if (player.getPlayState())
                trayPlayBtn.text = '暂停';
            else
                trayPlayBtn.text = '播放';
        }

        visible: true
        iconName: "melodix"
        tooltip: "Melodix"
        onActivated: {
            if (rootWindow.visibility === 2) {
                rootWindow.showMinimized();
            } else if (rootWindow.visibility === 3 || rootWindow.visibility === 0) {
                rootWindow.show();
                rootWindow.raise();
                rootWindow.requestActivate();
            }
        }
        Component.onCompleted: {
            player.mediaCountChanged.connect(onMediaCountChanged);
            player.playStateChanged.connect(onPlayStateChanged);
        }

        menu: P.Menu {
            P.MenuItem {
                id: trayPlayBtn

                text: "播放"
                enabled: false
                onTriggered: {
                    if (player.getPlayState()) {
                        player.pause();
                        text = '播放';
                    } else {
                        player.play();
                        text = '暂停';
                    }
                }
            }

            P.MenuItem {
                id: trayPreAction

                text: "上一首"
                enabled: false
                onTriggered: player.previous()
            }

            P.MenuItem {
                id: trayNextAction

                text: "下一首"
                enabled: false
                onTriggered: player.next()
            }

            P.MenuItem {
                text: "退出"
                onTriggered: Qt.quit()
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
