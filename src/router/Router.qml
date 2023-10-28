import "../util"
import QtQuick 2.0
import org.deepin.dtk 1.0 as D
pragma Singleton

Item {
    // 当前路由状态
    property var routeCurrent: routeIndex
    // 路由历史记录
    property var routeHistory: [routeIndex]
    property ListModel pageModel
    property ListModel userListViewModel
    // 首页
    property var routeIndex: {
        "path": "index",
        "component": "qml/index/Index.qml"
    }
    // 发现
    property var routeDiscover: {
        "path": "discover",
        "component": "qml/discover/Discover.qml",
        "showRecommend": false
    }
    // 音乐库
    property var routeLibrary: {
        "path": "library",
        "component": "qml/library/Library.qml"
    }
    // 歌单详情页
    property var routePlaylistDetail: {
        "path": "playlist",
        "component": "qml/playlistdetail/PlaylistDetail.qml",
        "id": 0
    }
    // 搜索结果页
    property var routeSearch: {
        "path": "search",
        "component": "qml/search/Search.qml",
        "key": ""
    }
    // Mv详情页
    property var routeMv: {
        "path": "mv",
        "component": "qml/mv/Mv.qml",
        "id": ""
    }
    // 艺人详情页
    property var routeArtist: {
        "path": "artist",
        "component": "qml/artist/Artist.qml",
        "id": ""
    }
    // 喜欢的歌曲页
    property var routeFavorite: {
        "path": "favourite",
        "component": "qml/favorite/Favorite.qml",
        "id": "",
        "count": ""
    }
    // 登录页
    property var routeLogin: {
        "path": "login",
        "component": "qml/login/Login.qml"
    }
    // 个人中心页
    property var routeUser: {
        "path": "user",
        "component": "qml/user/User.qml"
    }
    // 设置页
    property var routeSetting: {
        "path": "setting",
        "component": "qml/settings/Settings.qml"
    }

    // 路由后退信号
    signal signalBack()
    // 路由导航信号
    signal signalNavigate(var route, bool overlay)
    signal signalGoHome(var route)

    // 显示首页
    function showIndex() {
        routeCurrent = routeIndex;
        routeHistory = [routeCurrent];
        signalGoHome(routeIndex);
    }

    // 显示发现页
    function showDiscover(checkRecommend = false) {
        // 如果当前路由是发现页，不做任何操作
        if (routeCurrent.path === routeDiscover.path)
            return ;

        const r = clone(routeDiscover);
        r.showRecommend = checkRecommend;
        routeCurrent = r;
        signalNavigate(r, false);
        routeHistory.push(r);
    }

    // 显示音乐库
    function showLibrary() {
        // 如果当前路由是音乐库，不做任何操作
        if (routeCurrent.path === routeLibrary.path)
            return ;

        const r = clone(routeLibrary);
        signalNavigate(r, false);
        routeCurrent = r;
        routeHistory.push(r);
    }

    // 显示歌单详情页
    function showPlaylistDetail(id = "") {
        const r = clone(routePlaylistDetail);
        r.id = id;
        routeCurrent = r;
        routeHistory.push(r);
        signalNavigate(r, false);
    }

    // 显示搜索结果页
    // overlay 为true时会覆盖上一个路由
    function showSearch(key, overlay = false) {
        const r = clone(routeSearch);
        r.key = key;
        routeCurrent = r;
        signalNavigate(r, overlay);
        if (overlay) {
            routeHistory[routeHistory.length - 1] = r;
            return ;
        }
        routeHistory.push(r);
    }

    // 显示Mv详情页
    function showMv(id) {
        const r = clone(routeMv);
        r.id = id;
        routeCurrent = r;
        routeHistory.push(r);
        signalNavigate(r, false);
    }

    // 显示艺人详情页
    function showArtist(id) {
        const r = clone(routeArtist);
        r.id = id;
        routeCurrent = r;
        routeHistory.push(r);
        signalNavigate(r, false);
    }

    // 显示喜欢的歌曲页
    function showFavorite(id, count) {
        const r = clone(routeFavorite);
        r.id = id;
        r.count = count;
        routeCurrent = r;
        routeHistory.push(r);
        signalNavigate(r, false);
    }

    // 显示登录页
    function showLogin() {
        const r = clone(routeLogin);
        routeCurrent = r;
        routeHistory.push(r);
        signalNavigate(r, false);
    }

    // 显示个人中心页
    function showUser() {
        const r = clone(routeUser);
        routeCurrent = r;
        routeHistory.push(r);
        signalNavigate(r, false);
    }

    // 显示设置页
    function showSettings() {
        const r = clone(routeSetting);
        routeCurrent = r;
        routeHistory.push(r);
        signalNavigate(r, false);
    }

    // 复制对象
    function clone(route) {
        return JSON.parse(JSON.stringify(route));
    }

    // 返回上一页
    function back() {
        routeHistory.pop();
        const r = routeHistory[routeHistory.length - 1];
        console.log("route back", JSON.stringify(r));
        routeCurrent = r;
        signalBack();
    }

    function onThemeTypeChanged() {
        if (D.DTK.themeType == 2) {
            pageModel.setProperty(0, "iconName", "qrc:/dsg/icons/index-dark.svg");
            pageModel.setProperty(1, "iconName", "qrc:/dsg/icons/discover-dark.svg");
            pageModel.setProperty(2, "iconName", "qrc:/dsg/icons/library-dark.svg");
            userListViewModel.setProperty(0, "iconName", "qrc:/dsg/icons/favourite-dark.svg");
        } else {
            pageModel.setProperty(0, "iconName", "qrc:/dsg/icons/index-light.svg");
            pageModel.setProperty(1, "iconName", "qrc:/dsg/icons/discover-light.svg");
            pageModel.setProperty(2, "iconName", "qrc:/dsg/icons/library-light.svg");
            userListViewModel.setProperty(0, "iconName", "qrc:/dsg/icons/favourite-light.svg");
        }
    }

    Component.onCompleted: {
        if (D.DTK.themeType === 2) {
            pageModel.setProperty(0, "iconName", "qrc:/dsg/icons/index-dark.svg");
            pageModel.setProperty(1, "iconName", "qrc:/dsg/icons/discover-dark.svg");
            pageModel.setProperty(2, "iconName", "qrc:/dsg/icons/library-dark.svg");
            userListViewModel.setProperty(0, "iconName", "qrc:/dsg/icons/favourite-dark.svg");
        }
        D.DTK.themeTypeChanged.connect(onThemeTypeChanged);
    }
    Component.onDestruction: {
        D.DTK.themeTypeChanged.disconnect(onThemeTypeChanged);
    }

    pageModel: ListModel {
        ListElement {
            iconName: "qrc:/dsg/icons/index-light.svg"
            _text: "首页"
        }

        ListElement {
            iconName: "qrc:/dsg/icons/discover-light.svg"
            _text: "发现"
        }

        ListElement {
            iconName: "qrc:/dsg/icons/library-light.svg"
            _text: "音乐库"
        }

    }

    userListViewModel: ListModel {
        ListElement {
            iconName: "qrc:/dsg/icons/favourite-light.svg"
            _text: "我喜欢的音乐"
        }

    }

}
