import QtQuick 2.0
import org.nemomobile.configuration 1.0

Item
{

    ConfigurationGroup {
        id: conf
        path: "/desktop/lipstick/sailfishos-uithemer"
        property bool wizardDone: false
        property string activeFontPack
        property string activeIconPack
        property int coverAction1: 0
        property int coverAction2: 3
        property int autoUpdate: 0
        property bool servicesu: false
    }

    property alias wizardDone: conf.wizardDone
    property alias activeFontPack: conf.activeFontPack
    property alias activeIconPack: conf.activeIconPack
    property alias coverAction1: conf.coverAction1
    property alias coverAction2: conf.coverAction2
    property alias autoUpdate: conf.autoUpdate
    property alias servicesu: conf.servicesu

    property bool homeRefresh: true
    property bool isRunning: false

    function deactivateFont() { activeFontPack = "none"; }
    function deactivateIcon() { activeIconPack = "none"; }

    id: settings

    onWizardDoneChanged: conf.sync();
    onActiveFontPackChanged: conf.sync();
    onActiveIconPackChanged: conf.sync();
    onCoverAction1Changed: conf.sync();
    onCoverAction2Changed: conf.sync();
    onAutoUpdateChanged: conf.sync();
    onServicesuChanged: conf.sync();

    Component.onCompleted: {
        conf.sync();
    }
}
