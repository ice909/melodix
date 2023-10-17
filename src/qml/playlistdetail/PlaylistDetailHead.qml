import "../../router"
import "../../util"
import "../widgets"
import Melodix.Player 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Row {
    property string cover: ""
    property string name: ""
    property string creatorNickname: ""
    property string updateTime: ""
    property string description: ""

    spacing: 30

    Item {
        width: 1
        height: 1
    }

    RoundedImage {
        id: coverImg

        width: scrollWidth / 3.9
        height: width
        imgSrc: cover
    }

    Item {
        width: scrollWidth - coverImg.width - 10 - 30 - 10 - 30
        height: coverImg.height

        Column {
            anchors.fill: parent
            spacing: 10

            Item {
                width: 10
                height: 5
            }

            Text {
                id: playlistName

                width: parent.width
                height: (parent.height - 40) / 4 - 10
                font.pixelSize: DTK.fontManager.t3.pixelSize
                font.bold: true
                color: Util.textColor
                text: name
            }

            Item {
                width: parent.width
                height: (parent.height - 40) / 4

                Text {
                    id: playlistAuthor

                    width: parent.width
                    height: parent.height / 2
                    font.pixelSize: DTK.fontManager.t4.pixelSize
                    font.bold: true
                    color: Util.textColor
                    text: creatorNickname
                }

                Text {
                    id: playlistUpdateTime

                    anchors.top: playlistAuthor.bottom
                    anchors.topMargin: 2
                    width: parent.width
                    height: parent.height / 2
                    font.pixelSize: DTK.fontManager.t5.pixelSize
                    color: Util.textColor
                    text: updateTime
                }

            }

            Label {
                id: playlistDescription

                width: parent.width
                height: (parent.height - 40) / 4 + 10
                wrapMode: Text.Wrap
                elide: Text.ElideRight
                maximumLineCount: 3
                font.pixelSize: DTK.fontManager.t6.pixelSize
                color: Util.textColor
                text: description
            }

            Item {
                width: parent.width
                height: (parent.height - 40) / 4

                    RecommandButton {
                        width: 80
                        height: 40
                        text: "播放"
                        font.bold: true
                        font.pixelSize: DTK.fontManager.t6.pixelSize
                        onClicked: {
                            console.log("播放按钮点击");
                            if (!isAddToPlaylist)
                                playPlaylistAllMusic();
                            else
                                Player.play(0);
                        }

                        icon {
                            name: "details_play"
                            width: 25
                            height: 25
                        }

                    }

            }

        }

    }

}
