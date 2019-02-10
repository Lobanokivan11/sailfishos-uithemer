import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import org.nemomobile.configuration 1.0
import harbour.uithemer 1.0
import Nemo.DBus 2.0
import "../components"
import "../components/themepacklistview"

Page
{
    id: mainpage
    focus: true

    RemorsePopup { id: remorsepopup }
    ThemePack { id: themepack }
    BusyState { id: busyindicator }
    Notification { id: notification }

    ThemePackModel {
                function applyDone() {
                    notifyDone();
                    if(settings.homeRefresh === true) {
                        themepack.restartHomescreen();
                        console.log("homescreen restart");
                    } else
                        console.log("no homescreen restart");
                }
                function notifyDone() {
                    settings.isRunning = false;
                    notification.publish();
                }

                id: themepackmodel
                onIconApplied: applyDone()
                onFontApplied: applyDone()
                onRestoreCompleted: applyDone()
                onUninstallCompleted: notifyDone()
            }

    Timer {
        id: timer
        interval: 10000
        repeat: true
        running: !settings.isRunning && Qt.application.state === Qt.ApplicationActive
        onTriggered: themepackmodel.reloadAll()
    }

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

        if (event.key === Qt.Key_D && settings.showDensity === true && settings.guimode !== 0) {
            pageStack.push(Qt.resolvedUrl("DensityPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_O) {
            pageStack.push(Qt.resolvedUrl("OptionsPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_G) {
            pageStack.push(Qt.resolvedUrl("GuidePage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_W && settings.guimode !== 0) {
            settings.wizardDone = false
            pageStack.replaceAbove(null, Qt.resolvedUrl("WelcomePage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_A) {
            pageStack.push(Qt.resolvedUrl("AboutPage.qml"));
            event.accepted = true;
        }

        if (event.key === Qt.Key_R) {
            var dlgrestart = pageStack.push("RestartHSPage.qml");
            dlgrestart.accepted.connect(function() {
                    themepack.restartHomescreen();
                    console.log("homescreen restart");
            });
            event.accepted = true;
        }
    }

    DBusInterface {
        id: openStore
        service: 'harbour.storeman.service'
        path: '/harbour/storeman/service'
        iface: 'harbour.storeman.service'
    }

        SilicaListView {
        id: themepacklistview
        width: parent.width
        height: parent.height
        anchors.fill: parent
        enabled: !settings.isRunning
        opacity: settings.isRunning ? 0.2 : 1.0

        PullDownMenu {
            MenuItem {
                text: qsTr("Usage guide")
                onClicked: pageStack.push(Qt.resolvedUrl("GuidePage.qml"))
            }
            MenuItem {
                text: qsTr("Options")
                onClicked: pageStack.push(Qt.resolvedUrl("OptionsPage.qml"))
            }

            MenuItem {
                text: qsTr("Display density")
                visible: settings.showDensity && settings.guimode !== 0
                onClicked: pageStack.push(Qt.resolvedUrl("DensityPage.qml"))
            }

            MenuItem {
                text: qsTr("Restore theme")

                onClicked: {
                    var dlgrestore = pageStack.push("RestorePage.qml", { "settings": settings });

                    dlgrestore.accepted.connect(function() {
                        settings.isRunning = true;
                        themepackmodel.restore(dlgrestore.restoreIcons, dlgrestore.restoreFonts);

                        if(dlgrestore.restoreFonts)
                            settings.deactivateFont();

                        if(dlgrestore.restoreIcons)
                            settings.deactivateIcon();
                    });
                }
            }
        }

        header: Column {
                   width: parent.width
                   height: titlepageheader.height
                   PageHeader { id: titlepageheader; title: qsTr("Themes") }
                   IconButton {
                           visible: themepack.hasStoremanInstalled()
                           anchors {
                               verticalCenter: parent.verticalCenter
                               left: parent.left
                               leftMargin: Theme.paddingMedium
                           }
                           icon.source: "image://theme/icon-m-cloud-download"
                           onClicked: openStore.call('openPage', ['SearchPage', {initialSearch: 'themepack'}])
                       }
        }

        model: themepackmodel

        delegate: ThemePackItem {
            fontInstalled: model.packName === settings.activeFontPack
            iconInstalled: model.packName === settings.activeIconPack

            onClicked: {
                timer.stop()
                var dlgconfirm = pageStack.push("ConfirmPage.qml", { "settings": settings, "themePackModel": themepackmodel, "themePackIndex": model.index });

                dlgconfirm.accepted.connect(function() {
                    settings.isRunning = true;

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
                    settings.isRunning = true;
                    themepackmodel.uninstall(model.index);

                    if(fontInstalled)
                        settings.deactivateFont();

                    if(iconInstalled)
                        settings.deactivateIcon();
                });
            }
        }

        ViewPlaceholder {
            enabled: themepacklistview.count == 0
            text: qsTr("No themes yet")
            hintText: qsTr("Install a compatible theme first")
        }

        Item {
            width: parent.width
            height: Theme.paddingLarge
        }

        VerticalScrollDecorator { }
        }

}
