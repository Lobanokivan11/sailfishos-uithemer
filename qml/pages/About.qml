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
                title: qsTr("About")
            }
            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("With UI Themer you can customize icons, fonts and pixel density in Sailfish OS. Remember to unapply themes before system updates.")
            }

            Placeholder { }

            Button {
                width: Theme.buttonWidthLarge
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Page on OpenRepos")
                onClicked: {
                    Qt.openUrlExternally("https://openrepos.net/content/fravaccaro/ui-themer")
                }
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
                width: Theme.buttonWidthLarge
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Sources on GitHub")
                onClicked: {
                    Qt.openUrlExternally("https://github.com/fravaccaro/sailfishos-uithemer")
                }
            }

            Placeholder { }

            FLabel {
                  text: qsTr("CLI tool")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  text: qsTr("If anything goes wrong or you want to manage all the options via terminal, you can recall the CLI tool by typing <b>themepacksupport</b> as root.")
              }

              Placeholder { }

              FLabel {
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
                  width: Theme.buttonWidthLarge
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Documentation")
                  onClicked: {
                      Qt.openUrlExternally("https://fravaccaro.github.io/themepacksupport-sailfishos/docs/getstarted.html")
                  }
              }

              Placeholder { }

              FLabel {
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
                  width: Theme.buttonWidthLarge
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Issues on GitHub")
                  onClicked: {
                      Qt.openUrlExternally("https://github.com/fravaccaro/sailfishos-uithemer/issues")
                  }
              }

              Placeholder { }

              PageHeader {
                  title: qsTr("Support")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  text: qsTr("If you like my work and want to buy me a beer, feel free to do it!")
              }

              Placeholder { }

              Button {
                  width: Theme.buttonWidthLarge
                  anchors.horizontalCenter: parent.horizontalCenter
                  text: qsTr("Donate")
                  onClicked: {
                      Qt.openUrlExternally("https://www.paypal.me/fravaccaro")
                  }
              }

              Placeholder { }

              PageHeader {
                  title: qsTr("Credits")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  onLinkActivated: Qt.openUrlExternally(link)
                  text: qsTr("Part of this app is based on the <a href='https://github.com/RikudouSage/sailfish-iconpacksupport-gui'>Icon pack support GUI</a> by RikudouSennin.<br>App icon design by <a href='http://www.freepik.com/free-photo/blue-paint-roller_959191.htm'>Freepik</a>.<br>Thanks to Dax89 and all the testers for help and patience.")
               }

              Placeholder { }

              PageHeader {
                  title: qsTr("Translations")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  text: qsTr("Italian")+": fravaccaro\n"+qsTr("Polish")+": Tomasz Amborski"
              }

              Placeholder { }

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
                  width: Theme.buttonWidthLarge
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
