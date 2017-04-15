import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../js/db.js" as DB
import "../js/functions.js" as Func
import "../components"

/*
 This is a dialog, which just tells user what will happen, if user clicks Yes, MainPage.qml handles it and takes action
 */
Dialog {
    id: page
    property string iconpack
    property bool icons_active
    property bool fonts_active

    property bool icons: false
    property bool fonts: false
    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height
        width: parent.width
        Column {
            id: column
            width: parent.width
            DialogHeader {
                id: header
                acceptText: qsTr("Ok")
                cancelText: qsTr("Cancel")
            }
            Label {
                width: parent.width - Theme.paddingLarge * 2
                x: Theme.paddingLarge
                text: qsTr("What do you want to restore? The UI may not respond for a while, do NOT close the app.<br><br>Remember to restart the homescreen right after.<br>")
                textFormat: Text.RichText
                wrapMode: Text.Wrap
            }

            IconTextSwitch {
                id: restore_icons
                automaticCheck: true
                text: qsTr("Restore default icons")
                checked: true
                enabled: icons_active
                onClicked: {
                    icons = restore_icons.checked;
                    console.log(icons);
                    if(!restore_icons.checked && !restore_fonts.checked) {
                        header.acceptText = qsTr("Cancel");
                    } else {
                        header.acceptText = qsTr("Ok");
                    }
                }
            }

            IconTextSwitch {
                id: restore_fonts
                automaticCheck: true
                text: qsTr("Restore default fonts")
                checked: true
                enabled: fonts_active
                onClicked: {
                    fonts = restore_fonts.checked;
                    console.log(fonts);
                    if(!restore_icons.checked && !restore_fonts.checked) {
                        header.acceptText = qsTr("Cancel");
                    } else {
                        header.acceptText = qsTr("Ok");
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        if(!fonts_active) {
            restore_fonts.checked = false;
        } else {
            fonts = true;
        }

        if(!icons_active) {
            restore_icons.checked = false;
        } else {
            icons = true;
        }
    }
}
