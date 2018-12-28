import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import "../common"
import "../components"

Dialog
{
    property Settings settings

    ThemePack { id: themepack }

    id: dlgocr
    focus: true
    canAccept: true
    backNavigation: !settings.isRunning
    forwardNavigation: !settings.isRunning
    showNavigationIndicator: !settings.isRunning

    BusyState { id: busyindicator }

    Keys.onPressed: {
        handleKeyPressed(event);
    }

    function handleKeyPressed(event) {

        if (event.key === Qt.Key_Down) {
            flickable.flick(0, - dlgocr.height);
            event.accepted = true;
        }

        if (event.key === Qt.Key_Up) {
            flickable.flick(0, dlgocr.height);
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

        if ((event.key === Qt.Key_B) || (event.key === Qt.Key_C)) {
            pageStack.navigateBack();
            event.accepted = true;
        }

        if (event.key === Qt.Key_Return) {
            dlgrestore.accept();
            event.accepted = true;
        }

        if (event.key === Qt.Key_G) {
            pageStack.push(Qt.resolvedUrl("GuidePage.qml"));
            event.accepted = true;
        }
    }

    SilicaFlickable
    {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height
        width: parent.width
        enabled: !settings.isRunning
        opacity: settings.isRunning ? 0.2 : 1.0

        VerticalScrollDecorator { }

        Column
        {
            id: column
            width: parent.width
            spacing: Theme.paddingMedium

            DialogHeader { id: header; acceptText: qsTr("Restore"); cancelText: qsTr("Cancel") }

            ConfirmHeader { text: qsTr("One-click restore") }

            LabelText {
                text: qsTr("UI Themer customizations must be reverted before performing a system update. With <i>One-click restore</i> you can automate this process and restore icons, fonts and display density settings with just one click.")
            }

            LabelText {
                text: "<br>" + qsTr("Remember to restart the homescreen right after.")
            }

            TextSwitch {
                text: qsTr("Restart homescreen")
                checked: settings.homeRefresh
                onCheckedChanged: {
                    settings.homeRefresh = checked;
                }
            }

            Item {
                width: 1
                height: Theme.paddingLarge
            }
        }
    }
}
