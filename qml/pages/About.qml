import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page
    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: parent.width
            PageHeader {
                title: qsTr("About UI Themer")
            }
            
            Item {
                height: appicon.height + Theme.paddingMedium
                width: parent.width

                Image {
                    id: appicon
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "../../appinfo.png"
                }
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.highlightColor
                text: "UI Themer 0.6.6"
            }

            Placeholder { }

            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("UI Themer lets you customize icons, fonts and pixel density in Sailfish OS.")
            }

            Placeholder { }

            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Released under the GNU GPLv3 license.")
            }

            Placeholder { }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Sources")
                onClicked: {
                    Qt.openUrlExternally("https://github.com/fravaccaro/sailfishos-uithemer")
                }
            }

            Placeholder { }

            SectionHeader {
                  text: qsTr("CLI tool")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  text: qsTr("If anything goes wrong or you want to manage all the options via terminal, you can recall the CLI tool by typing <b>themepacksupport</b> as root.")
              }

              Placeholder { }

              SectionHeader {
                  text: qsTr("Developers")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  onLinkActivated: Qt.openUrlExternally(link)
                  text: qsTr("If you want to create a theme compatible with UI Themer, please read the documentation.")
               }

              Placeholder { }

              Button {
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Documentation")
                  onClicked: {
                      Qt.openUrlExternally("https://fravaccaro.github.io/themepacksupport-sailfishos/docs/getstarted.html")
                  }
              }

              Placeholder { }

              SectionHeader {
                  text: qsTr("Feedback")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  onLinkActivated: Qt.openUrlExternally(link)
                  text: qsTr("If you want to provide feedback or report an issue, please use GitHub.")
               }

              Placeholder { }

              Button {
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Issues")
                  onClicked: {
                      Qt.openUrlExternally("https://github.com/fravaccaro/sailfishos-uithemer/issues")
                  }
              }

              Placeholder { }

              SectionHeader {
                  text: qsTr("Support")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  text: qsTr("If you like my work and want to buy me a beer, feel free to do it!")
              }

              Placeholder { }

              Button {
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Donate")
                  onClicked: {
                      Qt.openUrlExternally("https://www.paypal.me/fravaccaro")
                  }
              }

              Placeholder { }

              SectionHeader {
                  text: qsTr("Credits")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  onLinkActivated: Qt.openUrlExternally(link)
                  text: qsTr("Part of this app is based on the <a href='https://github.com/RikudouSage/sailfish-iconpacksupport-gui'>Icon pack support GUI</a> by RikudouSennin.<br><br>App icon designed by <a href='http://www.freepik.com/free-photo/blue-paint-roller_959191.htm'>D3Images/Freepik</a>.<br><br>Thanks to Dax89 and all the testers for help and patience.")
               }

              Placeholder { }

              SectionHeader {
                  text: qsTr("Translations")
              }

              AboutLanguage {
	              text: "Deutsch"
              }

              AboutTranslator {
              	text: "Sailfishman"
              }
              AboutTranslator {
              	text: "mosen"
              }

              Placeholder {}

              AboutLanguage {
                  text: "Español"
              }

              AboutTranslator {
                text: "mad_soft"
              }

              Placeholder {}

              AboutLanguage {
                  text: "Español (España)"
              }

              AboutTranslator {
                text: "mad_soft"
              }

              Placeholder {}

              AboutLanguage {
                  text: "Français"
              }

              AboutTranslator {
                text: "Ohaneje Emeka"
              }
              AboutTranslator {
                text: "Cédric Heintz"
              }

              Placeholder {}

              AboutLanguage {
	              text: "Italiano"
              }

              AboutTranslator {
              	text: "Francesco Vaccaro"
              }

              Placeholder {}

              AboutLanguage {
	              text: "Nederlands"
              }

              AboutTranslator {
              	text: "Nathan Follens"
              }

              Placeholder {}

              AboutLanguage {
	              text: "Polski"
              }

              AboutTranslator {
	              text: "Tomasz Amborski"
              }

              Placeholder {}

              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  onLinkActivated: Qt.openUrlExternally(link)
                  text: qsTr("Request a new language or contribute to existing languages on the Transifex project page.")
               }

              Placeholder { }

              Button {
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Transifex")
                  onClicked: {
                      Qt.openUrlExternally("https://www.transifex.com/fravaccaro/ui-themer")
                  }
              }

              Placeholder { }

        }
        VerticalScrollDecorator {}
    }
}
