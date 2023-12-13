import "../../router"
import "../../util"
import "../widgets"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    property string currentCategory: "全部" // 默认选中全部分类
    // 当前显示歌单的行数
    property int playlistRows: 0
    // 当前显示歌单的总数
    property int playlistCount: 0
    // 一次取出的歌曲数量
    property int limit: 50
    // 歌曲偏移量
    property int offset: 0
    // 是否正在“加载更多”
    property bool loadMore: false
    // 是否加载完全部歌单
    property bool hasMore: true

    // 切换分类之前重置属性
    function switchBeforeClear() {
        initing = true;
        hotPlaylists.lists.clear();
        hasMore = true;
        offset = 0;
        limit = 50;
        playlistCount = 0;
        playlistRows = 0;
        if (currentCategory === "推荐歌单")
            getRecommendResource();
        else
            API.getTopPlaylist(currentCategory, 'hot', limit, offset);
    }

    function moreLoading() {
        if (playlistCount - offset > 50) {
            limit = 50;
        } else {
            limit = playlistCount - offset;
            hasMore = false;
        }
        API.getTopPlaylist(currentCategory, 'hot', limit, offset);
    }

    function getRecommendResource() {
        function onReply(res) {
            API.onRecommendedPlaylistCompleted.disconnect(onReply);
            for (const playlist of res) hotPlaylists.lists.append({
                "playlist": playlist
            })
            playlistRows += Math.ceil(res.length / 5);
            initing = false;
            loadMore = false;
            hasMore = false;
        }

        API.onRecommendedPlaylistCompleted.connect(onReply);
        API.getRecommendResource();
    }

    Component.onCompleted: {
        if (Router.routeCurrent.showRecommend) {
            currentCategory = "推荐歌单";
            getRecommendResource();
        } else {
            API.getTopPlaylist(currentCategory, 'hot', limit, offset);
        }
    }

    Connections {
        function onTopPlaylistCompleted(res) {
            playlistCount = res.total;
            for (const playlist of res.playlists) hotPlaylists.lists.append({
                "playlist": playlist
            })
            playlistRows += Math.ceil(res.playlists.length / 5);
            console.log("歌单总行数：" + playlistRows);
            offset += res.playlists.length;
            console.log("加载的歌曲数量: limit: " + limit + " offset: " + offset);
            initing = false;
            loadMore = false;
            loadAnimation.anchors.topMargin = tabBtns.height + 40;
        }

        target: API
    }

    // 发现界面
    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: hotPlaylists.height + tabBtns.height + 20 + 20 * 3 + 5
        ScrollBar.vertical.onPositionChanged: () => {
            const position = ScrollBar.vertical.position + ScrollBar.vertical.size;
            if (position > 0.99 && !loadMore && hasMore) {
                console.log("position: " + position + " 滚动到底部，加载更多");
                loadMore = true;
                moreLoading();
            }
        }

        Column {
            id: body

            spacing: 20
            x: Util.pageLeftPadding
            y: 5

            Text {
                text: "发现"
                font.pixelSize: DTK.fontManager.t4.pixelSize
                height: 20
                color: Util.textColor
            }

            ButtonBox {
                id: tabBtns

                ToolButton {
                    checkable: true
                    text: "全部"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "推荐歌单"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "官方"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "欧美"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "华语"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "流行"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "说唱"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "民谣"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "电子"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "轻音乐"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "影视原声"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "ACG"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "怀旧"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "治愈"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                ToolButton {
                    checkable: true
                    text: "旅行"
                    font.pixelSize: 15
                    checked: currentCategory == text
                    onClicked: {
                        if (currentCategory != text) {
                            currentCategory = text;
                            switchBeforeClear();
                        }
                    }
                }

                background: Rectangle {
                    color: "transparent"
                }

            }

            GridPlaylists {
                id: hotPlaylists

                width: scrollWidth
                height: playlistRows * ((scrollWidth - 30 * 4) * 0.2 + 20) + (playlistRows - 1) * 30
            }

        }

    }

    Rectangle {
        id: loadAnimation

        visible: initing
        anchors.fill: root
        color: Util.pageBackgroundColor

        Loading {
            anchors.centerIn: parent
        }

    }

    BusyIndicator {
        id: indicator

        visible: loadMore
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        running: true
        width: 20
        height: 20
    }

}
