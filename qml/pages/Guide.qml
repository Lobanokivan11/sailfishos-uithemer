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
                title: qsTr("Usage guide")
            }

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
                text: qsTr("Remember to unapply themes and display density customizations before updating your system. In case you forgot, you may need to use the options provided in the <i>Tools</i> page or uninstall and reinstall UI Themer.")
            }

            Placeholder { }

            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("UI Themer is divided into three main sections, which provide you icons, fonts and display density customization, alongside additional options.")
            }

            Placeholder { }

            SectionHeader {
                  text: qsTr("Themes")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  text: qsTr("The <i>Themes</i> page lets you customize icons and fonts via thirdy party themes. The page lists the themes you have currently installed (e.g. from OpenRepos). To apply them, tap on a theme of your choice and then select what you want to use from that theme - if the theme contains different font weights, you can choose the default one to use for the UI. You can also combine different themes, so for example you can use icons from a theme and fonts from another. To revert to the default settings, you can use the restore option from the pulley menu.")
              }

              Placeholder { }

              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  text: qsTr("An homescreen restart may be needed to apply your settings. You can do that through the dialog or from the <i>Tools</i> page.")
              }

              Placeholder { }

              SectionHeader {
                  text: qsTr("Display density")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  text: qsTr("By increasing the display density, you can display more content on your screen - or less, if you prefer to have bigger UI elements. Android apps use a different setting than Sailfish OS ones. To revert to the default settings, you can use the restore options from the pulley menu.")
               }

              Placeholder { }

              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  text: qsTr("An homescreen restart may be needed to apply your settings. You can do that through the dialog or from the <i>Tools</i> page.")
              }

              Placeholder { }

              SectionHeader {
                  text: qsTr("Icon updater")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  onLinkActivated: Qt.openUrlExternally(link)
                  text: qsTr("Everytime an app is updated, you need to re-apply the theme in order to get the custom icon back. The Icon updater will automate this process, enabling automatic update of icons at a given time. You can choose between a pre-defined set of hours or a custom hour of the day.")
               }

              Placeholder { }

              SectionHeader {
                  text: qsTr("Tools")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  text: qsTr("Here you can find advanced settings for UI Themer, e.g. reinstall default icons or fonts if you forget to revert to default theme before a system update or if the applying fails.")
              }

              Placeholder { }

              SectionHeader {
                  text: qsTr("Further help")
              }
              Label {
                  x: Theme.paddingLarge
                  width: parent.width - Theme.paddingLarge * 2
                  wrapMode: Text.Wrap
                  textFormat: Text.RichText
                  onLinkActivated: Qt.openUrlExternally(link)
                  text: qsTr("If you still can't get the help you need, you can open an issue on <a href='https://github.com/fravaccaro/sailfishos-uithemer/issues'>GitHub</a>.")
               }

              Placeholder { }

        }
        VerticalScrollDecorator {}
    }
}
