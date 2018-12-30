import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page
{
    id: translatorpage
    focus: true
    backNavigation: !settings.isRunning
    showNavigationIndicator: !settings.isRunning
    BusyState { id: busyindicator }

    Keys.onPressed: {
        handleKeyPressed(event);
    }

    function handleKeyPressed(event) {

        if (event.key === Qt.Key_Down) {
            flickable.flick(0, - translatorpage.height);
            event.accepted = true;
        }

        if (event.key === Qt.Key_Up) {
            flickable.flick(0, translatorpage.height);
            event.accepted = true;
        }

        if (event.key === Qt.Key_PageDown) {
            flickable.scrollToBottom();
            event.accepted = true;
        }

        if (event.key === Qt.Key_PageUp) {
            flickable.scrollToTop();
            event.accepted = true;
        }

        if (event.key === Qt.Key_B) {
            pageStack.navigateBack();
            event.accepted = true;
        }

        if (event.key === Qt.Key_H) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("MainPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_O) {
            pageStack.push(Qt.resolvedUrl("OptionsPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_G) {
            pageStack.push(Qt.resolvedUrl("GuidePage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_A) {
            pageStack.push(Qt.resolvedUrl("AboutPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_W) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("WelcomePage.qml"));
            event.accepted = true;
        }
    }

    SilicaFlickable
    {
        id: flickable
        anchors.fill: parent
        contentHeight: content.height
        enabled: !settings.isRunning
        opacity: settings.isRunning ? 0.2 : 1.0

        VerticalScrollDecorator { }

        Column
        {
            id: content
            width: parent.width

            PageHeader { title: qsTr("Translations") }

            Grid {
                width: parent.width
                columns: isLandscape ? 2 : 1

            Column
            {
                width: isLandscape ? parent.width/2 : parent.width

                AboutLanguage { text: "Deutsch" }
                AboutTranslator { text: "Sailfishman" }
                AboutTranslator { text: "mosen" }
                Item { width: parent.width; height: Theme.paddingLarge }

                AboutLanguage { text: "Español" }
                AboutTranslator { text: "mad_soft" }
                Item { width: parent.width; height: Theme.paddingLarge }

                AboutLanguage { text: "Español (España)" }
                AboutTranslator { text: "mad_soft" }
                Item { width: parent.width; height: Theme.paddingLarge }

                AboutLanguage { text: "Français" }
                AboutTranslator { text: "Ohaneje Emeka" }
                AboutTranslator { text: "Cédric Heintz" }
                Item { width: parent.width; height: Theme.paddingLarge }

                AboutLanguage { text: "Italiano" }
                AboutTranslator { text: "Francesco Vaccaro" }
                Item { width: parent.width; height: Theme.paddingLarge }

                AboutLanguage { text: "Magyar" }
                AboutTranslator { text: "Szabó G." }
                Item { width: parent.width; height: Theme.paddingLarge }

        }

        Column
        {
            width: isLandscape ? parent.width/2 : parent.width

            AboutLanguage { text: "Nederlands" }
            AboutTranslator { text: "Nathan Follens" }
            Item { width: parent.width; height: Theme.paddingLarge }

            AboutLanguage { text: "Neerlandais (Belgique)" }
            AboutTranslator { text: "Nathan Follens" }
            Item { width: parent.width; height: Theme.paddingLarge }

              AboutLanguage { text: "Polski" }
              AboutTranslator { text: "Tomasz Amborski" }
              Item { width: parent.width; height: Theme.paddingLarge }

              AboutLanguage { text: "Svenska" }
              AboutTranslator { text: "Åke Engelbrektson" }
              Item { width: parent.width; height: Theme.paddingLarge }

              AboutLanguage { text: "Zhōngwén (Chinese)" }
              AboutTranslator { text: "rui kon" }
              Item { width: parent.width; height: Theme.paddingLarge }

              LabelText {
                  text: qsTr("Request a new language or contribute to existing languages on the Transifex project page.")
              }

              Button {
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Transifex")
                  onClicked: Qt.openUrlExternally("https://www.transifex.com/fravaccaro/ui-themer")
              }

        }
    } // grid

              Item {
                  width: 1
                  height: Theme.paddingLarge
              }
        }

    }
}
