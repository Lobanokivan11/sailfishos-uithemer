import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import harbour.uithemer 1.0
import Nemo.DBus 2.0
import "../js/Database.js" as Database
import "../components"
import "../components/themepacklistview"
import "../components/dockedbar"

Page
{
    id: mainpage
    focus: true

    RemorsePopup { id: remorsepopup }
    ThemePack { id: themepack; onIconsRestored: settings.deactivateIcon(); onFontsRestored: settings.deactivateFont() }
    BusyState { id: busyindicator }
    Notification { id: notification }

    Keys.onPressed: {
        handleKeyPressed(event);
    }

    function handleKeyPressed(event) {

        if (event.key === Qt.Key_Down) {
            themepacklistview.flick(0, - mainpage.height);
            event.accepted = true;
        }

        if (event.key === Qt.Key_Up) {
            themepacklistview.flick(0, mainpage.height);
            event.accepted = true;
        }

        if (event.key === Qt.Key_PageDown) {
            themepacklistview.scrollToBottom();
            event.accepted = true;
        }

        if (event.key === Qt.Key_PageUp) {
            themepacklistview.scrollToTop();
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

        if (event.key === Qt.Key_D) {
            pageStack.replaceAbove(null, Qt.resolvedUrl("DensityPage.qml"), null, PageStackAction.Immediate);
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
                busyindicator.running = true;
                themepack.restartHomescreen();
            });
            event.accepted = true;
        }
    }

    SilicaListView
    {
        id: themepacklistview
        enabled: !busyindicator.running
        opacity: busyindicator.running ? 0.0 : 1.0
        anchors.fill: parent
        anchors.bottomMargin: dockedbar.height
        clip: true

        header: PageHeader { title: qsTr("Themes") }

        model: ThemePackModel {
            function applyDone() {
                notifyDone();

                if(settings.homeRefresh === true) {
                    themepack.restartHomescreen();
                    console.log("homescreen restart");
                } else
                    console.log("no homescreen restart");
            }

            function notifyDone() {
                busyindicator.running = false;
                notification.publish();
            }

            id: themepackmodel
            onIconApplied: applyDone()
            onFontApplied: applyDone()
            onRestoreCompleted: applyDone()
            onUninstallCompleted: notifyDone()
        }

        delegate: ThemePackItem {
            fontInstalled: model.packName === settings.activeFontPack
            iconInstalled: model.packName === settings.activeIconPack

            onClicked: {
                var dlgconfirm = pageStack.push("ConfirmPage.qml", { "settings": settings, "themePackModel": themepackmodel, "themePackIndex": model.index });

                dlgconfirm.accepted.connect(function() {
                    busyindicator.running = true;

                    if(dlgconfirm.iconsSelected) {
                        themepackmodel.applyIcons(model.index, !dlgconfirm.fontsSelected || !themepackmodel.hasFont(model.index), dlgconfirm.iconOverlaySelected);
                        settings.activeIconPack = model.packName;
                    }

                    if(dlgconfirm.fontsSelected) {
                        themepackmodel.applyFonts(model.index, dlgconfirm.selectedFont);
                        settings.activeFontPack = model.packName;
                    }
                });
            }

            onUninstallRequested: {
                remorseAction(qsTr("Uninstalling %1").arg(model.packName), function() {
                    busyindicator.running = true;
                    themepackmodel.uninstall(model.index);

                    if(fontInstalled)
                        Database.deactivateFont();

                    if(iconInstalled)
                        Database.deactivateIcon();
                });
            }
        }

        DBusInterface {
            id: openStore
            service: 'harbour.storeman.service'
            path: '/harbour/storeman/service'
            iface: 'harbour.storeman.service'
        }

        PullDownMenu {
            MenuItem { text: qsTr("Download themes"); visible: themepack.hasStoremanInstalled(); onClicked: openStore.call('openPage', ['SearchPage', {initialSearch: 'themepack'}]) }
            MenuItem { text: qsTr("Refresh"); onClicked: themepackmodel.reloadAll() }

            MenuItem {
                text: qsTr("Restore")

                onClicked: {
                    var dlgrestore = pageStack.push("RestorePage.qml", { "settings": settings });

                    dlgrestore.accepted.connect(function() {
                        busyindicator.running = true;
                        themepackmodel.restore(dlgrestore.restoreIcons, dlgrestore.restoreFonts);

                        if(dlgrestore.restoreFonts)
                            settings.deactivateFont();

                        if(dlgrestore.restoreIcons)
                            settings.deactivateIcon();
                    });
                }
            }
        }

        ViewPlaceholder {
            enabled: themepacklistview.count == 0
            text: qsTr("No themes yet")
            hintText: qsTr("Install a compatible theme first")
        }

        Item {
            width: 1
            height: Theme.paddingLarge
        }

    }

    DockedBar
    {
        id: dockedbar
        anchors { left: parent.left; bottom: parent.bottom; right: parent.right }
    }

}
