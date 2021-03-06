#include <sailfishapp.h>
#include <QScopedPointer>
#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QQmlContext>
#include <QtQml>

#include "src/imageuploader.h"
#include "src/sailimgur.h"

int main(int argc, char *argv[])
{

    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

    app->setApplicationName("Sailimgur");
    app->setOrganizationName("harbour-sailimgur");
    app->setApplicationVersion(APP_VERSION);

    view->rootContext()->setContextProperty("APP_VERSION", APP_VERSION);
    view->rootContext()->setContextProperty("APP_RELEASE", APP_RELEASE);

    Sailimgur mgr;
    view->rootContext()->setContextProperty("sailimgurMgr", &mgr);

    qmlRegisterType<ImageUploader>("harbour.sailimgur.Uploader", 1, 0, "ImageUploader");

    view->setSource(SailfishApp::pathTo("qml/main.qml"));
    view->show();

    return app->exec();
}
