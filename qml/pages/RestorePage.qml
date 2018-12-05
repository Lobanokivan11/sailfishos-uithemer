import QtQuick 2.0
import Sailfish.Silica 1.0
import "../common"
import "../components"

Dialog
{
    property Settings settings
    property alias restoreIcons: itsrestoreicons.checked
    property alias restoreFonts: itsrestorefonts.checked

    id: dlgrestore
    focus: true
    canAccept: itsrestoreicons.checked || itsrestorefonts.checked

    Keys.onPressed: {
        handleKeyPressed(event);
    }

    function handleKeyPressed(event) {

        if (event.key === Qt.Key_Down) {
            flickable.flick(0, - dlgrestore.height);
            event.accepted = true;
        }

        if (event.key === Qt.Key_Up) {
            flickable.flick(0, dlgrestore.height);
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
            pageStack.push(Qt.resolvedUrl("menu/GuidePage.qml"));
            event.accepted = true;
        }
    }

    SilicaFlickable
    {
        id: flickable
        anchors.fill: parent
        anchors.bottomMargin: Theme.paddingLarge
        contentHeight: column.height
        width: parent.width

        Column
        {
            id: column
            width: parent.width
            spacing: Theme.paddingMedium

            DialogHeader { id: header; acceptText: qsTr("Restore"); cancelText: qsTr("Cancel") }

            ConfirmHeader { text: qsTr("Restore") }

            IconTextSwitch {
                id: itsrestoreicons
                automaticCheck: true
                text: qsTr("Default icons")
                checked: true

                onClicked: {
                    if(!itsrestoreicons.checked && !itsrestorefonts.checked)
                        confirmpage.canAccept = false
                    else
                        confirmpage.canAccept = true
                }
            }

            IconTextSwitch {
                id: itsrestorefonts
                automaticCheck: true
                text: qsTr("Default fonts")
                checked: true

                onClicked: {
                    if(!itsrestoreicons.checked && !itsrestorefonts.checked)
                        confirmpage.canAccept = false
                    else
                        confirmpage.canAccept = true
                }
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

        }
    }
}
