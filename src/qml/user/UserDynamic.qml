import "../../util"
import "../widgets"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property ListModel dynamicLists
    property int dynamicCount: 0

    width: scrollWidth
    height: 600 * dynamicCount + 20 * (dynamicCount - 1) + 10
    Component.onDestruction: console.log("UserDynamic destroyed")

    Column {
        anchors.fill: parent
        spacing: 20
        x: Util.pageLeftPadding
        y: 5

        Repeater {
            id: repeater

            model: dynamicLists

            Rectangle {
                id: dynamicRect

                width: scrollWidth
                height: 600
                color: "#fff"
                radius: 10

                Column {
                    anchors.fill: parent
                    spacing: 10

                    Item {
                        id: dynamicHeader

                        width: parent.width - 20
                        x: 10
                        height: 60

                        Row {
                            anchors.fill: parent
                            spacing: 10

                            RoundedImage {
                                id: avatar

                                anchors.verticalCenter: parent.verticalCenter
                                width: 50
                                height: 50
                                borderRadius: 50
                                imgSrc: modelData.user.avatarUrl
                            }

                            Item {
                                width: 100
                                height: 50
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 5

                                Text {
                                    id: username

                                    text: modelData.user.nickname
                                    font.pixelSize: 16
                                    anchors.bottom: time.top
                                    anchors.bottomMargin: 1
                                }

                                Text {
                                    id: time

                                    text: Util.formatDynamicTime(modelData.eventTime)
                                    font.pixelSize: 12
                                    anchors.bottom: parent.bottom
                                }

                            }

                        }

                    }

                    Item {
                        id: dynamicContent

                        width: parent.width - 20
                        height: parent.height - dynamicHeader.height - dynamicFooter.height - 20
                        x: 10

                        // 图文动态
                        Item {
                            id: picTextItem

                            visible: modelData.type == 35
                            anchors.fill: parent

                            Column {
                                anchors.fill: parent

                                Text {
                                    id: content

                                    text: modelData.type == 35 ? (modelData.json.msg || "") : ""
                                    font.pixelSize: 16
                                }

                                Image {
                                    id: img

                                    width: (modelData.pics && modelData.pics[0].width < modelData.pics[0].height) ? parent.height / 2 : parent.width * 0.5
                                    height: content.text !== "" ? parent.height - content.height : parent.height
                                    source: modelData.pics ? modelData.pics[0].originUrl : ""

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            if (img.source !== "")
                                                Worker.openUrl(img.source);

                                        }
                                    }

                                }

                            }

                        }

                        // 分享活动
                        Item {
                            id: eventsItem

                            visible: modelData.type == 56
                            anchors.fill: parent

                            Rectangle {
                                width: height * 0.81
                                height: parent.height - 20
                                color: Qt.rgba(0, 0, 0, 0.1)
                                radius: 5
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 10

                                Column {
                                    x: 10
                                    y: 10
                                    width: parent.width - 20
                                    height: parent.height - 20
                                    spacing: 10

                                    RoundedImage {
                                        id: eventsItemCover

                                        width: parent.height * 0.8
                                        height: parent.height * 0.8
                                        borderRadius: 5
                                        imgSrc: modelData.type == 56 ? modelData.json.resource.coverImgUrl : ""
                                    }

                                    Text {
                                        id: eventsItemTitle

                                        text: modelData.type == 56 ? modelData.json.resource.title : ""
                                        font.pixelSize: 20
                                        font.bold: true
                                    }

                                    Text {
                                        id: eventsItemSubTitle

                                        text: modelData.type == 56 ? modelData.json.resource.subTitle : ""
                                        font.pixelSize: 16
                                    }

                                }

                            }

                        }

                        // 分享单曲
                        Item {
                            id: songItem

                            visible: modelData.type == 18
                            anchors.fill: parent

                            Text {
                                id: songItemText

                                text: modelData.type == 18 ? modelData.info.commentThread.resourceInfo.name : ""
                                font.pixelSize: 20
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.top: parent.top
                                anchors.topMargin: 10
                            }

                            Rectangle {
                                width: parent.width - 20
                                height: parent.height * 0.3
                                color: Qt.rgba(0, 0, 0, 0.1)
                                radius: 5
                                anchors.centerIn: parent

                                Row {
                                    x: 10
                                    y: 10
                                    width: parent.width - 20
                                    height: parent.height - 20
                                    spacing: 20

                                    RoundedImage {
                                        id: songItemCover

                                        width: parent.height * 0.8
                                        height: parent.height * 0.8
                                        borderRadius: 5
                                        imgSrc: modelData.type == 18 ? modelData.json.song.album.picUrl : ""
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    Item {
                                        width: parent.width - songItemCover.width - 10
                                        height: parent.height

                                        Text {
                                            id: songItemTitle

                                            text: modelData.type == 18 ? modelData.json.song.name : ""
                                            font.pixelSize: 20
                                            font.bold: true
                                            anchors.bottom: centerItem.top
                                        }

                                        Item {
                                            id: centerItem

                                            width: 1
                                            height: 10
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        Text {
                                            id: songItemAuthor

                                            anchors.top: centerItem.bottom
                                            text: modelData.type == 18 ? modelData.json.song.artists[0].name : ""
                                            font.pixelSize: 16
                                        }

                                    }

                                }

                            }

                        }

                        // 分享视频
                        Item {
                            id: videoItem

                            visible: modelData.type == 41
                            anchors.fill: parent

                            RoundedImage {
                                id: videoItemCover

                                width: parent.width - 10
                                height: parent.height - 10
                                imgSrc: modelData.type == 41 ? modelData.json.video.coverUrl : ""
                                isDynamic: true
                                anchors.centerIn: parent

                                PlayTime {
                                    id: playTime

                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 5
                                    playTime: modelData.type == 41 ? modelData.json.video.playTime : 0
                                }

                                Duration {
                                    id: duration

                                    anchors.right: parent.right
                                    anchors.rightMargin: 5
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 5
                                    duration: modelData.type == 41 ? modelData.json.video.duration : 0
                                }

                            }

                        }

                    }

                    Item {
                        id: dynamicFooter

                        width: parent.width - 20
                        height: 40
                        x: 10

                        Row {
                            anchors.fill: parent
                            spacing: 20

                            Rectangle {
                                width: 31
                                height: 31
                                radius: 5
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                RoundedImage {
                                    anchors.centerIn: parent
                                    width: 30
                                    height: 30
                                    imgSrc: "qrc:/dsg/icons/praise-light.svg"
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        parent.color = "#eee";
                                    }
                                    onExited: {
                                        parent.color = "transparent";
                                    }
                                }

                            }

                            Rectangle {
                                width: 31
                                height: 31
                                radius: 5
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                RoundedImage {
                                    anchors.centerIn: parent
                                    width: 30
                                    height: 30
                                    imgSrc: "qrc:/dsg/icons/share-light.svg"
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        parent.color = "#eee";
                                    }
                                    onExited: {
                                        parent.color = "transparent";
                                    }
                                }

                            }

                            Rectangle {
                                width: 31
                                height: 31
                                radius: 5
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                RoundedImage {
                                    anchors.centerIn: parent
                                    width: 30
                                    height: 30
                                    imgSrc: "qrc:/dsg/icons/comment-light.svg"
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        parent.color = "#eee";
                                    }
                                    onExited: {
                                        parent.color = "transparent";
                                    }
                                }

                            }

                        }

                    }

                }

                BoxShadow {
                    anchors.fill: parent
                    shadowBlur: 6
                    shadowColor: Qt.rgba(0, 0, 0, 0.2)
                    shadowOffsetX: 0
                    shadowOffsetY: 1
                    cornerRadius: parent.radius
                    hollow: true
                }

            }

        }

    }

    dynamicLists: ListModel {
    }

}
