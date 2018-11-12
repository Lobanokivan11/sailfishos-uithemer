import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import Nemo.DBus 2.0
import "../../js/Database.js" as Database

SilicaListView
{
    id: themepacklistview
    enabled: !busyindicator.running
    opacity: busyindicator.running ? 0.0 : 1.0
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
            var dlgconfirm = pageStack.push("../../pages/ConfirmPage.qml", { "settings": settings, "themePackModel": themepackmodel, "themePackIndex": model.index });

            dlgconfirm.accepted.connect(function() {
                busyindicator.running = true;

                if(dlgconfirm.iconsSelected) {
                    themepackmodel.applyIcons(model.index, !dlgconfirm.fontsSelected || !themepackmodel.hasFont(model.index));
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

        function openPage() {
            call('openPage', ['SearchPage', {initialSearch: 'themepack'}])
        }
    }

    PullDownMenu {
        MenuItem { text: qsTr("Download themes"); onClicked: openStore.call('openPage', ['SearchPage', {initialSearch: 'themepack'}]) }
        MenuItem { text: qsTr("Refresh"); onClicked: themepackmodel.reloadAll() }

        MenuItem {
            text: qsTr("Restore")

            onClicked: {
                var dlgrestore = pageStack.push("../../pages/RestorePage.qml", { "settings": settings });

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

}
