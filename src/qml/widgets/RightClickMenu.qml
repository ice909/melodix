import "../../router"
import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Menu {
    property bool playState: false
    property int clickIndex: -1
    property int playIndex: -1

    Connections {
        function onPlayStateChanged() {
            playState = player.getPlayState();
        }

        target: player
    }

    MenuItem {
        id: playOrPauseBtn

        text: clickIndex == playIndex ? (playState ? "暂停" : "播放") : "播放"
        onTriggered: {
            if (clickIndex === -1)
                return ;

            if (!player.getMediaCount())
                return ;

            if (playState && clickIndex === playIndex) {
                player.pause();
            } else {
                if (clickIndex !== playIndex)
                    player.play(clickIndex);
                else
                    player.play();
            }
        }
    }

}
