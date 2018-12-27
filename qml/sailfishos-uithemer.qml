import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import org.nemomobile.configuration 1.0
import "pages"
import "common"

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
        property int coverAction2: 3
    }

    ThemePack { id: themepack }
    property bool vIM: themepack.hasImageMagickInstalled()

    initialPage: (conf.wizardDone && vIM ) ? mainpage : welcomepage
    cover: (conf.coverAction1 !== 3 && conf.coverAction2 !== 3) ? Qt.resolvedUrl("cover/CoverPage2.qml") : Qt.resolvedUrl("cover/CoverPage1.qml")

    allowedOrientations: defaultAllowedOrientations
    _defaultPageOrientations: defaultAllowedOrientations

    Settings { id: settings }
}
