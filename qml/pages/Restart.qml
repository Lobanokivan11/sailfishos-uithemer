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
    acceptDestinationAction: PageStackAction.Pop

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
                acceptText: qsTr("Yes")
                cancelText: qsTr("No")
            }
            Label {
                width: parent.width - Theme.paddingLarge * 2
                x: Theme.paddingLarge
                text: qsTr("Do you want to restart the homescreen?")
                textFormat: Text.RichText
                wrapMode: Text.Wrap
            }
    }
    }
    onAccepted: {
        iconpack.restart_homescreen();
    }

}
