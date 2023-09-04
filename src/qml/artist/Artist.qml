import "../../router"
import "../widgets"
import "../../util"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property int scrollWidth: rootWindow.width - 40
    property bool initing: true
    property int hotSongsCount: 0

    function getArtistSongs() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var songs = JSON.parse(reply).hotSongs;
            if(songs.length > 12){
                hotSongsCount = 3
                artist_hot_songs.lists = songs.slice(0, 12);
            }else {
                hotSongsCount = Math.ceil(songs.length / 4);
                artist_hot_songs.lists = songs.slice(0, hotSongsCount);
            }
            
            
            
            initing = false;
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/artists?id=" + Router.routeCurrent.id);
    }

    function getArtistMv() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var mvs = JSON.parse(reply).mvs;
            if (mvs.length > 0) {
                artist_new_mv_cover.imgSrc = mvs[0].imgurl16v9;
                artist_new_mv_name.text = mvs[0].name;
                var time = mvs[0].publishTime.split("-");
                artist_new_mv_time.text = time[0] + "年" + time[1] + "月" + time[2] + "日";
            } else {
                artist_new_mv_title.visible = false;
            }
            getArtistSongs();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/artist/mv?id=" + Router.routeCurrent.id);
    }

    function getArtistNewAlbum() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var hotAlbums = JSON.parse(reply).hotAlbums;
            if (hotAlbums.length > 0)
                artist_new_album_cover.imgSrc = hotAlbums[0].blurPicUrl;

            artist_new_album_name.text = hotAlbums[0].name;
            artist_new_album_time.text = Util.formatTime(hotAlbums[0].publishTime);
            artist_new_album_count.text = "Single · " + hotAlbums[0].size + "首歌";
            getArtistMv();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/artist/album?id=" + Router.routeCurrent.id);
    }

    function getArtistInfo() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var data = JSON.parse(reply).data;
            artist_avatar.imgSrc = data.artist.avatar;
            artist_name.text = data.artist.name;
            artist_works.text = data.artist.musicSize + " 首歌 · " + data.artist.albumSize + " 张专辑 · " + data.artist.albumSize + " 个MV";
            if (data.artist.briefDesc == "")
                artistDescription.text = "暂无介绍";
            else
                artistDescription.text = data.artist.briefDesc;
            getArtistNewAlbum();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/artist/detail?id=" + Router.routeCurrent.id);
    }

    Component.onCompleted: {
        getArtistInfo();
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: 10 + 20 * 4 + headRect.height + newReleaseRect.height + artist_hot_songs.height + 30 * 2

        Column {
            id: body

            spacing: 20
            x: 20
            y: 5

            Item {
                id: headRect

                width: scrollWidth
                height: width / 3.5

                Row {
                    anchors.fill: parent
                    spacing: 30

                    Item {
                        width: height
                        height: parent.height

                        RoundedImage {
                            id: artist_avatar

                            width: parent.width * 0.9
                            height: parent.height * 0.9
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            borderRadius: width
                        }

                    }

                    Item {
                        width: parent.width / 2
                        height: parent.height

                        Column {
                            spacing: 20
                            anchors.fill: parent

                            Item {
                                width: parent.width
                                height: (parent.height - 60) / 4

                                Text {
                                    id: artist_name

                                    font.pixelSize: DTK.fontManager.t1.pixelSize
                                    font.bold: true
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: Util.textColor
                                }

                            }

                            Item {
                                width: parent.width
                                height: (parent.height - 60) / 4

                                Column {
                                    Text {
                                        text: "艺人"
                                        font.pixelSize: DTK.fontManager.t4.pixelSize
                                        color: Util.textColor
                                    }

                                    Text {
                                        id: artist_works

                                        font.pixelSize: DTK.fontManager.t6.pixelSize
                                        color: Util.textColor
                                    }

                                }

                            }

                            Item {
                                width: parent.width
                                height: (parent.height - 60) / 4

                                Label {
                                    id: artistDescription

                                    width: parent.width
                                    height: parent.height - 10
                                    anchors.verticalCenter: parent.verticalCenter
                                    wrapMode: Text.Wrap
                                    elide: Text.ElideRight
                                    maximumLineCount: 2
                                    font.pixelSize: DTK.fontManager.t6.pixelSize
                                    color: Util.textColor
                                }

                            }

                            Item {
                                width: parent.width
                                height: (parent.height - 60) / 4

                                RecommandButton {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 80
                                    height: 40
                                    text: "播放"
                                    font.bold: true
                                    font.pixelSize: DTK.fontManager.t6.pixelSize
                                    onClicked: {
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

            }

            Item {
                width: scrollWidth
                height: 30

                Text {
                    text: "最新发布"
                    font.pixelSize: DTK.fontManager.t4.pixelSize
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor
                }

            }

            Item {
                id: newReleaseRect

                width: scrollWidth
                height: width / 10

                Row {
                    anchors.fill: parent
                    spacing: 20

                    Item {
                        width: (parent.width - 20) / 2
                        height: parent.height

                        Row {
                            anchors.fill: parent
                            spacing: 20

                            RoundedImage {
                                id: artist_new_album_cover

                                height: parent.height - 5
                                width: height
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Item {
                                height: parent.height - 5
                                width: height * 2
                                anchors.verticalCenter: parent.verticalCenter

                                Column {
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 5

                                    Text {
                                        id: artist_new_album_name

                                        font.pixelSize: DTK.fontManager.t5.pixelSize
                                        font.bold: true
                                        color: Util.textColor
                                    }

                                    Text {
                                        id: artist_new_album_time

                                        font.pixelSize: DTK.fontManager.t6.pixelSize
                                        color: Util.textColor
                                    }

                                    Text {
                                        id: artist_new_album_count

                                        font.pixelSize: DTK.fontManager.t6.pixelSize
                                        color: Util.textColor
                                    }

                                }

                            }

                        }

                    }

                    Item {
                        width: (parent.width - 20) / 2
                        height: parent.height

                        Row {
                            anchors.fill: parent
                            spacing: 20

                            RoundedImage {
                                id: artist_new_mv_cover

                                height: parent.height - 5
                                width: height * 1.7
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Item {
                                height: parent.height - 5
                                width: height * 1.6
                                anchors.verticalCenter: parent.verticalCenter

                                Column {
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 5

                                    Text {
                                        id: artist_new_mv_name

                                        font.pixelSize: DTK.fontManager.t5.pixelSize
                                        font.bold: true
                                        color: Util.textColor
                                    }

                                    Text {
                                        id: artist_new_mv_time

                                        font.pixelSize: DTK.fontManager.t6.pixelSize
                                        color: Util.textColor
                                    }

                                    Text {
                                        id: artist_new_mv_title

                                        text: "最新MV"
                                        font.pixelSize: DTK.fontManager.t6.pixelSize
                                        color: Util.textColor
                                    }

                                }

                            }

                        }

                    }

                }

            }

            Item {
                width: scrollWidth
                height: 30

                Text {
                    text: "热门歌曲"
                    font.pixelSize: DTK.fontManager.t4.pixelSize
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    color: Util.textColor
                }

            }

            ArtistHotSongs {
                id: artist_hot_songs

                width: scrollWidth
                height: (scrollWidth - 30 * 3)  / 16 * hotSongsCount + 10 * 2
            }

        }

    }

    Rectangle {
        visible: initing
        anchors.fill: root
        color: Util.pageBackgroundColor

        Loading {
            anchors.centerIn: parent
        }

    }

}
