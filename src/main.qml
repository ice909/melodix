import Melodix.API 1.0
import Melodix.Player 1.0
import Qt.labs.platform 1.1 as P
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import org.deepin.dtk 1.0
import "qml/playlist"
import "qml/titlebar"
import "qml/toolbar"
import "qml/widgets"
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
    property string userFavoritePlaylistId: ""
    property bool isPlaylistShow: false
    property bool isLyricShow: false
    property int windowMiniWidth: 1070
    property int windowMiniHeight: 680
    property int scrollWidth: rootWindow.width - Util.pageLeftPadding * 2 - sidebar.width

    function getMusicUrl(id, name, pic, artist, duration, album, isVip) {
        function urlCompleted(res) {
            API.onSongUrlCompleted.disconnect(urlCompleted);
            Player.addSingleToPlaylist(res[0].url, id, name, pic, artist, duration, album, isVip);
        }

        API.onSongUrlCompleted.connect(urlCompleted);
        API.getSongUrl(id);
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
        var isAsk = Worker.getIsAsk();
        if (isAsk == "2") {
            if (Worker.getCloseAction() == "2")
                Qt.quit();

        } else {
            close.accepted = false;
            closeDlgLoader.item.show();
        }
    }
    Component.onCompleted: {
        API.getLoginStatus();
    }

    Connections {
        function onLoginStatusCompleted(res) {
            if (res.code == 200 && res.account.status == 0 && res.profile != null) {
                console.log("用户已登录");
                isLogin = true;
                API.getAccountInfo();
            } else {
                console.log("还未登录");
                return ;
            }
        }

        function onAccountInfoCompleted(profile) {
            userAvatar = profile.avatarUrl;
            userNickname = profile.nickname;
            userID = profile.userId;
            console.log("用户头像 昵称 ID获取成功");
            API.getUserLikeSongIds(userID);
        }

        function onUserLikeSongIdsCompleted(res) {
            function userFavoritePlaylistIdCompleted(res) {
                API.onUserPlaylistCompleted.disconnect(userFavoritePlaylistIdCompleted);
                userFavoritePlaylistId = res[0].id;
            }

            userFavoriteSongsID = res.ids;
            API.onUserPlaylistCompleted.connect(userFavoritePlaylistIdCompleted);
            API.getUserPlaylist(userID);
        }

        target: API
    }

    Loader {
        id: closeDlgLoader
    }

    Sidebar {
        id: sidebar

        visible: !isLyricShow

        anchors {
            left: parent.left
            top: parent.top
        }

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
            width: parent.width - sidebar.width
            height: parent.height - 70
            visible: !isLyricShow
            color: Util.pageBackgroundColor

            anchors {
                left: sidebar.right
                top: parent.top
            }

            Loader {
                anchors.fill: parent
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
            for (var i = pages.count - 1; i > 0; i--) {
                pages.model.remove(i);
            }
            console.log("回到首页,剩余页面数量: " + pages.count);
        }

        target: Router
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
            if (Player.getPlayState())
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
            Player.mediaCountChanged.connect(onMediaCountChanged);
            Player.playStateChanged.connect(onPlayStateChanged);
        }

        menu: P.Menu {
            P.MenuItem {
                id: trayPlayBtn

                text: "播放"
                enabled: false
                onTriggered: {
                    if (Player.getPlayState()) {
                        Player.pause();
                        text = '播放';
                    } else {
                        Player.play();
                        text = '暂停';
                    }
                }
            }

            P.MenuItem {
                id: trayPreAction

                text: "上一首"
                enabled: false
                onTriggered: Player.previous()
            }

            P.MenuItem {
                id: trayNextAction

                text: "下一首"
                enabled: false
                onTriggered: Player.next()
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
        color: "transparent"

        Row {
            anchors.fill: _background

            Rectangle {
                id: leftBgArea

                width: sidebar.width
                height: parent.height
                anchors.top: parent.top
                color: Util.sidebarBackgroundColor

                BoxShadow {
                    anchors.fill: leftBgArea
                    shadowOffsetX: 0
                    shadowOffsetY: 4
                    shadowColor: Qt.rgba(0, 0, 0, 0.05)
                    shadowBlur: 10
                    cornerRadius: leftBgArea.radius
                    spread: 0
                    hollow: true
                }

                Rectangle {
                    width: 1
                    height: parent.height
                    visible: !isLyricShow
                    anchors.right: parent.right
                    color: Util.sidebarRightBorderColor
                }

            }

            Rectangle {
                id: rightBgArea

                width: parent.width - leftBgArea.width
                height: 50
                anchors.top: parent.top
                color: Qt.rgba(0, 0, 0, 0.01)

                BoxShadow {
                    anchors.fill: rightBgArea
                    shadowOffsetX: 0
                    shadowOffsetY: 4
                    shadowColor: Qt.rgba(0, 0, 0, 0.05)
                    shadowBlur: 10
                    cornerRadius: rightBgArea.radius
                    spread: 0
                    hollow: true
                }

            }

        }

    }

}
