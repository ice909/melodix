import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    property int scrollWidth: rootWindow.width - 40
    property string currentCategory: "全部" // 默认选中全部分类
    property int hotPlaylistsRows: 0
    property int playlistCount: 0
    // 一次取出的歌曲数量
    property int songlimit: 0
    // 歌曲偏移量
    property int offset: 0
    // 是否正在“加载更多”
    property bool loadMore: false
    // 是否加载完全部歌单
    property bool hasMore: true

    function switchBeforeClear() {
        initing = true;
        hotPlaylists.lists.clear();
        hasMore = true;
        offset = 0;
        songlimit = 0;
        hotPlaylistsRows = 0;
        getPlaylistCount();
    }

    function getHotPlaylist() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            //console.log(JSON.stringify(JSON.parse(reply)))
            var playlists = JSON.parse(reply).playlists;
            for (const playlist of playlists) hotPlaylists.lists.append({
                "playlist": playlist
            })
            console.log("获取的歌单数量：" + playlists.length);
            hotPlaylistsRows += Math.ceil(playlists.length / 5);
            console.log("计算出的歌单行数：" + hotPlaylistsRows);
            offset += playlists.length;
            console.log("加载的歌曲数量: songlimit: " + songlimit + " offset: " + offset);
            initing = false;
            loadMore = false;
        }

        if (playlistCount - offset > 50) {
            songlimit = 50;
        } else {
            songlimit = playlistCount - offset;
            hasMore = false;
        }
        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/top/playlist?cat=" + currentCategory + "&limit=" + songlimit + "&offset=" + offset);
    }

    function getPlaylistCount(first = false) {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            playlistCount = JSON.parse(reply).total;
            getHotPlaylist();
        }

        if (!first)
            loadAnimation.anchors.topMargin = tabBtns.height + 40;

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/top/playlist?cat=" + currentCategory);
    }

    Component.onCompleted: {
        getPlaylistCount(true);
    }

    // 发现界面
    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: hotPlaylists.height + tabBtns.height + 20 + 20 * 3
        ScrollBar.vertical.onPositionChanged: () => {
            const position = ScrollBar.vertical.position + ScrollBar.vertical.size;
            if (position > 0.99 && !loadMore && hasMore) {
                console.log("position: " + position + " 滚动到底部，加载更多");
                loadMore = true;
                getHotPlaylist();
            }
        }

        Column {
            id: body

            spacing: 20
            x: 20

            Text {
                text: "发现"
                font.pixelSize: DTK.fontManager.t4.pixelSize
                height: 20
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

            HotPlaylists {
                id: hotPlaylists

                width: scrollWidth
                height: hotPlaylistsRows * 202 + (hotPlaylistsRows - 1) * 30
            }

        }

    }

    Rectangle {
        id: loadAnimation

        visible: initing
        anchors.fill: root

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
