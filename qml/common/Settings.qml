import QtQuick 2.0
import org.nemomobile.configuration 1.0

Item
{

    ConfigurationGroup {
        id: conf
        path: "/desktop/lipstick/sailfishos-uithemer"
        property bool showEasygui
        property bool showDensity
        property bool easygui
        property bool densityEnabled
        property bool wizardDone
        property string activeFontPack
        property string activeIconPack
        property bool coverActiveTheme
        property int coverAction1
        property int coverAction2
        property int autoUpdate
        property bool servicesu
    }

    property alias showEasygui: conf.showEasygui
    property alias showDensity: conf.showDensity
    property alias easygui: conf.easygui
    property alias densityEnabled: conf.densityEnabled
    property alias wizardDone: conf.wizardDone
    property alias activeFontPack: conf.activeFontPack
    property alias activeIconPack: conf.activeIconPack
    property alias coverActiveTheme: conf.coverActiveTheme
    property alias coverAction1: conf.coverAction1
    property alias coverAction2: conf.coverAction2
    property alias autoUpdate: conf.autoUpdate
    property alias servicesu: conf.servicesu

    property bool homeRefresh: true
    property bool isRunning: false

    function deactivateFont() { activeFontPack = "default"; }
    function deactivateIcon() { activeIconPack = "default"; }

    id: settings

    onEasyguiChanged: conf.sync();
    onDensityEnabledChanged: conf.sync();
    onWizardDoneChanged: conf.sync();
    onActiveFontPackChanged: conf.sync();
    onActiveIconPackChanged: conf.sync();
    onCoverActiveThemeChanged: conf.sync();
    onCoverAction1Changed: conf.sync();
    onCoverAction2Changed: conf.sync();
    onAutoUpdateChanged: conf.sync();
    onServicesuChanged: conf.sync();

    Component.onCompleted: {
        conf.sync();
    }
}
