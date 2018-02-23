import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import org.nemomobile.notifications 1.0
import org.nemomobile.configuration 1.0
import "../components"

SilicaFlickable
{
    id: toolspage
    anchors.fill: parent
    contentHeight: content.height
    clip: true

    Connections
    {
        function notify() {
            busyindicator.running = false;
            notification.publish();
        }

        target: themepack
        onOcrRestored: notify()
        onRestartHomescreenRestored: notify()
    }

    ConfigurationGroup {
        id: autoupd
        path: "/desktop/lipstick/sailfishos-uithemer"
        property bool homeRefresh: true
        property int autoUpdate: 0
    }

    enabled: !busyindicator.running
    opacity: busyindicator.running ? 0.0 : 1.0

    Column {
        id: content
        width: parent.width
        spacing: Theme.paddingMedium
        anchors.bottomMargin: Theme.paddingLarge

        PullDownMenu
        {
            MenuItem {
                text: qsTr("About UI Themer")
                onClicked: pageStack.push(Qt.resolvedUrl("../pages/menu/AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Usage guide")
                onClicked: pageStack.push(Qt.resolvedUrl("../pages/menu/GuidePage.qml"))
            }
            MenuItem {
                text: qsTr("Recovery")
                onClicked: pageStack.push(Qt.resolvedUrl("../pages/menu/RecoveryPage.qml"), { "themePack": themepack, "notification": notification })
            }
        }

        PageHeader { title: qsTr("Tools") }

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
                    themepack.restartHomescreen();
                });
            }
        }

        SectionHeader { text: qsTr("Icon updater") }

        Label {
            x: Theme.paddingLarge
            width: parent.width - (x * 2)
            wrapMode: Text.Wrap
            textFormat: Text.RichText
            text: qsTr("Everytime an app is updated, you need to re-apply the theme in order to get the custom icon back. The Icon updater will automate this process, enabling automatic update of icons at a given time.")
        }

        ComboBox {
            function applyUpdater(setting, hours) {
                autoupd.autoUpdate = setting;

                if(setting === 0)
                    themepack.disableService();
                else
                    themepack.applyHours(hours);
            }

            function applyDaily() {
                var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog", { hourMode: DateTime.TwentyFourHours });
                dialog.accepted.connect(function() { cbxupdate.applyUpdater(7, dialog.timeText); });
            }

            id: cbxupdate
            width: parent.width
            label: qsTr("Update icons")
            currentIndex: autoupd.autoUpdate

            menu: ContextMenu {
                MenuItem { text: qsTr("Disabled"); onClicked: cbxupdate.applyUpdater(0) }
                MenuItem { text: qsTr("30 minutes"); onClicked: cbxupdate.applyUpdater(1, 30) }
                MenuItem { text: qsTr("1 hour"); onClicked: cbxupdate.applyUpdater(2, 1) }
                MenuItem { text: qsTr("2 hours"); onClicked: cbxupdate.applyUpdater(3, 2) }
                MenuItem { text: qsTr("3 hours"); onClicked: cbxupdate.applyUpdater(4, 3) }
                MenuItem { text: qsTr("6 hours"); onClicked: cbxupdate.applyUpdater(5, 6) }
                MenuItem { text: qsTr("12 hours"); onClicked: cbxupdate.applyUpdater(6, 12) }
                MenuItem { text: qsTr("Daily"); onClicked: cbxupdate.applyDaily(); }
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
                    themepack.ocr();
                });
            }
        }

    }

    VerticalScrollDecorator { }
}
