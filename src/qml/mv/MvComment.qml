import "../../util"
import "../widgets"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root
    property alias lists: repeater.model

    Column {
        spacing: 5

        Repeater {
            id: repeater

            Item {
                id: commentItemRect

                width: scrollWidth
                height: 72

                Row {
                    anchors.fill: parent
                    spacing: 10

                    Item {
                        width: parent.height - 10
                        height: width
                        anchors.verticalCenter: parent.verticalCenter

                        RoundedImage {
                            id: commentsUserId

                            anchors.fill: parent
                            imgSrc: modelData.user.avatarUrl
                            borderRadius: width
                            anchors.verticalCenter: parent.verticalCenter
                        }

                    }

                    Item {
                        width: parent.width - commentsUserId.width - 10
                        height: parent.height

                        Column {
                            spacing: 0
                            anchors.fill: parent

                            Item {
                                width: parent.width
                                height: 20

                                Text {
                                    id: commentsUserNickName

                                    font.pixelSize: DTK.fontManager.t8.pixelSize
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.bold: true
                                    color: palette.highlight
                                    text: modelData.user.nickname + ": "
                                }

                            }

                            Item {
                                width: parent.width - 50
                                height: 40

                                Label {
                                    id: commentsUserContent

                                    font.pixelSize: DTK.fontManager.t9.pixelSize
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.bold: true
                                    width: parent.width
                                    height: 35
                                    wrapMode: Text.Wrap
                                    elide: Text.ElideRight
                                    maximumLineCount: 2
                                    text: modelData.content
                                    color: Util.textColor
                                }

                            }

                            Item {
                                width: parent.width
                                height: 10

                                Text {
                                    id: commentReleaseTime

                                    font.pixelSize: DTK.fontManager.t10.pixelSize
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: modelData.timeStr
                                    color: Util.textColor
                                }

                            }

                        }

                    }

                }

                Rectangle {
                    anchors.top: parent.bottom
                    width: parent.width
                    height: 0.5
                    color: "#000000"
                }

            }

        }

    }

}
