import QtQuick 2.0
import Sailfish.Silica 1.0
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
    }

    initialPage: conf.wizardDone ? mainpage : welcomepage
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
    _defaultPageOrientations: defaultAllowedOrientations

    Settings { id: settings }
}
