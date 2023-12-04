import "../../router"
import "../../util"
import "../widgets"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool initing: true
    property int hotSongsCount: 0

    function getArtistSongs() {
        function onReply(songs) {
            API.onArtistSongsCompleted.disconnect(onReply);
            if (songs.length > 12) {
                hotSongsCount = 3;
                artist_hot_songs.lists = songs.slice(0, 12);
            } else {
                hotSongsCount = Math.ceil(songs.length / 4);
                artist_hot_songs.lists = songs.slice(0, hotSongsCount);
            }
            initing = false;
        }

        API.onArtistSongsCompleted.connect(onReply);
        API.getArtistSongs(Router.routeCurrent.id);
    }

    function getArtistNewAlbum() {
        function onReply(hotAlbums) {
            API.onArtistAlbumCompleted.disconnect(onReply);
            if (hotAlbums.length > 0)
                artist_new_album_cover.imgSrc = hotAlbums[0].blurPicUrl;

            artist_new_album_name.text = hotAlbums[0].name;
            artist_new_album_time.text = Util.formatTime(hotAlbums[0].publishTime);
            artist_new_album_count.text = "Single · " + hotAlbums[0].size + "首歌";
            getArtistSongs();
        }

        API.onArtistAlbumCompleted.connect(onReply);
        API.getArtistAlbum(Router.routeCurrent.id);
    }

    function getArtistInfo() {
        function onReply(reply) {
            API.onArtistDetailCompleted.disconnect(onReply);
            artist_avatar.imgSrc = reply.artist.avatar;
            artist_name.text = reply.artist.name;
            artist_works.text = reply.artist.musicSize + " 首歌 · " + reply.artist.albumSize + " 张专辑 · " + reply.artist.albumSize + " 个MV";
            if (reply.artist.briefDesc == "")
                artistDescription.text = "暂无介绍";
            else
                artistDescription.text = reply.artist.briefDesc;
            getArtistNewAlbum();
        }

        API.onArtistDetailCompleted.connect(onReply);
        API.getArtistDetail(Router.routeCurrent.id);
    }

    Component.onCompleted: {
        getArtistInfo();
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        Column {
            id: body

            spacing: 20
            x: Util.pageLeftPadding
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

                                Text {
                                    id: artistDescription

                                    width: parent.width
                                    height: parent.height
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
                height: (scrollWidth - 30 * 3) / 16 * hotSongsCount + 10 * 2
            }

            Item {
                width: scrollWidth
                height: 10
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
