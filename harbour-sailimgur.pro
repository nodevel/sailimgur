TARGET = harbour-sailimgur

# Application version
DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += APP_RELEASE=\\\"$$RELEASE\\\"

# Qt Library
QT += svg network

CONFIG += sailfishapp

HEADERS += \
    src/imageuploader.h

SOURCES += main.cpp \
    src/imageuploader.cpp

OTHER_FILES = \
    rpm/harbour-sailimgur.changes \
    rpm/harbour-sailimgur.spec \
    rpm/harbour-sailimgur.yaml \
    harbour-sailimgur.desktop \
    qml/main.qml \
    qml/cover/CoverPage.qml \
    qml/pages/Settings.qml \
    qml/pages/Constant.qml \
    qml/components/imgur.js \
    qml/pages/SettingsPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/MainPage.qml \
    qml/pages/CommentDelegate.qml \
    qml/pages/GalleryDelegate.qml \
    qml/pages/ImageButtons.qml \
    qml/pages/ImageContextMenu.qml \
    qml/pages/SignInPage.qml \
    qml/components/storage.js \
    qml/components/utils.js \
    qml/pages/GalleryNavigation.qml \
    qml/pages/GalleryContentPage.qml \
    qml/pages/GalleryContentDelegate.qml \
    qml/pages/GalleryMode.qml \
    qml/pages/CommentsModel.qml \
    qml/pages/GalleryModel.qml \
    qml/pages/GalleryContentModel.qml \
    qml/pages/PanelView.qml \
    qml/pages/Panel.qml \
    qml/pages/AccountPanel.qml \
    qml/pages/UploadPage.qml \
    qml/pages/GalleryContentLink.qml \
    qml/pages/WebPage.qml \
    qml/pages/AlbumInfoColumn.qml \
    qml/components/imgur_oauth.js \
    qml/pages/UploadedPage.qml \
    qml/pages/UploadedModel.qml \
    qml/pages/UploadedContextMenu.qml \
    qml/pages/UploadedDelegate.qml

INCLUDEPATH += $$PWD
