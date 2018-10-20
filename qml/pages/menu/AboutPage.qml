import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../components"

Page
{
    id: aboutpage

    SilicaFlickable
    {
        anchors.fill: parent
        anchors.bottomMargin: Theme.paddingLarge
        contentHeight: content.height

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader { title: qsTr("About UI Themer") }

            Item {
                height: appicon.height + Theme.paddingMedium
                width: parent.width

                Image { id: appicon; anchors.horizontalCenter: parent.horizontalCenter; source: "../../../appinfo.png" }
            }

            Label { anchors.horizontalCenter: parent.horizontalCenter; color: Theme.highlightColor; text: "UI Themer 1.1.0" }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("UI Themer lets you customize icons, fonts and pixel density in Sailfish OS.")
            }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Released under the GNU GPLv3 license.")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Sources")
                onClicked: Qt.openUrlExternally("https://fravaccaro.github.io/sailfishos-uithemer/")
            }

            SectionHeader { text: qsTr("Developers") }

              Label {
                  x: Theme.paddingLarge
                  width: parent.width - (x * 2)
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  text: qsTr("If you want to create a theme compatible with UI Themer, please read the documentation.")
               }

              Button {
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Documentation")
                  onClicked: Qt.openUrlExternally("https://fravaccaro.github.io/themepacksupport-sailfishos/docs/getstarted.html")
              }

              SectionHeader { text: qsTr("Feedback") }

              Label {
                  x: Theme.paddingLarge
                  width: parent.width - (x * 2)
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  text: qsTr("If you want to provide feedback or report an issue, please use GitHub.")
                  onLinkActivated: Qt.openUrlExternally(link)
              }

              Button {
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Issues")
                  onClicked: Qt.openUrlExternally("https://github.com/fravaccaro/sailfishos-uithemer/issues")
              }

              SectionHeader { text: qsTr("Support") }

              Label {
                  x: Theme.paddingLarge
                  width: parent.width - (x * 2)
                  wrapMode: Text.Wrap
                  text: qsTr("If you like my work and want to buy me a beer, feel free to do it!")
              }

              Button {
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Donate")
                  onClicked: Qt.openUrlExternally("https://www.paypal.me/fravaccaro")
              }

              SectionHeader { text: qsTr("Credits") }

              Label {
                  x: Theme.paddingLarge
                  width: parent.width - (x * 2)
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  text: qsTr("Part of this app is based on the <a href='https://github.com/RikudouSage/sailfish-iconpacksupport-gui'>Icon pack support GUI</a> by RikudouSennin.<br><br>App icon designed by <a href='http://www.freepik.com/free-photo/blue-paint-roller_959191.htm'>D3Images/Freepik</a>.<br><br>Thanks to Dax89 and all the testers for help and patience.")
                  onLinkActivated: Qt.openUrlExternally(link)
               }

              SectionHeader { text: qsTr("Translations") }

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

              AboutLanguage { text: "Nederlands" }
              AboutTranslator { text: "Nathan Follens" }
              Item { width: parent.width; height: Theme.paddingLarge }

              AboutLanguage { text: "Neerlandais (Belgique)" }
              AboutTranslator { text: "Nathan Follens" }
              Item { width: parent.width; height: Theme.paddingLarge }

              AboutLanguage { text: "Polski" }
              AboutTranslator { text: "Tomasz Amborski" }
              Item { width: parent.width; height: Theme.paddingLarge }

              Label {
                  x: Theme.paddingLarge
                  width: parent.width - (x * 2)
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  text: qsTr("Request a new language or contribute to existing languages on the Transifex project page.")
                  onLinkActivated: Qt.openUrlExternally(link)
              }

              Button {
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Transifex")
                  onClicked: Qt.openUrlExternally("https://www.transifex.com/fravaccaro/ui-themer")
              }
        }

        VerticalScrollDecorator { }
    }
}
