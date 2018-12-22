import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import org.nemomobile.notifications 1.0
import org.nemomobile.configuration 1.0
import "../components"

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

        if (event.key === Qt.Key_H) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("MainPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_G) {
            pageStack.push(Qt.resolvedUrl("GuidePage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_W) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("WelcomePage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_A) {
            pageStack.push(Qt.resolvedUrl("AboutPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_R) {
            var dlgrestart = pageStack.push("RestartHSPage.qml");
            dlgrestart.accepted.connect(function() {
                    themepack.restartHomescreen();
                    console.log("homescreen restart");
            });
            event.accepted = true;
        }
    }

SilicaFlickable
{
    id: flickable
    anchors.fill: parent
    contentHeight: content.height
    enabled: !busyindicator.running
    opacity: busyindicator.running ? 0.2 : 1.0

    ThemePackModel {
                function applyDone() {
                    notifyDone();
                    if(settings.homeRefresh === true) {
                        themepack.restartHomescreen();
                        console.log("homescreen restart");
                    } else
                        console.log("no homescreen restart");
                }
                function notifyDone() {
                    settings.isRunning = false;
                    notification.publish();
                }

                id: themepackmodel
                onOcrRestored: applyDone()
                onRecovered: applyDone()
            }

    ConfigurationGroup {
        id: conf
        path: "/desktop/lipstick/sailfishos-uithemer"
        property int coverAction1: 0
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
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Usage guide")
                onClicked: pageStack.push(Qt.resolvedUrl("GuidePage.qml"))
            }
            MenuItem {
                text: qsTr("Restart first run wizard")
                onClicked: pageStack.replaceAbove(null, Qt.resolvedUrl("WelcomePage.qml"))
            }
        }

        PageHeader { title: qsTr("Options") }

        SectionHeader { text: qsTr("Cover") }

        ComboBox {
            function saveCoverAction(action) {
                conf.coverAction1 = action;
                conf.sync();
            }

            id: cbxca
            width: parent.width
            label: qsTr("Cover action")
            currentIndex: conf.coverAction1

            menu: ContextMenu {
                MenuItem { text: qsTr("refresh current theme"); onClicked: cbxca.saveCoverAction(0) }
                MenuItem { text: qsTr("restart homescreen"); onClicked: cbxca.saveCoverAction(1) }
                MenuItem { text: qsTr("one-click restore"); onClicked: cbxca.saveCoverAction(2) }
                MenuItem { text: qsTr("none"); onClicked: cbxca.saveCoverAction(3) }
            }
        }
        LabelText {
            text: qsTr("Restart the app for the setting to be effective.")
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
                var dlgocr = pageStack.push("OCRPage.qml", { "settings": settings });
                dlgocr.accepted.connect(function() {
                    settings.isRunning = true;
                    settings.deactivateFont();
                    settings.deactivateIcon();
                    themepackmodel.ocr();
                });
            }
        }

        SectionHeader { text: qsTr("Recovery") }

        LabelText {
            text: qsTr("Here you can find advanced settings for UI Themer, e.g. reinstall default icons or fonts if you forget to revert to default theme before a system update or if the applying fails.")
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Recovery")
            onClicked: {
                var dlgrecovery = pageStack.push("RecoveryPage.qml", { "settings": settings });
                dlgrecovery.accepted.connect(function() {
                    settings.isRunning = true;
                    themepackmodel.recovery(dlgrecovery.reinstallIcons, dlgrecovery.reinstallFonts);
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

}
