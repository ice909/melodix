import "../../router"
import "../../util"
import QtQuick 2.11
import QtQuick.Controls 2.4
import org.deepin.dtk 1.0

Item {
    property ListModel lists

    Grid {
        id: gridLayout

        anchors.fill: parent
        columns: 5
        columnSpacing: 30
        rowSpacing: 30

        Repeater {
            id: repeater

            model: lists

            Item {
                width: (gridLayout.width - 30 * 4) * 0.2
                height: width + 20

                RoundedImage {
                    // 鼠标悬浮时显示播放图标
                    // Image {
                    //     id: playIcon
                    //     anchors.centerIn: parent
                    //     visible: false
                    //     width: 40
                    //     height: 40
                    //     source: "qrc:/dsg/icons/play.svg"
                    // }

                    id: img

                    width: parent.width
                    height: parent.width
                    anchors.centerIn: parent
                    imgSrc: modelData.coverImgUrl || modelData.picUrl || modelData.cover

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            //playIcon.visible = true;
                            imgShadow.visible = true;
                        }
                        onExited: {
                            //playIcon.visible = false;
                            imgShadow.visible = false;
                        }
                        onClicked: {
                            Router.showPlaylistDetail(modelData.id);
                        }
                    }

                    BoxShadow {
                        id: imgShadow

                        visible: false
                        anchors.fill: parent
                        shadowBlur: 10
                        shadowColor: palette.highlight
                        spread: 2
                        shadowOffsetX: 0
                        shadowOffsetY: 1
                        cornerRadius: 5
                        hollow: true
                    }

                }

                Item {
                    anchors.top: img.bottom
                    width: img.width
                    anchors.leftMargin: 10
                    height: 30

                    Text {
                        id: hotPlaylistTitle

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        text: modelData.name || modelData.albumName
                        elide: Qt.ElideRight
                        color: Util.textColor

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onEntered: {
                                tooltip.visible = true;
                            }
                            onExited: {
                                tooltip.visible = false;
                            }
                            onClicked: {
                                Router.showPlaylistDetail(modelData.id);
                            }
                        }

                        ToolTip {
                            id: tooltip

                            text: modelData.name
                            visible: false
                        }

                    }

                }

            }

        }

    }

    lists: ListModel {
    }

}
