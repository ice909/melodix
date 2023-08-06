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
        "component": "index/Index.qml"
    }
    // 发现
    property var routeDiscover: {
        "path": "discover",
        "component": "discover/Discover.qml"
    }
    // 音乐库
    property var routeLibrary: {
        "path": "library",
        "component": "library/Library.qml"
    }

    // 路由后退信号
    signal signalBack()
    // 路由导航信号
    signal signalNavigate(var route)
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
        signalNavigate(r);
        routeCurrent = r;
        routeHistory.push(r);
    }

    // 显示音乐库
    function showLibrary() {
        const r = clone(routeLibrary);
        signalNavigate(r);
        routeCurrent = r;
        routeHistory.push(r);
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
