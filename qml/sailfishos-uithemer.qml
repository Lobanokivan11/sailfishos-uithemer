import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import "pages"
import "common"

ApplicationWindow
{
    id: app
    property string coverMode

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
    property bool isLightTheme: (Theme.colorScheme === Theme.LightOnDark) ? false : true

    initialPage: (settings.wizardDone && vIM ) ? mainpage : welcomepage
    cover: switch (app.coverMode) {
           case "confirmDialog":
               return Qt.resolvedUrl("cover/CoverConfirm.qml");
           default:
               return Qt.resolvedUrl("cover/CoverPage.qml")
           }

    allowedOrientations: defaultAllowedOrientations
    _defaultPageOrientations: defaultAllowedOrientations

    Settings { id: settings }
}
