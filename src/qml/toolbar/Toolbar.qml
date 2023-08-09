import "../widgets"
import QtGraphicalEffects 1.0
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import org.deepin.dtk 1.0

FloatingPanel {
    id: toolbarRoot

    property string songTitle: ""
    property string artistStr: ""
    property string picUrl: ""
    property bool favorite: false
    property int currentPosition: 0
    property int duration: 0
    property string totalTime: "0:00"
    property string currentTime: "0:00"
    property bool iMute: false
    property int contentItemSpacing: 8
    property int leftPaddingWidth: 20
    property int rightPaddingWidth: 10
    property int coverRectWidth: 40
    property int infoRectWidth: 142
    property int playControlRectWidth: 220
    property int rightAreaRectWidth: 228
    property bool playStatus: false
    property int playMode: 3
    property bool isVolSliderShow: false
    property var modeIcon: ["toolbar_music_repeatcycle", "toolbar_music_sequence", "toolbar_music_repeat", "toolbar_music_shuffle"]
    property var modeIconTooltTip: ["单曲循环", "顺序播放", "循环播放", "随机播放"]

    signal playlistBtnClicked()

    function updatePlaylistBtnStatus(checked) {
        listBtn.checked = checked;
    }

    function onPlaylistCurrentIndexChanged() {
        console.log("播放列表 currentIndex 改变");
        songTitle = player.getName();
        artistStr = player.getArtist();
        picUrl = player.getPic();
    }

    function onPlayStateChanged() {
        playStatus = player.getPlayState();
    }

    function onDurationChanged() {
        duration = player.getDuration();
        totalTime = player.getFormatDuration();
    }

    function onPositionChanged() {
        currentPosition = player.getPosition();
        currentTime = player.getFormatPosition();
    }

    function onVolSliderHoveredChanged() {
        if (!volSliderLoader.item.hovered) {
            if (volSliderHideTimer.running)
                volSliderHideTimer.stop();

            volSliderHideTimer.start();
        } else {
            volSliderHideTimer.stop();
        }
    }

    function onPlaylistCleared() {
        duration = 0;
        totalTime = "0:00";
        currentPosition = 0;
        currentTime = "0:00";
        songTitle = "";
        artistStr = "";
    }

    height: 60
    width: parent.width
    Component.onCompleted: {
        player.playlistCurrentIndexChanged.connect(onPlaylistCurrentIndexChanged);
        player.playStateChanged.connect(onPlayStateChanged);
        player.durationChanged.connect(onDurationChanged);
        player.positionChanged.connect(onPositionChanged);
        player.playlistCleared.connect(onPlaylistCleared);
        playMode = player.getPlaybackMode();
    }

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        leftMargin: 10
        rightMargin: 10
        bottomMargin: 10
    }

    Loader {
        id: volSliderLoader
    }

    Timer {
        id: volSliderHideTimer

        interval: 3000
        repeat: false
        running: false
        onTriggered: {
            if (volSliderLoader.status !== Loader.Null)
                volSliderLoader.item.visible = false;

            volumeBtn.checked = false;
            isVolSliderShow = false;
        }
    }

    contentItem: Row {
        width: parent.width
        height: parent.height
        anchors.fill: parent
        spacing: contentItemSpacing
        leftPadding: leftPaddingWidth

        Rectangle {
            width: coverRectWidth
            height: coverRectWidth
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            color: songTitle.length === 0 ? "#d7d7d7" : "transparent"

            RoundedImage {
                width: songTitle.length === 0 ? 24 : parent.width
                height: songTitle.length === 0 ? 24 : parent.height
                anchors.centerIn: parent
                imgSrc: songTitle.length === 0 ? "qrc:/dsg/img/no_music.svg" : picUrl
            }

        }

        Rectangle {
            id: infoRect

            width: infoRectWidth
            height: 40
            color: "transparent"
            anchors.verticalCenter: parent.verticalCenter

            Column {
                width: parent.width

                Text {
                    id: title

                    width: parent.width
                    color: Qt.rgba(0, 0, 0, 0.9)
                    text: songTitle
                    font.pixelSize: 14
                    elide: Text.ElideRight
                }

                Text {
                    id: artist

                    width: parent.width
                    text: artistStr
                    color: Qt.rgba(0, 0, 0, 0.7)
                    elide: Text.ElideRight

                    font {
                        family: "SourceHanSansSC, SourceHanSansSC-Normal"
                        pixelSize: 12
                        weight: Font.Medium
                    }

                }

            }

        }

        Rectangle {
            id: playControlRect

            width: playControlRectWidth
            height: parent.height
            color: "transparent"
            anchors.verticalCenter: parent.verticalCenter

            Row {
                spacing: 10
                anchors.verticalCenter: parent.verticalCenter

                ActionButton {
                    id: likeBtn

                    width: 36
                    height: 36
                    anchors.verticalCenter: parent.verticalCenter
                    icon.name: favorite ? "toolbar_like_check" : "toolbar_like"
                    icon.width: 36
                    icon.height: 36
                    enabled: songTitle.length === 0 ? false : true
                    onClicked: {
                    }

                    ToolTip {
                        visible: likeBtn.hovered
                        text: favorite ? qsTr("不喜欢") : qsTr("喜欢")
                    }

                }

                ActionButton {
                    id: prevBtn

                    width: 36
                    height: 36
                    anchors.verticalCenter: parent.verticalCenter
                    icon.name: "toolbar_previous"
                    icon.width: 20
                    icon.height: 20
                    checkable: true
                    enabled: songTitle.length === 0 ? false : true
                    onClicked: {
                        player.previous();
                    }

                    ToolTip {
                        visible: prevBtn.hovered
                        text: qsTr("上一首")
                    }

                }

                ActionButton {
                    id: playPauseBtn

                    width: 36
                    height: 36
                    anchors.verticalCenter: parent.verticalCenter
                    icon.name: playStatus ? "toolbar_pause" : "toolbar_play"
                    icon.width: 36
                    icon.height: 36
                    checkable: true
                    onClicked: {
                        if (player.getPlayState())
                            player.pause();
                        else
                            player.play();
                    }

                    ToolTip {
                        visible: playPauseBtn.hovered
                        text: qsTr("播放/暂停")
                    }

                }

                ActionButton {
                    id: nextBtn

                    width: 36
                    height: 36
                    anchors.verticalCenter: parent.verticalCenter
                    icon.name: "toolbar_next"
                    icon.width: 20
                    icon.height: 20
                    checkable: true
                    enabled: songTitle.length === 0 ? false : true
                    onClicked: {
                        player.next();
                    }

                    ToolTip {
                        visible: nextBtn.hovered
                        text: qsTr("下一首")
                    }

                }

                ActionButton {
                    id: playModeBtn

                    width: 36
                    height: 36
                    anchors.verticalCenter: parent.verticalCenter
                    icon.name: modeIcon[playMode - 1]
                    icon.width: 36
                    icon.height: 36
                    onClicked: {
                        if (playMode == 4)
                            playMode = 1;
                        else
                            playMode++;
                        player.setPlaybackMode(playMode);
                    }

                    ToolTip {
                        visible: playModeBtn.hovered
                        text: modeIconTooltTip[playMode - 1]
                    }

                }

            }

        }

        Slider {
            width: parent.width - (coverRectWidth + infoRectWidth + playControlRectWidth + rightAreaRectWidth + contentItemSpacing * 4 + leftPaddingWidth + rightPaddingWidth)
            anchors.verticalCenter: parent.verticalCenter
            from: 0
            value: currentPosition
            to: duration
        }

        Rectangle {
            id: rightAreaRect

            width: rightAreaRectWidth
            height: parent.height
            color: "#00000000"

            Row {
                width: parent.width
                height: parent.height
                spacing: 10
                leftPadding: 10

                Rectangle {
                    id: timeLabel

                    width: 80
                    height: parent.height
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter

                    Row {
                        width: parent.width
                        height: parent.height
                        spacing: 4
                        leftPadding: 4

                        Text {
                            id: curTimeText

                            width: 37
                            anchors.verticalCenter: parent.verticalCenter
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignRight
                            enabled: songTitle.length === 0 ? false : true
                            text: enabled ? currentTime : "0:00"
                            color: Qt.rgba(0, 0, 0, 0.7)
                            font: DTK.fontManager.t8
                        }

                        Text {
                            id: totalTimeText

                            width: 44
                            anchors.verticalCenter: parent.verticalCenter
                            elide: Text.ElideRight
                            enabled: songTitle.length === 0 ? false : true
                            text: "/ " + (enabled ? totalTime : "0:00")
                            color: Qt.rgba(0, 0, 0, 0.7)
                            font: DTK.fontManager.t8
                        }

                    }

                }

                ToolButton {
                    id: lrcBtn

                    width: 36
                    height: 36
                    anchors.verticalCenter: parent.verticalCenter
                    icon.name: checked ? "toolbar_lrc_checked" : "toolbar_lrc"
                    icon.width: 36
                    icon.height: 36
                    checkable: true
                    enabled: songTitle.length === 0 ? false : true
                    onClicked: {
                    }
                }

                ToolButton {
                    id: volumeBtn

                    width: 36
                    height: 36
                    anchors.verticalCenter: parent.verticalCenter
                    icon.name: iMute ? (checked ? "toolbar_volume-_checked" : "toolbar_volume-") : (checked ? "toolbar_volume+_checked" : "toolbar_volume+")
                    icon.width: 36
                    icon.height: 36
                    checkable: true
                    onClicked: {
                        isVolSliderShow = !isVolSliderShow;
                        if (volSliderLoader.status === Loader.Null) {
                            volSliderLoader.setSource("VolumeSlider.qml");
                            volSliderLoader.item.x = toolbarRoot.width - 10 * 3 - width * 2;
                            volSliderLoader.item.y = -255;
                            volSliderLoader.item.hoveredChanged.connect(onVolSliderHoveredChanged);
                        }
                        volSliderLoader.item.visible = isVolSliderShow;
                    }
                }

                ToolButton {
                    id: listBtn

                    width: 36
                    height: 36
                    anchors.verticalCenter: parent.verticalCenter
                    icon.name: checked ? "toolbar_playlist_checked" : "toolbar_playlist"
                    icon.width: 36
                    icon.height: 36
                    checkable: true
                    onClicked: {
                        playlistBtnClicked();
                    }

                    ToolTip {
                        visible: listBtn.hovered
                        text: qsTr("播放列表")
                    }

                }

            }

        }

    }

}
