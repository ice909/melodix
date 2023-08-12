import QtQuick 2.0
pragma Singleton

Item {
    // 当前路由状态
    property var routeCurrent: routeIndex
    // 路由历史记录
    property var routeHistory: [routeIndex]
    // 首页
    property var routeIndex: {
        "path": "index",
        "component": "qml/index/Index.qml"
    }
    // 发现
    property var routeDiscover: {
        "path": "discover",
        "component": "qml/discover/Discover.qml"
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
        "id": ""
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
    function showDiscover() {
        const r = clone(routeDiscover);
        signalNavigate(r, false);
        routeCurrent = r;
        routeHistory.push(r);
    }

    // 显示音乐库
    function showLibrary() {
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
        signalNavigate(r,false);
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

}
