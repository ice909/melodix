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
                                        
                                        editInput.visible = false
                                        usernameInput.visible = true
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
                                            text = "保存"
                                            editInput.text = usernameInput.text
                                            editInput.visible = true
                                            usernameInput.visible = false
                                            editInput.forceActiveFocus()
                                        }else {
                                            text = "编辑"
                                            usernameInput.text = editInput.text
                                            editInput.visible = false
                                            usernameInput.visible = true
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }

    }
}