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

    function getHotPlaylist(first = false) {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            //console.log(JSON.stringify(JSON.parse(reply)))
            var playlists = JSON.parse(reply).playlists;
            hotPlaylists.lists = playlists;
            console.log("获取的歌单数量：" + playlists.length);
            hotPlaylistsRows = Math.ceil(playlists.length / 5);
            console.log("计算出的歌单行数：" + hotPlaylistsRows);
            initing = false;
        }

        if (!first)
            loadAnimation.anchors.topMargin = tabBtns.height + 40;

        initing = true;
        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/top/playlist?cat=" + currentCategory);
    }

    Component.onCompleted: {
        getHotPlaylist(true);
    }

    // 发现界面
    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: hotPlaylists.height + tabBtns.height + 20 + 20 * 3

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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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
                            getHotPlaylist();
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

}
