import "../../router"
import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Menu {
    property bool playState: false

    Component.onCompleted: {
        playState = player.getPlayState();
    }

    Connections {
        function onPlayStateChanged() {
            playState = player.getPlayState();
        }

        target: player
    }

    MenuItem {
        id: playOrPauseBtn

        text: playState ? "暂停" : "播放"
        onTriggered: {
            if (!player.getMediaCount())
                return ;

            if (playState)
                player.pause();
            else
                player.play();
        }
    }

}
