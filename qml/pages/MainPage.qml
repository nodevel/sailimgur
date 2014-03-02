import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components/imgur.js" as Imgur

Page {
    id: mainPage;
    allowedOrientations: Orientation.All;

    property bool prevEnabled : page > 0;
    property string searchModeText : "";

    property alias contentItem: flickable;

    Connections {
        target: settings;
        onSettingsLoaded: {
            galleryModel.clear();

            Imgur.init(constant.clientId, constant.clientSecret, settings.accessToken, settings.refreshToken, constant.userAgent);
            if (settings.accessToken === "" || settings.refreshToken === "") {
                loggedIn = false;
                console.log("Not signed in. Using anonymous mode.");
                infoBanner.showText(qsTr("Not signed in. Using anonymous mode."));
                settings.user = "anonymous";
                galleryModel.processGalleryMode();
            } else {
                loggedIn = true;
                Imgur.getAccountCurrent(function(url) {
                    settings.user = url;
                    galleryModel.processGalleryMode();
                }, function(status, statusText){
                    if (status === 403) {
                        console.log("Permission denied. Trying to refresh tokens.");
                        Imgur.refreshAccessToken(settings.refreshToken, function(access_token, refresh_token){
                            settings.accessToken = access_token;
                            settings.refreshToken = refresh_token;
                            settings.saveTokens();

                            // retry the api call
                            Imgur.getAccountCurrent(function(url) {
                                settings.user = url;
                                galleryModel.processGalleryMode();
                            }, function(status, statusText) {
                                infoBanner.showHttpError(status, statusText);
                                loadingRect.visible = false;
                            });
                        }, function(status, statusText) {
                            loggedIn = false;
                            infoBanner.showHttpError(status, statusText + ". Can't refresh tokens. Please sign in.");
                            loadingRect.visible = false;
                        });
                    } else {
                        infoBanner.showHttpError(status, statusText);
                        loadingRect.visible = false;
                    };
                });
            }
        }
    }

    SilicaFlickable {
        id: flickable;
        interactive: !galgrid.flicking;
        pressDelay: 0;
        z: -2;

        PageHeader { id: header; title: constant.appName; }

        PullDownMenu {
            id: pullDownMenu;

            MenuItem {
                id: aboutMenu;
                text: qsTr("About");
                onClicked: {
                    aboutPage.load();
                    pageStack.push(aboutPage);
                }
            }

            MenuItem {
                id: settingsMenu;
                text: qsTr("Settings");
                onClicked: {
                    pageStack.push(settingsPage);
                }
            }

            SearchField {
                id: searchTextField;

                width: parent.width;
                font.pixelSize: constant.fontSizeSmall;
                font.bold: false;
                placeholderText: qsTr("Search...");

                EnterKey.enabled: text.trim().length > 0;
                EnterKey.iconSource: "image://theme/icon-m-enter-accept";
                EnterKey.onClicked: {
                    //console.log("Searched: " + query);
                    searchModeText = "Results for \"" + text + "\"";
                    galleryModel.clear();
                    galleryModel.processGalleryMode(searchTextField.text);
                    pullDownMenu.close();
                    searchTextField.focus = false;
                }
            }

        } // Pulldown menu

        PushUpMenu {
            id: pushUpMenu;

            MenuItem {
                ListItem {
                    id: navigation;

                    Label {
                        id: prev;
                        text: qsTr("« Previous");
                        font.pixelSize: constant.fontSizeSmall;

                        anchors.left: parent.left;
                        anchors.leftMargin: constant.paddingMedium;

                        MouseArea {
                            anchors.fill: parent;
                            onClicked: {
                                if (page > 0) {
                                    page -= 1;
                                }
                                //console.log("Previous clicked!: " + page);
                                galleryModel.processGalleryMode(searchTextField.text);
                                if (page == 0) {
                                    prevEnabled = false;
                                }
                                pushUpMenu.close();
                                galgrid.scrollToTop();
                            }
                        }
                        enabled: prevEnabled;
                        visible: prevEnabled;
                    }

                    Label {
                        id: next;
                        text: qsTr("Next »");
                        font.pixelSize: constant.fontSizeSmall;

                        anchors.right: parent.right;
                        anchors.rightMargin: constant.paddingMedium;

                        MouseArea {
                            anchors.fill: parent;
                            onClicked: {
                                page += 1;
                                //console.log("Next clicked!: " + page);
                                galleryModel.processGalleryMode(searchTextField.text);
                                prevEnabled = true;
                                pushUpMenu.close();
                                galgrid.scrollToTop();
                            }
                        }
                    }
                } // ListItem
            }
        } // Pushup menu

        anchors.fill: parent;

        GalleryMode { id: galleryMode; }

        SilicaGridView {
            id: galgrid;

            cellWidth: (deviceOrientation === Orientation.Landscape || deviceOrientation === Orientation.LandscapeInverted) ? width / 5 : width / 3;
            cellHeight: 175;
            clip: true;

            model: galleryModel;

            anchors { top: galleryMode.bottom; left: parent.left; right: parent.right; bottom: parent.bottom; }
            anchors.leftMargin: constant.paddingMedium;
            anchors.rightMargin: constant.paddingMedium;

            delegate: Loader {
                sourceComponent: GalleryDelegate { id: galleryDelegate; }
            }

            VerticalScrollDecorator { flickable: galgrid; }

            Timer {
                id: idle;
                property bool moving: galgrid.moving || galgrid.dragging || galgrid.flicking;
                property bool menuOpen: pullDownMenu.active || pushUpMenu.active;
                onMovingChanged: if (!moving && !menuOpen) restart();
                interval: galgrid.atYBeginning || galgrid.atYEnd ? 300 : 2000;
            }

            Rectangle {
                visible: opacity > 0;
                width: 64;
                height: 64;
                anchors { top: parent.top; right: parent.right; margins: Theme.paddingLarge; }
                radius: 75;
                color: Theme.highlightBackgroundColor;
                opacity: (idle.moving || idle.running) && !idle.menuOpen ? 1 : 0;
                Behavior on opacity { FadeAnimation { duration: 300; } }

                IconButton {
                    anchors.centerIn: parent;
                    icon.source: "image://theme/icon-l-up";
                    onClicked: {
                        galgrid.cancelFlick();
                        galgrid.positionViewAtBeginning();
                    }
                }
            }

            Rectangle {
                visible: opacity > 0;
                width: 64;
                height: 64;
                anchors { bottom: parent.bottom; right: parent.right; margins: Theme.paddingLarge; }
                radius: 75;
                color: Theme.highlightBackgroundColor;
                opacity: (idle.moving || idle.running) && !idle.menuOpen ? 1 : 0;
                Behavior on opacity { FadeAnimation { duration: 300; } }

                IconButton {
                    anchors.centerIn: parent;
                    icon.source: "image://theme/icon-l-down";
                    onClicked: {
                        galgrid.cancelFlick();
                        galgrid.positionViewAtEnd();
                    }
                }
            }
        } // SilicaGridView
    }

    Component.onCompleted: {
        galleryModel.clear();
    }

}
