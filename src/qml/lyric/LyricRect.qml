import Melodix.Player 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: lyricRect

    // 当前歌词索引
    property int curIndex: 0
    // 是否正在滑动
    property bool isFlicking: false
    // 每行歌词的高度
    property int itemHeight: 45
    // 高亮显示的歌词行的高度
    property int highlightItemHeight: 60

    width: parent.width
    height: parent.height
    anchors.horizontalCenter: parent.horizontalCenter

    Timer {
        id: flickTimer

        interval: 3000
        repeat: false
        onTriggered: {
            isFlicking = false;
        }
    }

    ListView {
        id: listViewLyric

        function updateContentY() {
            if (isFlicking)
                return ;

            if (currentIndex * itemHeight <= lyricRect.height / 2) {
                //console.log("originY:" + originY + "     currentIndex:" + currentIndex + "      " )
                listViewLyric.contentY = 0 + originY;
            } else {
                if (currentIndex <= lrcModel.count - Math.round(lyricRect.height / 2 / itemHeight))
                    listViewLyric.contentY = (currentIndex - Math.round((lyricRect.height - itemHeight) / itemHeight / 2)) * itemHeight + originY;

            }
        }

        anchors.fill: parent
        clip: true
        currentIndex: curIndex
        model: lrcModel
        delegate: lyricDelegate
        onFlickStarted: {
            isFlicking = true;
        }
        onFlickEnded: {
            isFlicking = true;
            if (flickTimer.running)
                flickTimer.stop();

            flickTimer.start();
        }
        onMovementStarted: {
            isFlicking = true;
        }
        onMovementEnded: {
            if (flickTimer.running)
                flickTimer.stop();

            flickTimer.start();
        }

        ScrollBar.vertical: ScrollBar {
        }

        Behavior on contentY {
            NumberAnimation {
                duration: listViewLyric.currentIndex + 1 < listViewLyric.count - lyricRect.height / 2 / itemHeight ? 500 : 0
                easing.type: Easing.OutCubic
            }

        }

    }

    Component {
        id: lyricDelegate

        Rectangle {
            id: lyricItemRect

            width: listViewLyric.width
            height: itemHeight
            color: "#00000000"

            Text {
                id: txtLyric

                width: parent.width
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: lyric
                color: {
                    // 根据距离添加渐变
                    if (lyricItemRect.ListView.isCurrentItem)
                        return palette.highlight;

                    if (curIndex <= Math.abs(lyricRect.height / itemHeight / 2)) {
                        //开始
                        if (index > Math.abs(lyricRect.height / itemHeight) - 2)
                            return Qt.rgba(0, 0, 0, 0.24);
                        else if (index > Math.abs(lyricRect.height / itemHeight) - 3)
                            return Qt.rgba(0, 0, 0, 0.42);
                        else
                            return Qt.rgba(0, 0, 0, 0.7);
                    } else if (curIndex > lrcModel.count - Math.abs(lyricRect.height / itemHeight / 2)) {
                        //结尾
                        if (index < lrcModel.count - Math.abs(lyricRect.height / itemHeight) + 1)
                            return Qt.rgba(0, 0, 0, 0.24);
                        else if (index < lrcModel.count - Math.abs(lyricRect.height / itemHeight) + 2)
                            return Qt.rgba(0, 0, 0, 0.42);
                        else
                            return Qt.rgba(0, 0, 0, 0.7);
                    } else {
                        //中间部分
                        if (Math.abs(curIndex - index) > Math.abs(lyricRect.height / itemHeight / 2) - 1)
                            return Qt.rgba(0, 0, 0, 0.24);
                        else if (Math.abs(curIndex - index) > Math.abs(lyricRect.height / itemHeight / 2) - 2)
                            return Qt.rgba(0, 0, 0, 0.42);
                        else
                            return Qt.rgba(0, 0, 0, 0.7);
                    }
                }
                font.family: "SourceHanSansSC"
                font.pixelSize: lyricItemRect.ListView.isCurrentItem ? 18 : 14
                font.weight: lyricItemRect.ListView.isCurrentItem ? Font.DemiBold : Font.Medium
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onDoubleClicked: {
                    console.log("歌词双击:  index:" + index);
                    curIndex = index;
                    var time = lrcModel.get(curIndex)["time"];
                    Player.setPosition(time);
                }
            }

        }

    }

    Connections {
        function onCurrentIndexChanged(index) {
            if (isFlicking)
                return ;

            if (!listViewLyric.flicking)
                curIndex = index;

            listViewLyric.updateContentY();
        }

        target: lyricPage
    }

}
