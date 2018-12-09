import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import org.nemomobile.notifications 1.0
import org.nemomobile.configuration 1.0
import "../../components"

Page
{
    property ThemePack themePack
    property Notification notification

    id: recoverypage
    focus: true
    backNavigation: !busyindicator.running
    showNavigationIndicator: !busyindicator.running

    RemorsePopup { id: remorsepopup }
    ThemePack { id: themepack }
    BusyState { id: busyindicator }
    Notification { id: notification }

    Connections
    {
        function notify() {
            busyindicator.running = false;
            settings.isRunning = false;
            notification.publish();
        }

        target: themePack
        onIconsRestored: notify()
        onFontsRestored: notify()
    }

    Keys.onPressed: {
        handleKeyPressed(event);
    }

    function handleKeyPressed(event) {

        if (event.key === Qt.Key_Down) {
            flickable.flick(0, - recoverypage.height);
            event.accepted = true;
        }

        if (event.key === Qt.Key_Up) {
            flickable.flick(0, recoverypage.height);
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

        if (event.key === Qt.Key_B) {
            pageStack.navigateBack();
            event.accepted = true;
        }

        if (event.key === Qt.Key_H) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("../MainPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_D) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("../DensityPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_O) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("../OptionsPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_G) {
            pageStack.push(Qt.resolvedUrl("GuidePage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_W) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("../WelcomePage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_A) {
            pageStack.push(Qt.resolvedUrl("AboutPage.qml"));
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
        anchors.fill: parent
        anchors.bottomMargin: Theme.paddingLarge
        contentHeight: content.height
        enabled: !busyindicator.running
        opacity: busyindicator.running ? 0.0 : 1.0

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader { title: qsTr("Recovery") }

            LabelText {
                text: qsTr("Here you can find some recovery tools in case anything goes wrong (eg if you forget to restore the default theme before performing a system update).<br><br>Remember to restart the homescreen right after.")
            }

            SectionHeader { text: qsTr("Icons") }

            LabelText {
                text: qsTr("If any error occurs during themes applying/restoring, you can end up with messed up icons. From here, you can reinstall default Jolla app icons while, for thirdy party apps, you may need to reinstall/update apps to restore the default look.")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Reinstall icons")

                onClicked: {
                    remorsepopup.execute(qsTr("Reinstalling icons"), function() {
                        busyindicator.running = true;
                        settings.isRunning = true;
                        settings.deactivateIcon();
                        themePack.reinstallIcons();
                    });
                }
            }

            SectionHeader { text: qsTr("Fonts") }

            LabelText {
                text: qsTr("Reinstall default fonts, if font applying/restoring fails.")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Reinstall fonts")

                onClicked: {
                    remorsepopup.execute(qsTr("Reinstalling fonts"), function() {
                        busyindicator.running = true;
                        settings.isRunning = true;
                        settings.deactivateFont();
                        themePack.reinstallFonts();
                    });
                }
            }
        }

        VerticalScrollDecorator { }
    }
}
