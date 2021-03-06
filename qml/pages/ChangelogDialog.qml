import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: root;
    allowedOrientations: Orientation.All;

    SilicaFlickable {
        id: flickable;

        anchors.fill: parent;

        contentHeight: contentArea.height;

        DialogHeader {
            id: header;
            title: qsTr("Changelog");
            acceptText: qsTr("Close");
        }

        Column {
            id: contentArea;
            anchors { top: header.bottom; left: parent.left; right: parent.right; }
            height: childrenRect.height;

            anchors.margins: Theme.paddingSmall;
            spacing: Theme.paddingSmall;

            SectionHeader { text: qsTr("Version") + " 0.7 (2014-11-27)" }

            Column {
                anchors { left: parent.left; right: parent.right; }
                width: parent.width;
                height: childrenRect.height;

                spacing: constant.paddingSmall;

                Label {
                    width: parent.width;
                    wrapMode: Text.Wrap;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    text: qsTr("Use toolbar instead of sidebar for functions");
                }
                Label {
                    width: parent.width;
                    wrapMode: Text.Wrap;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    text: qsTr("Account page shows user info and pages.");
                }
                Label {
                    width: parent.width;
                    wrapMode: Text.Wrap;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    text: qsTr("Image info shown on page.");
                }
                Label {
                    width: parent.width;
                    wrapMode: Text.Wrap;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    text: qsTr("Minor user interface adjustments.");
                }
            }

            SectionHeader { text: qsTr("Version") + " 0.6 (2014-11-16)" }

            Column {
                anchors { left: parent.left; right: parent.right; }
                width: parent.width;
                height: childrenRect.height;

                spacing: constant.paddingSmall;

                Label {
                    width: parent.width;
                    wrapMode: Text.Wrap;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    text: qsTr("Save image to Pictures.");
                }
                Label {
                    width: parent.width;
                    wrapMode: Text.Wrap;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    text: qsTr("Save gallery mode and sort options.");
                }
                Label {
                    width: parent.width;
                    wrapMode: Text.Wrap;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    text: qsTr("User Interface adjustments: next/previous links, image and comment actions.");
                }
                Label {
                    width: parent.width;
                    wrapMode: Text.Wrap;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    text: qsTr("Changelog shows in first start after update.");
                }
            }

            SectionHeader { text: qsTr("Version") + " 0.5.0 (2014-07-04)" }

            Column {
                anchors { left: parent.left; right: parent.right; }
                width: parent.width;
                height: childrenRect.height;

                spacing: constant.paddingSmall;

                Label {
                    width: parent.width;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    wrapMode: Text.Wrap;
                    text: qsTr("Upload feature for logged in and anonymous user.");
                }
                Label {
                    width: parent.width;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    wrapMode: Text.Wrap;
                    text: qsTr("Delete image/album from user's image/album view.");
                }
                Label {
                    width: parent.width;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    wrapMode: Text.Wrap;
                    text: qsTr("Storing uploaded image's info to database.");
                }
                Label {
                    width: parent.width;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    wrapMode: Text.Wrap;
                    text: qsTr("List uploaded images, open in browser, copy link or delete.");
                }
            }
        }

        VerticalScrollDecorator { flickable: flickable; }
    }

    onRejected: {
    }

    onAccepted: {
        root.backNavigation = true;
    }
}
