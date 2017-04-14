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
                text: qsTr("With UI themer you can customize icons, fonts and pixel density in Sailfish OS. Remember to unapply themes before system updates.")
            }

            Placeholder { }

            PageHeader {
                  title: qsTr("Advanced users")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  text: qsTr("If anything goes wrong or you want to manage themes via terminal, you can recall the CLI tool by typing <i>themepacksupport</i> as root.")
              }

              Placeholder { }

              Button {
                  x: Theme.paddingLarge
                  width: parent.width - 2 * Theme.paddingLarge
                  text: qsTr("Page on OpenRepos")
                  onClicked: {
                      Qt.openUrlExternally("https://openrepos.net/content/fravaccaro/ui-themer")
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
                  text: qsTr("If you like my Theme pack support and want to buy me a beer, feel free to do it!")
              }

              Placeholder { }

              Button {
                  x: Theme.paddingLarge
                  width: parent.width - 2 * Theme.paddingLarge
                  text: qsTr("Donate")
                  onClicked: {
                      Qt.openUrlExternally("https://www.paypal.com/uk/cgi-bin/webscr?cmd=_flow&SESSION=J9ZVe14oAcscIob-zDF-fwGrn8AKrFh8qOFH9EZf_NFudLbFYNBmx1Ru66G&dispatch=5885d80a13c0db1f8e263663d3faee8d94717bd303200c3af9aadd01a5f55080")
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
                  text: qsTr("This app is based on the Icon pack support GUI by RikudouSennin.\n \nThanks to Dax89 for help and patience.")
              }

              Placeholder { }

              /*
              PageHeader {
                  title: qsTr("Translators")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  text: qsTr("English")+": fravaccaro\n"+qsTr("Italian")+": fravaccaro"
              }

              Placeholder { }
              */
        }
    }
}
