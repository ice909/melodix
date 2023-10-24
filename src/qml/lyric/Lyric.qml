import "../../util"
import "../widgets"
import Melodix.API 1.0
import Melodix.Player 1.0
import QtGraphicalEffects 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.2
import org.deepin.dtk 1.0

Item {
    id: lyricPage

    property bool initing: true
    property string titleStr: ""
    property string artist: ""
    property string album: ""
    property string bgImgPath: "qrc:/dsg/img/music.svg"
    property ListModel lrcModel

    signal currentIndexChanged(int index)

    function getLyric() {
        function onReply(lrc) {
            API.onLyricCompleted.disconnect(onReply);
            var lines = lrc.split("\n");
            for (var i = 0; i < lines.length; i++) {
                var line = lines[i].trim();
                if (line !== "") {
                    var timestampStart = line.indexOf("[");
                    var timestampEnd = line.indexOf("]");
                    var timestamp = line.substring(timestampStart + 1, timestampEnd);
                    var lyric = line.substring(timestampEnd + 1).trim();
                    var timeParts = timestamp.split(":");
                    var minutes = parseInt(timeParts[0]);
                    var seconds = parseFloat(timeParts[1]);
                    var milliseconds = Math.round((minutes * 60 + seconds) * 1000);
                    if (lyric != "")
                        lrcModel.append({
                        "time": milliseconds,
                        "lyric": lyric
                    });

                }
            }
            initing = false;
        }

        lrcModel.clear();
        API.onLyricCompleted.connect(onReply);
        API.getLyric(Player.getId());
    }

    function lyricWindowUp() {
        lyricPage.y = rootWindow.height;
        lyricRaiseAnimation.start();
        isLyricShow = true;
    }

    function lyricWindowDown() {
        lyricHideAnimation.start();
    }

    function onPlaylistCurrentIndexChanged() {
        getLyric();
        titleStr = Player.getName();
        artist = Player.getArtist();
        bgImgPath = Player.getPic();
        album = Player.getAlbum();
        coverImg.isRotating = false;
        coverImg.rotationPosition = 0;
    }

    function onPositionChanged() {
        var position = Player.getPosition();
        position = position + 500;
        //二分法查找位置
        var lt, rt;
        lt = 0;
        rt = lrcModel.count;
        while (lt < rt - 1) {
            var mid = (lt + rt) >> 1;
            var item = lrcModel.get(mid);
            if (item["time"] > position)
                rt = mid;
            else
                lt = mid;
        }
        currentIndexChanged(lt);
    }

    function onPlayStateChanged() {
        coverImg.isRotating = Player.getPlayState();
    }

    width: rootWindow.width
    height: rootWindow.height
    visible: isLyricShow
    Component.onCompleted: {
        onPlaylistCurrentIndexChanged();
        onPlayStateChanged();
        Player.playlistCurrentIndexChanged.connect(onPlaylistCurrentIndexChanged);
        Player.positionChanged.connect(onPositionChanged);
        Player.playStateChanged.connect(onPlayStateChanged);
    }

    Image {
        id: bgImg

        width: parent.width
        height: Window.height
        anchors.bottom: parent.bottom
        source: bgImgPath
        fillMode: Image.PreserveAspectCrop
        clip: true
        visible: false

        Rectangle {
            width: parent.width
            height: Window.height
            color: "#ccdddddd"
        }

    }

    FastBlur {
        anchors.fill: bgImg
        source: bgImg
        radius: 128
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
    }

    Item {
        width: scrollWidth * 0.95
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        Row {
            spacing: 33
            width: parent.width
            height: parent.height
            topPadding: 70
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                id: leftAreaColumn

                width: parent.width / 2
                height: parent.height - 141

                Item {
                    id: leftArea

                    width: parent.width * 0.9
                    height: width
                    anchors.centerIn: parent

                    RoundedImage {
                        id: coverImg

                        width: parent.width * 0.72
                        height: width
                        imgSrc: bgImgPath
                        borderRadius: height
                        anchors.centerIn: parent
                    }

                }

            }

            Column {
                id: rightAreaColumn

                property int lrcWidth: parent.width - 630
                property int lrcHeigth: parent.height - 164

                Item {
                    id: rightAreaRect

                    width: 440
                    height: rightAreaColumn.lrcHeigth
                    visible: true

                    Column {
                        spacing: 20
                        anchors.horizontalCenter: parent.horizontalCenter

                        Item {
                            id: title

                            width: 440
                            height: 80

                            Column {
                                width: parent.width
                                height: parent.height
                                spacing: 9

                                Item {
                                    width: parent.width
                                    height: 35

                                    Label {
                                        width: parent.width
                                        text: titleStr
                                        color: "#dd000000"
                                        font: DTK.fontManager.t3
                                        elide: Text.ElideRight
                                    }

                                }

                                Item {
                                    width: parent.width
                                    height: 20

                                    Row {
                                        width: parent.width
                                        height: parent.height
                                        spacing: 30

                                        Text {
                                            width: 205
                                            height: parent.height
                                            color: "#aa000000"
                                            text: "艺人" + (": %1".arg(artist.length == 0 ? "未知" : artist))
                                            font: DTK.fontManager.t6
                                            elide: Text.ElideRight
                                        }

                                        Text {
                                            width: 205
                                            height: parent.height
                                            color: "#aa000000"
                                            text: "专辑" + ": %1".arg(album.length == 0 ? "未知" : album)
                                            font: DTK.fontManager.t6
                                            elide: Text.ElideRight
                                        }

                                    }

                                }

                            }

                        }

                        Item {
                            width: 440
                            height: rightAreaColumn.lrcHeigth - 100
                            anchors.horizontalCenter: parent.horizontalCenter

                            LyricRect {
                                id: lyricRect
                            }

                        }

                    }

                }

            }

        }

    }

    Rectangle {
        visible: initing
        anchors.fill: lyricPage
        color: Util.pageBackgroundColor

        Loading {
            anchors.centerIn: parent
        }

    }

    Connections {
        function onStopped() {
            isLyricShow = false;
        }

        target: lyricHideAnimation
    }

    lrcModel: ListModel {
    }

    NumberAnimation on y {
        id: lyricRaiseAnimation

        running: false
        to: -50
        duration: 200
        easing.type: Easing.OutCubic
    }

    NumberAnimation on y {
        id: lyricHideAnimation

        running: false
        from: -50
        to: rootWindow.height
        duration: 200
        easing.type: Easing.OutCubic
    }

}
