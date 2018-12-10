import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0
import org.nemomobile.notifications 1.0
import harbour.uithemer 1.0
import "../js/Database.js" as Database
import "../components"
import "../components/dockedbar"

Page
{
    id: densitypage
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
            flickable.flick(0, - densitypage.height);
            event.accepted = true;
        }

        if (event.key === Qt.Key_Up) {
            flickable.flick(0, densitypage.height);
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

        if (event.key === Qt.Key_O) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("OptionsPage.qml"), null, PageStackAction.Immediate);
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
                settings.isRunning = true;
                themepack.restartHomescreen();
            });
            event.accepted = true;
        }
    }

    SilicaFlickable
    {
        id: flickable
        enabled: !busyindicator.running
        opacity: busyindicator.running ? 0.3 : 1.0
        anchors.fill: parent
        anchors.bottomMargin: dockedbar.height
        contentHeight: content.height
        clip: true

        ConfigurationGroup {
            id: silica
            path: "/desktop/sailfish/silica"
            property real theme_pixel_ratio
            property real icon_size_launcher
        }

    PullDownMenu
    {

        MenuItem {
            visible: false
            text: qsTr("Restore icon size")
            onClicked: {
                themepack.restoreIZ();
                cbiz.value = silica.icon_size_launcher;
            }
        }

        MenuItem {
            text: qsTr("Restore Android DPI")
            visible: themepack.hasAndroidSupport
            onClicked: {
                themepack.restoreADPI();
                sladpi.value = themepack.droidDPI;
            }
        }

        MenuItem {
            text: qsTr("Restore device pixel ratio")

            onClicked: {
                themepack.restoreDPR();
                sldpr.value = silica.theme_pixel_ratio;
            }
        }
    }

    Column
    {
        id: content
        width: parent.width
        spacing: Theme.paddingMedium
        anchors.bottomMargin: Theme.paddingLarge

        PageHeader { title: qsTr("Display density") }
        SectionHeader { text: qsTr("Device pixel ratio") }

        Column
        {
            id: coldpr
            width: parent.width

            Slider {
                id: sldpr
                width: parent.width
                label: qsTr("Device pixel ratio")
                maximumValue: 2.3
                minimumValue: 0.7
                stepSize: 0.05
                value: silica.theme_pixel_ratio
                valueText: value
                onPressAndHold: cancel()

                onReleased: {
                    silica.theme_pixel_ratio = value;
                }
            }

            LabelText {
                text: qsTr("Change the display pixel ratio. To a smaller value corresponds an higher density.<br><br>Remember to restart the homescreen right after.")
            }
        }

        Column
        {
            id: coladpi
            width: parent.width
            visible: themepack.hasAndroidSupport

            SectionHeader { text: qsTr("Android DPI") }

            Slider {
                id: sladpi
                width: parent.width
                label: qsTr("Android DPI value")
                maximumValue: 600
                minimumValue: 180
                stepSize: 20
                value: themepack.droidDPI
                valueText: value
                onReleased: themepack.applyADPI(valueText)
                onPressAndHold: cancel()
            }

            LabelText {
                text: qsTr("Change the Android DPI value. To a smaller value corresponds an higher density.<br><br>Remember to restart the Android support or the homescreen right after.")
            }
        }

        SectionHeader { text: qsTr("Icon size") }
        Column
        {
            id: coliz
            width: parent.width

            ComboBox {
                id: cbiz
                width: parent.width
                label: qsTr("Icon size")
                value: silica.icon_size_launcher

                menu: ContextMenu {
                    MenuItem { text: "86"; onClicked: silica.icon_size_launcher = 86 }
                    MenuItem { text: "108"; onClicked: silica.icon_size_launcher = 108 }
                    MenuItem { text: "129"; onClicked: silica.icon_size_launcher = 129 }
                    MenuItem { text: "151"; onClicked: silica.icon_size_launcher = 151 }
                    MenuItem { text: "172"; onClicked: silica.icon_size_launcher = 172 }
                }
            }

            LabelText {
                text: qsTr("Change the size of UI icons. To a greater value corresponds an huger size.<br><br>Remember to restart the homescreen right after.")
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
