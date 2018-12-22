import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import "pages"
import "common"
import org.nemomobile.configuration 1.0

ApplicationWindow
{
    Component {
        id: mainpage
        MainPage {}
    }

    Component {
        id: welcomepage
        WelcomePage {}
}

    ConfigurationGroup {
        id: conf
        path: "/desktop/lipstick/sailfishos-uithemer"
        property bool wizardDone: false
        property int coverAction1: 0
    }

    ThemePack { id: themepack }
    property bool vIM: themepack.hasImageMagickInstalled()

    initialPage: (conf.wizardDone && vIM ) ? mainpage : welcomepage
    cover: switch (conf.coverAction1) {
           case 0:
               return Qt.resolvedUrl("cover/CoverPageRefresh.qml");
           case 1:
               return Qt.resolvedUrl("cover/CoverPageRestart.qml");
           case 2:
               return Qt.resolvedUrl("cover/CoverPageOcr.qml");
           case 3:
               return Qt.resolvedUrl("cover/CoverPage.qml");
           }
    allowedOrientations: defaultAllowedOrientations
    _defaultPageOrientations: defaultAllowedOrientations

    Settings { id: settings }
}
