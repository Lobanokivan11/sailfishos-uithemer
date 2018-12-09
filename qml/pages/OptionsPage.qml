import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import org.nemomobile.notifications 1.0
import org.nemomobile.configuration 1.0
import harbour.uithemer 1.0
import Nemo.DBus 2.0
import "../js/Database.js" as Database
import "../components"
import "../components/dockedbar"

Page
{
    id: optionspage
    focus: true

    RemorsePopup { id: remorsepopup }
    ThemePack { id: themepack }
    BusyState { id: busyindicator }
    Notification { id: notification }

    Keys.onPressed: {
        handleKeyPressed(event);
    }

    function handleKeyPressed(event) {

        if (event.key === Qt.Key_Down) {
            flickable.flick(0, - optionspage.height);
            event.accepted = true;
        }

        if (event.key === Qt.Key_Up) {
            flickable.flick(0, optionspage.height);
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

        if (event.key === Qt.Key_Return) {
            if (remorsepopup.active)
            remorsepopup.trigger();
            event.accepted = true;
        }

        if (event.key === Qt.Key_C) {
            remorsepopup.cancel();
            event.accepted = true;
        }

        if (event.key === Qt.Key_H) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("MainPage.qml"), null, PageStackAction.Immediate);
            event.accepted = true;
        }

        if (event.key === Qt.Key_D) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("DensityPage.qml"), null, PageStackAction.Immediate);
            event.accepted = true;
        }

        if (event.key === Qt.Key_G) {
            pageStack.push(Qt.resolvedUrl("menu/GuidePage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_W) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("WelcomePage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_A) {
            pageStack.push(Qt.resolvedUrl("menu/AboutPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_R) {
            remorsepopup.execute(qsTr("Restarting homescreen"), function() {
                busyindicator.running = true;
                themepack.restartHomescreen();
            });
            event.accepted = true;
        }
    }

SilicaFlickable
{
    id: flickable
    enabled: !busyindicator.running
    opacity: busyindicator.running ? 0.0 : 1.0
    anchors.fill: parent
    anchors.bottomMargin: dockedbar.height
    contentHeight: content.height
    clip: true

    Connections
    {
        function notify() {
            busyindicator.running = false;
            settings.isRunning = false;
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

    Column {
        id: content
        width: parent.width
        spacing: Theme.paddingMedium

        PullDownMenu
        {
            MenuItem {
                text: qsTr("About UI Themer")
                onClicked: pageStack.push(Qt.resolvedUrl("../pages/menu/AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Restart first run wizard")
                onClicked: pageStack.replaceAbove(null, Qt.resolvedUrl("../pages/WelcomePage.qml"))
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

        PageHeader { title: qsTr("Options") }

        SectionHeader { text: qsTr("Restart homescreen") }

        LabelText {
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

        SectionHeader { visible: false; text: qsTr("Icon updater") }

        LabelText {
            visible: false
            text: qsTr("Everytime an app is updated, you need to re-apply the theme in order to get the custom icon back. <i>Icon updater</i> will automate this process, enabling automatic update of icons at a given time.")
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
            visible: false
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

        LabelText {
            text: qsTr("UI Themer customizations must be reverted before performing a system update. With <i>One-click restore</i> you can automate this process and restore icons, fonts and display density settings with just one click.")
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Restore")
            onClicked: {
                remorsepopup.execute(qsTr("Restoring"), function() {
                    busyindicator.running = true;
                    settings.isRunning = true;
                    settings.deactivateFont();
                    settings.deactivateIcon();
                    themepack.ocr();
                });
            }
        }

        Item {
            width: 1
            height: Theme.paddingLarge
        }

    }

    VerticalScrollDecorator { }
}

DockedBar
{
    id: dockedbar
    anchors { left: parent.left; bottom: parent.bottom; right: parent.right }
}

}
