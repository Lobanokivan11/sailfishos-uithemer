import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import org.nemomobile.notifications 1.0
import "../../components"

Page
{
    property ThemePack themePack
    property Notification notification

    id: toolspage
    backNavigation: !busyindicator.running
    showNavigationIndicator: !busyindicator.running

    RemorsePopup { id: remorsepopup }
    BusyIndicator { id: busyindicator; running: false; size: BusyIndicatorSize.Large; anchors.centerIn: parent }

    Connections
    {
        function notify() {
            busyindicator.running = false;
            notification.publish();
        }

        target: themePack
        onOcrRestored: notify()
        onRestartHomescreenRestored: notify()
        onIconsRestored: notify()
        onFontsRestored: notify()
    }

    SilicaFlickable
    {
        id: flickable
        anchors.fill: parent
        anchors.bottomMargin: Theme.paddingLarge
        contentHeight: content.height
        enabled: !busyindicator.running
        opacity: busyindicator.running ? 0.0 : 1.0

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingSmall

            PageHeader { title: qsTr("Tools") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Here you can find some recovery tools in case anything goes wrong (eg if you forget to restore the default theme before performing a system update).<br><br>Remember to restart the homescreen right after.")
            }

            SectionHeader { text: qsTr("Restart homescreen") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Restart the homescreen, to make your modifications effective. Your currently opened apps will be closed.")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Restart")
                onClicked: {
                    remorsepopup.execute(qsTr("Restarting homescreen"), function() {
                        busyindicator.running = true;
                        themePack.restartHomescreen();
                    });
                }
            }

            SectionHeader { text: qsTr("One-click restore") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("UI Themer customizations must be reverted before performing a system update. With One-click restore you can automate this process and restore icons, fonts and display density settings with just one click.")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Restore")
                onClicked: {
                    remorsepopup.execute(qsTr("Restoring"), function() {
                        busyindicator.running = true;
                        themePack.ocr();
                    });
                }
            }

            SectionHeader { text: qsTr("Icons") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("If any error occurs during themes applying/restoring, you can end up with messed up icons. From here, you can reinstall default Jolla app icons while, for thirdy party apps, you may need to reinstall/update apps to restore the default look.")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Reinstall icons")

                onClicked: {
                    remorsepopup.execute(qsTr("Reinstalling icons"), function() {
                        busyindicator.running = true;
                        themePack.reinstallIcons();
                    });
                }
            }

            SectionHeader { text: qsTr("Fonts") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Reinstall default fonts, if font applying/restoring fails.")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Reinstall fonts")

                onClicked: {
                    remorsepopup.execute(qsTr("Reinstalling fonts"), function() {
                        busyindicator.running = true;
                        themePack.reinstallFonts();
                    });
                }
            }
        }

        VerticalScrollDecorator { }
    }
}
