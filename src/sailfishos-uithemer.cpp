#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <sys/types.h>
#include <unistd.h>
#include <QDebug>
#include <QObject>
#include <QString>
#include <QQuickView>
#include <QQmlContext>
#include <QGuiApplication>
#include <QFileSystemWatcher>
#include "iconpack.h"

int main(int argc, char *argv[]) {
    qDebug() << setuid(0);
    IconPack iconpack;
    QGuiApplication *app = SailfishApp::application(argc,argv);
    QQuickView *view = SailfishApp::createView();
    QString qml = QString("qml/sailfishos-uithemer.qml");
    view->rootContext()->setContextProperty("ip",&iconpack);
    view->rootContext()->setContextProperty("iconpack",&iconpack);
    view->setSource(SailfishApp::pathTo(qml));
    view->show();
    return app->exec();
}
