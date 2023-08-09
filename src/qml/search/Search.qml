import "../../router"
import "../widgets"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    property int scrollWidth: rootWindow.width - 40
    // 获取到的歌曲数量
    property int searchResultCount: 0
    // 歌曲总量
    property int songListCount: 0
    // 歌曲页数
    property int pageSize: 60
    // 当前页
    property int currentPage: 0
    property int imgCellRectWidth: 45
    property int timeRectWidth: 54
    property int spacingWidth: 10

    function getSearchResult(offset = 0) {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var result = JSON.parse(reply).result;
            songListCount = result.songCount;
            var songs = result.songs;
            searchResultCount = songs.length;
            listView.model = songs;
            console.log("歌曲总量：" + songListCount);
            initing = false;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/cloudsearch?keywords=" + Router.routeCurrent.key + "&offset=" + offset + "&limit=60");
    }

    Component.onCompleted: {
        getSearchResult();
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: 30 * 2 + 5 + 20 + listView.height + pageButton.height

        Column {
            id: body

            spacing: 20
            x: 20
            y: 5

            Rectangle {
                width: scrollWidth
                height: 30
                color: "transparent"

                Text {
                    text: "搜索页面 待添加标头"
                    font.pixelSize: DTK.fontManager.t4.pixelSize
                    anchors.verticalCenter: parent.verticalCenter
                }

            }

            ListView {
                id: listView

                width: scrollWidth
                height: searchResultCount * 56

                delegate: ItemDelegate {
                    width: scrollWidth
                    height: 56
                    backgroundVisible: index % 2 === 0
                    hoverEnabled: true

                    Rectangle {
                        width: parent.width
                        height: parent.height
                        anchors.centerIn: parent
                        radius: 8
                        color: parent.hovered ? Qt.rgba(0, 0, 0, 0.08) : Qt.rgba(0, 0, 0, 0)

                        Row {
                            width: parent.width
                            height: parent.height
                            spacing: 10
                            leftPadding: 10
                            anchors.centerIn: parent

                            Label {
                                id: serialNumber

                                width: 20
                                text: index + 1
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            RoundedImage {
                                id: imagecell

                                width: imgCellRectWidth
                                height: imgCellRectWidth
                                anchors.verticalCenter: parent.verticalCenter
                                imgSrc: modelData.al.picUrl
                            }

                            Label {
                                id: musicNameLabel

                                width: (scrollWidth - imagecell.width - timeRectWidth - serialNumber.width - imgCellRectWidth - 10 - 50) / 3
                                height: 20
                                elide: Text.ElideRight
                                text: modelData.name
                                anchors.verticalCenter: parent.verticalCenter
                                font: DTK.fontManager.t6
                                color: checked ? palette.highlightedText : (imagecell.isCurPlay ? palette.highlight : palette.text)
                            }

                            Label {
                                id: musicSingerLabel

                                width: (scrollWidth - imagecell.width - timeRectWidth - serialNumber.width - 50 - 10) / 3
                                height: 20
                                color: checked ? palette.highlightedText : "#7C7C7C"
                                elide: Text.ElideRight
                                text: modelData.ar[0].name
                                anchors.verticalCenter: parent.verticalCenter
                                font: DTK.fontManager.t6
                            }

                            Label {
                                id: musicAlbumLabel

                                width: (scrollWidth - imagecell.width - timeRectWidth - serialNumber.width - 50 - 10) / 3
                                height: 20
                                color: checked ? palette.highlightedText : "#7C7C7C"
                                elide: Text.ElideRight
                                text: modelData.al.name
                                anchors.verticalCenter: parent.verticalCenter
                                font: DTK.fontManager.t6
                            }

                            Label {
                                id: musicTimeLabel

                                width: timeRectWidth
                                height: parent.height
                                color: checked ? palette.highlightedText : "#7C7C7C"
                                elide: Text.ElideRight
                                text: formatDuration(modelData.dt)
                                verticalAlignment: Qt.AlignVCenter
                                anchors.verticalCenter: parent.verticalCenter
                                font: DTK.fontManager.t6
                            }

                        }

                    }

                }

            }

            Item {
                id: pageButton

                width: scrollWidth
                height: 40

                Row {
                    id: buttons

                    anchors.centerIn: parent
                    spacing: 10

                    Repeater {
                        id: repeater

                        model: songListCount / pageSize > 9 ? 9 : songListCount / pageSize + 1

                        delegate: Button {
                            width: 40
                            height: 40
                            text: modelData + 1
                            font.pixelSize: DTK.fontManager.t8.pixelSize
                            ColorSelector.pressed: index == currentPage ? true : false
                            onClicked: {
                                if (currentPage == index)
                                    return ;

                                currentPage = index;
                                getSearchResult(currentPage * pageSize);
                            }
                        }

                    }

                }

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
