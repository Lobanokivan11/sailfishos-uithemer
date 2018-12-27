import QtQuick 2.0
import "../js/Database.js" as Database

Item
{
    property string activeFontPack
    property string activeIconPack

    property bool homeRefresh: true
    property bool wizardDone: false
    property int autoUpdate: 0
    property bool isRunning: false

    function deactivateFont() { activeFontPack = "none"; }
    function deactivateIcon() { activeIconPack = "none"; }

    id: settings

    onActiveFontPackChanged: Database.activateFont(activeFontPack)
    onActiveIconPackChanged: Database.activateIcon(activeIconPack)

    Component.onCompleted: {
        Database.load();

        activeFontPack = Database.getActiveFont();
        activeIconPack = Database.getActiveIcon();
    }
}
