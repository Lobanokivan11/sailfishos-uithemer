import QtQuick 2.0
import Sailfish.Silica 1.0
import "../common"

Dialog
{
    property Settings settings
    property alias restoreIcons: itsrestoreicons.checked
    property alias restoreFonts: itsrestorefonts.checked

    id: dlgrestore
    canAccept: itsrestoreicons.checked || itsrestorefonts.checked

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

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                text: qsTr("What do you want to restore?")
                textFormat: Text.RichText
                wrapMode: Text.Wrap
            }

            IconTextSwitch {
                id: itsrestoreicons
                automaticCheck: true
                text: qsTr("Restore default icons")
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
                text: qsTr("Restore default fonts")
                checked: true

                onClicked: {
                    if(!itsrestoreicons.checked && !itsrestorefonts.checked)
                        confirmpage.canAccept = false
                    else
                        confirmpage.canAccept = true
                }
            }

            Label {
                width: parent.width - (x * 2)
                x: Theme.paddingLarge
                text: "<br>" + qsTr("Remember to restart the homescreen right after.")
                textFormat: Text.RichText
                wrapMode: Text.Wrap
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
