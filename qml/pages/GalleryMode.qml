import QtQuick 2.0
import Sailfish.Silica 1.0

Row {
    id: root;
    anchors { left: parent.left; right: parent.right; }
    width: parent.width;

    spacing: Theme.paddingSmall;

    Connections {
        target: settings;

        onSettingsLoaded: {
            switch (settings.mode) {
                case constant.mode_main:
                    modeBox.currentIndex = 0;
                    settings.section = "hot";
                    break;
                case constant.mode_user:
                    modeBox.currentIndex = 1;
                    settings.section = constant.mode_user;
                    break;
                case constant.mode_random:
                    modeBox.currentIndex = 2;
                    break;
                case constant.mode_score:
                    modeBox.currentIndex = 3;
                    settings.section = "top";
                    break;
                case constant.mode_memes:
                    modeBox.currentIndex = 4;
                    break;
                default:
                    modeBox.currentIndex = 0;
            }

            switch (settings.sort) {
                case "viral":
                    sortBox.currentIndex = 0;
                    break;
                case "time":
                    sortBox.currentIndex = 1;
                    break;
                default:
                    sortBox.currentIndex = 0;
            }
        }
    }

    Label {
        id: accountModeLabel;
        width: parent.width;
        height: Theme.itemSizeSmall;
        text:
            settings.mode === constant.mode_favorites ?
                qsTr("Your favorite images") : (
                    settings.mode === constant.mode_albums ? qsTr("Your albums") : (
                            settings.mode === constant.mode_images) ? qsTr("Your images") : ""
                    );
        font.pixelSize: constant.fontSizeMedium;
        color: constant.colorHighlight;
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        visible: settings.mode === constant.mode_favorites || settings.mode === constant.mode_albums || settings.mode === constant.mode_images;
    }

    ComboBox {
        id: modeBox;
        currentIndex: 0;
        width: parent.width / 2;
        visible: accountModeLabel.visible == false && galleryModel.query === "";

        menu: ContextMenu {
            MenuItem {
                id: mainMode;
                text: qsTr("most viral");
                onClicked: {
                    sortBox.visible = true;
                    settings.mode = constant.mode_main;
                    settings.section = "hot";

                    internal.setModeCommon();
                }
            }

            MenuItem {
                id: userMode;
                text: qsTr("user submitted");
                onClicked: {
                    sortBox.visible = true;
                    settings.mode = constant.mode_user;
                    settings.section = constant.mode_user;

                    internal.setModeCommon();
                }
            }

            MenuItem {
                id: randomMode;
                text: qsTr("random");
                onClicked: {
                    sortBox.visible = false;
                    settings.mode = constant.mode_random;

                    internal.setModeCommon();
                }
            }

            MenuItem {
                id: scoreMode;
                text: qsTr("highest scoring");
                onClicked: {
                    sortBox.visible = false;
                    settings.mode = constant.mode_score;
                    settings.section = "top";

                    internal.setModeCommon();
                }
            }

            MenuItem {
                id: memesMode;
                text: qsTr("memes");
                onClicked: {
                    sortBox.visible = true;
                    settings.mode = constant.mode_memes;

                    internal.setModeCommon();
                }
            }
        }
    }

    ComboBox {
        id: sortBox;
        width: parent.width / 2;
        currentIndex: 0;
        label: qsTr("sort:");
        visible: accountModeLabel.visible == false;

        menu: ContextMenu {
            MenuItem {
                id: viralSort;
                text: qsTr("popularity");
                onClicked: {
                    settings.sort = "viral";
                    internal.setSortCommon();
                }
            }

            MenuItem {
                id: newestSort;
                text: qsTr("newest");
                onClicked: {
                    settings.sort = "time";
                    internal.setSortCommon();
                }
            }
        }
    }

    QtObject {
        id: internal;

        function setModeCommon() {
            settings.saveSetting("mode", settings.mode);
            galleryModel.query = "";
            toolbar.searchVisible = false;
            galgrid.scrollToTop();
            galleryModel.clear();
            galleryModel.processGalleryMode();
        }

        function setSortCommon() {
            settings.saveSetting("sort", settings.sort);
            galgrid.scrollToTop();
            galleryModel.clear();
            galleryModel.processGalleryMode(galleryModel.query);
        }
    }

}
