import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
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

    ThemePack { id: themepack }
    property bool vIM: themepack.hasImageMagickInstalled()

    initialPage: (settings.wizardDone && vIM ) ? mainpage : welcomepage
    cover: (settings.coverAction1 !== 3 && settings.coverAction2 !== 3) ? Qt.resolvedUrl("cover/CoverPage2.qml") : Qt.resolvedUrl("cover/CoverPage1.qml")

    allowedOrientations: defaultAllowedOrientations
    _defaultPageOrientations: defaultAllowedOrientations

    Settings { id: settings }
}
