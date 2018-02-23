import QtQuick 2.0
import Sailfish.Silica 1.0

Page
{
    id: guidepage

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

            PageHeader { title: qsTr("Usage guide") }

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
                text: qsTr("Remember to unapply themes and display density customizations before updating your system. In case you forgot, you may need to use the options provided in the <i>Recovery</i> page or uninstall and reinstall Theme pack support e UI Themer.")
            }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("UI Themer is divided into three main sections, which provide you icons, fonts and display density customization, alongside additional options.")
            }

            SectionHeader { text: qsTr("Themes") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                text: qsTr("The <i>Themes</i> page lets you customize icons and fonts via thirdy party themes. The page lists the themes you have currently installed (e.g. from OpenRepos). To apply them, tap on a theme of your choice and then select what you want to use from that theme - if the theme contains different font weights, you can choose the default one to use for the UI. You can also combine different themes, so for example you can use icons from a theme and fonts from another. To revert to the default settings, you can use the restore option from the pulley menu.")
            }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                text: qsTr("An homescreen restart may be needed to apply your settings. You can do that through the dialog or from the <i>Tools</i> page.")
            }

            SectionHeader { text: qsTr("Display density") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("By increasing the display density, you can display more content on your screen - or less, if you prefer to have bigger UI elements. Android apps use a different setting than Sailfish OS ones. To revert to the default settings, you can use the restore options from the pulley menu.")
            }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                text: qsTr("An homescreen restart may be needed to apply your settings. You can do that through the dialog or from the <i>Tools</i> page.")
            }

            SectionHeader { text: qsTr("Icon updater") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                onLinkActivated: Qt.openUrlExternally(link)
                text: qsTr("Everytime an app is updated, you need to re-apply the theme in order to get the custom icon back. The Icon updater will automate this process, enabling automatic update of icons at a given time. You can choose between a pre-defined set of hours or a custom hour of the day.")
            }

            SectionHeader { text: qsTr("One-click restore") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                onLinkActivated: Qt.openUrlExternally(link)
                text: qsTr("UI Themer customizations must be reverted before performing a system update. With One-click restore you can automate this process and restore icons, fonts and display density settings with just one click.")
            }

            SectionHeader { text: qsTr("Recovery") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                text: qsTr("Here you can find advanced settings for UI Themer, e.g. reinstall default icons or fonts if you forget to revert to default theme before a system update or if the applying fails.")
            }

            SectionHeader { text: qsTr("CLI tool") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                onLinkActivated: Qt.openUrlExternally(link)
                text: qsTr("If anything goes wrong or you want to manage all the options via terminal, you can recall the CLI tool by typing <b>themepacksupport</b> as root.")
            }

            SectionHeader { text: qsTr("Further help") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                onLinkActivated: Qt.openUrlExternally(link)
                text: qsTr("If you still can't get the help you need, you can open an issue on <a href='https://github.com/fravaccaro/sailfishos-uithemer/issues'>GitHub</a>.")
            }
        }

        VerticalScrollDecorator { }
    }
}
