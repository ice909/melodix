import "../../util"
import "../widgets"
import Melodix.API 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    id: root

    property bool loading: true
    property int userLevel: 0
    property string musicianPic: ""
    property string musicianDesc: ""
    property int followsCount: 0
    property int followedsCount: 0

    Component.onCompleted: API.getUserDetail(userID)

    Connections {
        function onUserDetailCompleted(data) {
            userLevel = data.level;
            musicianPic = data.identify.imageUrl
            musicianDesc = data.identify.imageDesc
            followsCount = data.profile.follows
            followedsCount = data.profile.followeds
            loading = false;
        }

        target: API
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        contentHeight: 100

        Column {
            id: body

            spacing: 10
            x: Util.pageLeftPadding
            y: 5

            Row {
                spacing: 20

                Item {
                    width: 20
                    height: 1
                }

                RoundedImage {
                    id: avatarImg

                    width: scrollWidth * 0.25
                    height: width
                    borderRadius: width
                    imgSrc: userAvatar
                }

                Item {
                    width: scrollWidth - avatarImg.width - 40
                    height: parent.height

                    Column {
                        anchors.fill: parent

                        Item {
                            width: 1
                            height: 10
                        }

                        Item {
                            width: parent.width
                            height: 40

                            Row {
                                spacing: 20
                                anchors.fill: parent

                                TextInput {
                                    id: usernameInput

                                    readOnly: true
                                    text: userNickname
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 26
                                    font.bold: true
                                    visible: true
                                }

                                TextField {
                                    id: editInput

                                    visible: false
                                    selectByMouse: true
                                    width: usernameInput.width
                                    height: usernameInput.height
                                    font.pixelSize: 20
                                    font.bold: true
                                    onAccepted: {
                                        editInput.visible = false;
                                        usernameInput.visible = true;
                                    }
                                }
                                // 右边需要一个编辑用户名按钮

                                Button {
                                    id: editUsernameBtn

                                    width: 50
                                    height: 30
                                    text: "编辑"
                                    font.pixelSize: 14
                                    anchors.verticalCenter: parent.verticalCenter
                                    ColorSelector.family: Palette.CrystalColor
                                    onClicked: {
                                        if (usernameInput.visible) {
                                            text = "保存";
                                            editInput.text = usernameInput.text;
                                            editInput.visible = true;
                                            usernameInput.visible = false;
                                            editInput.forceActiveFocus();
                                        } else {
                                            text = "编辑";
                                            usernameInput.text = editInput.text;
                                            editInput.visible = false;
                                            usernameInput.visible = true;
                                        }
                                    }
                                }

                            }

                        }

                        Item {
                            width: parent.width
                            height: 40

                            Row {
                                spacing: 10
                                anchors.fill: parent

                                Image {
                                    width: 50
                                    height: 20
                                    source: "qrc:/dsg/img/svip6.png"
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                Rectangle {
                                    width: 190
                                    height: 20
                                    color: "transparent"
                                    visible: musicianPic !== ""
                                    anchors.verticalCenter: parent.verticalCenter
                                    Row {
                                        anchors.fill: parent
                                        spacing: 5

                                        Image {
                                            width: 20
                                            height: 20
                                            source: musicianPic
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        Text {
                                            color: "#e03a24"
                                            text: musicianDesc
                                            font.pixelSize: 12
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                    }
                                }

                                Rectangle {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 40
                                    height: 20
                                    radius: 10

                                    border {
                                        width: 1
                                        color: "#e03a24"
                                    }

                                    Text {
                                        anchors.centerIn: parent
                                        text: "Lv." + userLevel
                                        font.pixelSize: 12
                                        color: "#e03a24"
                                    }

                                }

                                Rectangle {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 25
                                    height: 25
                                    radius: 25
                                    color: userGender == 1 ? "#eaf4ff" : "#fde5ed"

                                    Image {
                                        anchors.centerIn: parent
                                        width: 20
                                        height: 20
                                        source: userGender == 1 ? "qrc:/dsg/img/man.svg" : "qrc:/dsg/img/women.svg"
                                    }

                                }

                            }

                        }

                        Item {
                            width: parent.width
                            height: 60
                            Row {
                                anchors.fill: parent
                                spacing: 20

                                Text {
                                    text: "关注 " + followsCount
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#000"
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {
                                    text: "粉丝 " + followedsCount
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#000"
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }

                        Item {
                            width: parent.width
                            height: 40

                            Row {
                                anchors.fill: parent
                                spacing: 20
                                Text {
                                    text: "地区: " + Util.getProvince(userProvince) + " " + Util.getCity(userCity)
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }

                    }

                }

            }

        }

    }

    Rectangle {
        visible: loading
        anchors.fill: root
        color: Util.pageBackgroundColor

        Loading {
            anchors.centerIn: parent
        }

    }

}
