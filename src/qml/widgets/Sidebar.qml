import "../../router"
import "../../util"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Item {
    property int pageSelectedIndex: 0
    property int userListViewSelectedIndex: -1
    property ListModel pageModel
    property ListModel userListViewModel

    function onThemeTypeChanged() {
        if (DTK.themeType == 2) {
            pageModel.setProperty(0, "iconName", "qrc:/dsg/icons/index-dark.svg");
            pageModel.setProperty(1, "iconName", "qrc:/dsg/icons/discover-dark.svg");
            pageModel.setProperty(2, "iconName", "qrc:/dsg/icons/library-dark.svg");
            userListViewModel.setProperty(0, "iconName", "qrc:/dsg/icons/favourite-dark.svg");
            userListViewModel.setProperty(1, "iconName", "qrc:/dsg/icons/daily-dark.svg");
        } else {
            pageModel.setProperty(0, "iconName", "qrc:/dsg/icons/index-light.svg");
            pageModel.setProperty(1, "iconName", "qrc:/dsg/icons/discover-light.svg");
            pageModel.setProperty(2, "iconName", "qrc:/dsg/icons/library-light.svg");
            userListViewModel.setProperty(0, "iconName", "qrc:/dsg/icons/favourite-light.svg");
            userListViewModel.setProperty(1, "iconName", "qrc:/dsg/icons/daily-light.svg");
        }
    }

    width: 150
    height: parent.height
    Component.onCompleted: {
        if (DTK.themeType === 2) {
            pageModel.setProperty(0, "iconName", "qrc:/dsg/icons/index-dark.svg");
            pageModel.setProperty(1, "iconName", "qrc:/dsg/icons/discover-dark.svg");
            pageModel.setProperty(2, "iconName", "qrc:/dsg/icons/library-dark.svg");
            userListViewModel.setProperty(0, "iconName", "qrc:/dsg/icons/favourite-dark.svg");
            userListViewModel.setProperty(1, "iconName", "qrc:/dsg/icons/daily-dark.svg");
        }
        DTK.themeTypeChanged.connect(onThemeTypeChanged);
    }
    Component.onDestruction: {
        DTK.themeTypeChanged.disconnect(onThemeTypeChanged);
    }

    Column {
        anchors.fill: parent
        padding: 5
        spacing: 10

        ListView {
            id: listView

            width: parent.width - 10
            height: 36 * 3 + 5 * 2
            model: pageModel
            spacing: 5

            delegate: ItemDelegate {
                width: parent.width
                height: 36
                checked: index === pageSelectedIndex
                font.pixelSize: 14
                font.bold: true
                backgroundVisible: false

                MouseArea {
                    id: mouseArea

                    acceptedButtons: Qt.LeftButton
                    anchors.fill: parent
                    onPressed: {
                        switch (index) {
                        case 0:
                            Router.showIndex();
                            pageSelectedIndex = index;
                            userListViewSelectedIndex = -1;
                            break;
                        case 1:
                            Router.showDiscover();
                            pageSelectedIndex = index;
                            userListViewSelectedIndex = -1;
                            break;
                        case 2:
                            Router.showLibrary();
                            pageSelectedIndex = index;
                            userListViewSelectedIndex = -1;
                            break;
                        }
                    }
                }

                RowLayout {
                    anchors.fill: parent

                    Image {
                        Layout.leftMargin: 10
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        source: iconName
                    }

                    Label {
                        text: _text
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                }

            }

        }

        Rectangle {
            width: parent.width - 10
            height: 2.5
            radius: 5
            visible: isLogin
            color: "#c9c9c9"
        }

        ListView {
            id: userListView

            width: parent.width - 10
            visible: isLogin
            height: 36 * 2 + 5
            model: userListViewModel
            spacing: 5

            delegate: ItemDelegate {
                width: parent.width
                height: 36
                checked: index === userListViewSelectedIndex
                font.pixelSize: 14
                font.bold: true
                backgroundVisible: false

                MouseArea {
                    id: mouseArea

                    acceptedButtons: Qt.LeftButton
                    anchors.fill: parent
                    onPressed: {
                        switch (index) {
                        case 0:
                            Router.showFavorite(userFavoritePlaylistId, userFavoriteSongsID.length);
                            pageSelectedIndex = -1;
                            userListViewSelectedIndex = index;
                            break;
                        case 1:
                            Router.showDaily();
                            pageSelectedIndex = -1;
                            userListViewSelectedIndex = index;
                            break;
                        }
                    }
                }

                RowLayout {
                    anchors.fill: parent

                    Image {
                        Layout.leftMargin: 10
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        source: iconName
                    }

                    Label {
                        text: _text
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                }

            }

        }

    }

    Connections {
        function onSignalBack() {
            switch (Router.routeCurrent.path) {
            case "index":
                pageSelectedIndex = 0;
                userListViewSelectedIndex = -1;
                break;
            case "discover":
                pageSelectedIndex = 1;
                userListViewSelectedIndex = -1;
                break;
            case "library":
                pageSelectedIndex = 2;
                userListViewSelectedIndex = -1;
                break;
            case "favourite":
                pageSelectedIndex = -1;
                userListViewSelectedIndex = 0;
                break;
            case "daily":
                pageSelectedIndex = -1;
                userListViewSelectedIndex = 1;
                break;
            }
        }

        target: Router
    }

    pageModel: ListModel {
        ListElement {
            iconName: "qrc:/dsg/icons/index-light.svg"
            _text: "首页"
        }

        ListElement {
            iconName: "qrc:/dsg/icons/discover-light.svg"
            _text: "发现"
        }

        ListElement {
            iconName: "qrc:/dsg/icons/library-light.svg"
            _text: "音乐库"
        }

    }

    userListViewModel: ListModel {
        ListElement {
            iconName: "qrc:/dsg/icons/favourite-light.svg"
            _text: "我喜欢的音乐"
        }

        ListElement {
            iconName: "qrc:/dsg/icons/daily-light.svg"
            _text: "每日推荐"
        }

    }

}
