import "../../util"
import "../widgets"
import Melodix.API 1.0
import Melodix.Player 1.0
import QtGraphicalEffects 1.0
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import org.deepin.dtk 1.0

FloatingPanel {
    id: toolbarRoot

    // 歌曲名称
    property string songTitle: ""
    // 歌曲作者
    property string artistStr: ""
    // 歌曲封面
    property string picUrl: ""
    // 是否为我喜欢的歌曲
    property bool favorite: false
    // 当前歌曲播放进度
    property int currentPosition: 0
    // 当前歌曲总时长
    property int duration: 0
    // 格式化的歌曲播放进度
    property string currentTime: "0:00"
    // 格式化的歌曲总时长
    property string totalTime: "0:00"
    // 是否静音
    property bool iMute: false
    // 播放状态：暂停/播放
    property int playStatus: 2
    // 播放模式
    // 0~2 单曲循环 循环播放 随机播放
    property int playMode: 1
    // 播放模式对应的图标
    property var modeIcon: ["toolbar_music_repeatcycle", "toolbar_music_repeat", "toolbar_music_shuffle"]
    // 播放模式对应的tooltip
    property var modeIconTooltTip: ["单曲循环", "循环播放", "随机播放"]
    // 是否显示音量调节面板
    property bool isVolSliderShow: false
    property int contentItemSpacing: 8
    property int leftPaddingWidth: 10
    property int rightPaddingWidth: 10
    property int coverRectWidth: 40
    property int infoRectWidth: 142
    property int playControlRectWidth: 220
    property int rightAreaRectWidth: 228

    signal playlistBtnClicked()
    signal lyricToggleClicked()

    function onPlaylistCurrentIndexChanged() {
        console.log("播放列表 currentIndex 改变");
        songTitle = Player.getName();
        artistStr = Player.getArtist();
        picUrl = Player.getPic();
        var musicId = Player.getId();
        var index = -1;
        for (const id of userFavoriteSongsID) {
            if (id == musicId) {
                index = 0;
                break;
            }
        }
        if (index != -1)
            favorite = true;
        else
            favorite = false;
    }

    function onPlayStateChanged() {
        playStatus = Player.getPlayState();
    }

    function onDurationChanged() {
        duration = Player.getDuration();
        totalTime = Player.getFormatDuration();
    }

    function onPositionChanged() {
        currentPosition = Player.getPosition();
        currentTime = Player.getFormatPosition();
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

    function likeMusic() {
        function onReply(reply) {
            API.onLikeMusicCompleted.disconnect(onReply);
            if (reply.code === 200) {
                if (!favorite) {
                    console.log("已添加到我喜欢的歌曲");
                    favorite = true;
                    userFavoriteSongsID.push(Player.getId());
                } else {
                    console.log("已经从我喜欢的歌曲中移除");
                    favorite = false;
                    var id = Player.getId();
                    for (var i = 0; i < userFavoriteSongsID.length; i++) {
                        if (userFavoriteSongsID[i] == id)
                            userFavoriteSongsID[i] = 0;

                    }
                }
            } else {
                console.log("请求失败");
            }
        }

        API.onLikeMusicCompleted.connect(onReply);
        API.likeMusic(Player.getId(), favorite ? "false" : "true");
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Space)
            Player.playOrPause();

    }
    height: 60
    width: parent.width
    z: 10
    Component.onCompleted: {
        Player.playlistCurrentIndexChanged.connect(onPlaylistCurrentIndexChanged);
        Player.playStateChanged.connect(onPlayStateChanged);
        Player.durationChanged.connect(onDurationChanged);
        Player.positionChanged.connect(onPositionChanged);
        Player.playlistCleared.connect(onPlaylistCleared);
        playMode = Player.getPlaybackMode();
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
        rightPadding: rightPaddingWidth

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

        Item {
            id: infoRect

            width: infoRectWidth
            height: 40
            anchors.verticalCenter: parent.verticalCenter

            Column {
                anchors.fill: parent
                spacing: 2

                Item {
                    width: parent.width
                    height: parent.height / 2 - 1

                    Text {
                        id: title

                        width: parent.width - 35
                        color: Util.textColor
                        text: songTitle
                        font.pixelSize: 13
                        elide: Text.ElideRight
                        anchors.verticalCenter: parent.verticalCenter

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onEntered: {
                                if (songTitle.length > 0)
                                    titleTooltip.visible = true;

                            }
                            onExited: {
                                if (songTitle.length > 0)
                                    titleTooltip.visible = false;

                            }
                        }

                        ToolTip {
                            id: titleTooltip

                            text: songTitle
                        }

                    }

                }

                Text {
                    id: artist

                    width: parent.width
                    text: artistStr
                    color: Util.textColor
                    elide: Text.ElideRight

                    font {
                        family: "SourceHanSansSC, SourceHanSansSC-Normal"
                        pixelSize: 12
                        weight: Font.Medium
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            if (artistStr.length > 0)
                                artistTooltip.visible = true;

                        }
                        onExited: {
                            if (artistStr.length > 0)
                                artistTooltip.visible = false;

                        }
                    }

                    ToolTip {
                        id: artistTooltip

                        text: artistStr
                    }

                }

            }

        }

        Item {
            id: playControlRect

            width: playControlRectWidth
            height: parent.height
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
                        likeMusic();
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
                        Player.previous();
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
                    icon.name: playStatus === 0 ? "toolbar_pause" : "toolbar_play"
                    icon.width: 36
                    icon.height: 36
                    checkable: true
                    onClicked: {
                        Player.playOrPause();
                    }

                    ToolTip {
                        visible: playPauseBtn.hovered
                        text: playStatus === 0 ? "暂停" : "播放"
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
                        Player.next();
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
                    icon.name: modeIcon[playMode]
                    icon.width: 36
                    icon.height: 36
                    onClicked: {
                        if (playMode == 2)
                            playMode = 0;
                        else
                            playMode++;
                        Player.setPlaybackMode(playMode);
                    }

                    ToolTip {
                        visible: playModeBtn.hovered
                        text: modeIconTooltTip[playMode]
                    }

                }

            }

        }

        Slider {
            width: parent.width - (coverRectWidth + infoRectWidth + playControlRectWidth + rightAreaRectWidth + contentItemSpacing * 4 + leftPaddingWidth + rightPaddingWidth)
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            from: 0
            value: currentPosition
            to: duration
            onMoved: {
                Player.setPosition(value);
            }
        }

        Item {
            id: rightAreaRect

            width: rightAreaRectWidth
            height: parent.height

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
                            color: Util.textColor
                            font: DTK.fontManager.t8
                        }

                        Text {
                            id: totalTimeText

                            width: 44
                            anchors.verticalCenter: parent.verticalCenter
                            elide: Text.ElideRight
                            enabled: songTitle.length === 0 ? false : true
                            text: "/ " + (enabled ? totalTime : "0:00")
                            color: Util.textColor
                            font: DTK.fontManager.t8
                        }

                    }

                }

                ToolButton {
                    id: lrcBtn

                    width: 36
                    height: 36
                    anchors.verticalCenter: parent.verticalCenter
                    icon.name: "toolbar_lrc"
                    icon.width: 36
                    icon.height: 36
                    checkable: true
                    checked: isLyricShow
                    enabled: songTitle.length === 0 ? false : true
                    onClicked: {
                        lyricToggleClicked();
                    }
                }

                ToolButton {
                    id: volumeBtn

                    width: 36
                    height: 36
                    anchors.verticalCenter: parent.verticalCenter
                    icon.name: iMute ? "toolbar_volume-" : "toolbar_volume+"
                    icon.width: 36
                    icon.height: 36
                    checkable: true
                    onClicked: {
                        isVolSliderShow = !isVolSliderShow;
                        if (volSliderLoader.status === Loader.Null) {
                            volSliderLoader.setSource("VolumeSlider.qml");
                            volSliderLoader.item.y = -255;
                            volSliderLoader.item.hoveredChanged.connect(onVolSliderHoveredChanged);
                        }
                        volSliderLoader.item.x = toolbarRoot.width - 10 * 3 - volumeBtn.width * 2;
                        volSliderLoader.item.visible = isVolSliderShow;
                    }
                }

                ToolButton {
                    id: listBtn

                    width: 36
                    height: 36
                    anchors.verticalCenter: parent.verticalCenter
                    icon.name: "toolbar_playlist"
                    icon.width: 36
                    icon.height: 36
                    checkable: true
                    checked: isPlaylistShow
                    onClicked: {
                        playlistBtnClicked();
                    }

                    ToolTip {
                        visible: listBtn.hovered
                        text: "播放列表"
                    }

                }

            }

        }

    }

}
