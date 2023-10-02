import "../../router"
import "../../util"
import "../widgets"
import Melodix.Player 1.0
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Menu {
    property bool playState: false
    property int clickIndex: -1
    property int playIndex: -1

    Connections {
        function onPlayStateChanged() {
            playState = Player.getPlayState();
        }

        target: Player
    }

    MenuItem {
        id: playOrPauseBtn

        text: clickIndex == playIndex ? (playState ? "暂停" : "播放") : "播放"
        onTriggered: {
            if (clickIndex === -1)
                return ;

            if (!Player.getMediaCount())
                return ;

            if (playState && clickIndex === playIndex) {
                Player.pause();
            } else {
                if (clickIndex !== playIndex)
                    Player.play(clickIndex);
                else
                    Player.play();
            }
        }
    }

}
