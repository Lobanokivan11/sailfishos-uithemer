import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import org.nemomobile.configuration 1.0
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

    property int activeTabId: 0

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
                onDpiRestored: {
                    sladpi.value = themepack.droidDPI;
                    silica.sync();
                    sldpr.value = silica.theme_pixel_ratio;
                    applyDone()
                }
            }

    Timer {
        id: timer
        interval: 5000
        repeat: true
        onTriggered: themepackmodel.reloadAll()
    }

    Connections {
        target: Qt.application
        onActiveChanged: {
            if(Qt.application.active) {
                timer.restart()
            } else {
                timer.stop()
            }
        }
    }

    Keys.onPressed: {
        handleKeyPressed(event);
    }

    function handleKeyPressed(event) {

        if (event.key === Qt.Key_Right) {
            switch (mainpage.activeTabId) {
                case 0:
                    viewsSlideshow.opacity = 0;
                    slideshowVisibleTimer.goToTab(1);
                    openTab(1);
                    break;
                case 1:
                    viewsSlideshow.opacity = 0;
                    slideshowVisibleTimer.goToTab(0);
                    openTab(0);
                    break;
            }
        }

        if (event.key === Qt.Key_Left) {
            switch (mainpage.activeTabId) {
                case 0:
                    viewsSlideshow.opacity = 0;
                    slideshowVisibleTimer.goToTab(1);
                    openTab(1);
                    break;
                case 1:
                    viewsSlideshow.opacity = 0;
                    slideshowVisibleTimer.goToTab(0);
                    openTab(0);
                    break;
            }
        }

        if (event.key === Qt.Key_Down) {
            switch (mainpage.activeTabId) {
                case 0:
                    themepacklistview.flick(0, - mainpage.height);
                    event.accepted = true;
                    break;
                case 1:
                    densityView.flick(0, - mainpage.height);
                    event.accepted = true;
                    break;
            }
        }

        if (event.key === Qt.Key_Up) {
            switch (mainpage.activeTabId) {
                case 0:
                    themepacklistview.flick(0, mainpage.height);
                    event.accepted = true;
                    break;
                case 1:
                    densityView.flick(0, mainpage.height);
                    event.accepted = true;
                    break;
            }
        }

        if (event.key === Qt.Key_PageDown) {
            switch (mainpage.activeTabId) {
                case 0:
                    themepacklistview.scrollToBottom();
                    event.accepted = true;
                    break;
                case 1:
                    densityView.scrollToBottom();
                    event.accepted = true;
                    break;
            }
        }

        if (event.key === Qt.Key_PageUp) {
            switch (mainpage.activeTabId) {
                case 0:
                    themepacklistview.scrollToTop();
                    event.accepted = true;
                    break;
                case 1:
                    densityView.scrollToTop();
                    event.accepted = true;
                    break;
            }
        }

        if (event.key === Qt.Key_H) {
            handleHomeClicked();
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

        if (event.key === Qt.Key_W) {
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

    function openTab(tabId) {
        activeTabId = tabId;
        switch (tabId) {
        case 0:
            homeButton.isActive = true;
            densityButton.isActive = false;
            break;
        case 1:
            homeButton.isActive = false;
            densityButton.isActive = true;
            break;
        }
}

    function handleHomeClicked() {
        if (mainpage.activeTabId === 0) {
            themepacklistview.scrollToTop();
        } else {
            viewsSlideshow.opacity = 0;
            slideshowVisibleTimer.goToTab(0);
            openTab(0);
        }
}
    function handleDisplayClicked() {
        if (mainpage.activeTabId === 1) {
            densityView.scrollToTop();
        } else {
            viewsSlideshow.opacity = 0;
            slideshowVisibleTimer.goToTab(1);
            openTab(0);
        }
    }

    Timer {
        id: slideshowVisibleTimer
        property int tabId: 0
        interval: 50
        repeat: false
        onTriggered: {
            viewsSlideshow.positionViewAtIndex(tabId, PathView.SnapPosition);
            viewsSlideshow.opacity = 1;
        }
        function goToTab(newTabId) {
            tabId = newTabId;
            start();
        }
    }

    Component.onCompleted: {
        console.log("page loaded");
        viewsSlideshow.positionViewAtIndex(0, PathView.SnapPosition);
        viewsSlideshow.opacity = 1
    }

    SlideshowView {
        id: viewsSlideshow
        width: parent.width
        height: parent.height
        itemWidth: width
        anchors.fill: parent
        anchors.bottomMargin: dockedbar.height
        clip: true
        model: viewsModel
        onCurrentIndexChanged: {
            openTab(currentIndex);
        }
        onOpacityChanged: {
            if (opacity === 0) {
                slideshowVisibleTimer.start();
            }
        }
        currentIndex: 1
        opacity: 0
        enabled: !busyindicator.running

    }

    VisualItemModel {
        id: viewsModel

        Item {
            width: viewsSlideshow.itemWidth
            height: viewsSlideshow.height

        SilicaListView {
        id: themepacklistview
        width: parent.width
        height: parent.height
        opacity: busyindicator.running ? 0.2 : 1.0

        contentHeight: content.height

        header: Column {
                   id: mainpageheader
                   width: parent.width
                   height: titlepageheader.height
                   PageHeader { id: titlepageheader; title: qsTr("Themes") }
                   IconButton {
                           id: downloadthemesicon
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

        model: ThemePackModel {}

        delegate: ThemePackItem {
            fontInstalled: model.packName === settings.activeFontPack
            iconInstalled: model.packName === settings.activeIconPack

            onClicked: {
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
            MenuItem {
                text: qsTr("About UI Themer")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Usage guide")
                onClicked: pageStack.push(Qt.resolvedUrl("GuidePage.qml"))
            }
            MenuItem {
                text: qsTr("Options")
                onClicked: pageStack.push(Qt.resolvedUrl("OptionsPage.qml"))
            }

            MenuItem {
                text: qsTr("Restart homescreen")
                onClicked: {
                    var dlgrestart = pageStack.push("RestartHSPage.qml");
                    dlgrestart.accepted.connect(function() {
                            themepack.restartHomescreen();
                            console.log("homescreen restart");
                    });
                }
            }

            MenuItem {
                text: qsTr("Restore")

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
    }


    Item
    {
        width: viewsSlideshow.itemWidth
        height: viewsSlideshow.height

        SilicaFlickable
        {
            id: densityView
            width: parent.width
            height: parent.height
            opacity: busyindicator.running ? 0.2 : 1.0
            contentHeight: content.height

            ConfigurationGroup {
                id: silica
                path: "/desktop/sailfish/silica"
                property real theme_pixel_ratio
                property real icon_size_launcher
            }

        PullDownMenu {
            MenuItem {
                text: qsTr("About UI Themer")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Usage guide")
                onClicked: pageStack.push(Qt.resolvedUrl("GuidePage.qml"))
            }
            MenuItem {
                text: qsTr("Options")
                onClicked: pageStack.push(Qt.resolvedUrl("OptionsPage.qml"))
            }

            MenuItem {
                text: qsTr("Restart homescreen")
                onClicked: {
                    var dlgrestart = pageStack.push("RestartHSPage.qml");
                    dlgrestart.accepted.connect(function() {
                            themepack.restartHomescreen();
                            console.log("homescreen restart");
                    });
                }
            }
            MenuItem {
                text: qsTr("Restore")

                onClicked: {
                    var dlgrestore = pageStack.push("RestoreDDPage.qml", { "settings": settings });

                    dlgrestore.accepted.connect(function() {
                        settings.isRunning = true;
                        themepackmodel.restoreDpi(dlgrestore.restoreDPR, dlgrestore.restoreADPI);
                    });
                }
            }
        }

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingMedium
            anchors.bottomMargin: Theme.paddingLarge

            PageHeader { title: qsTr("Display density") }
            SectionHeader { text: qsTr("Device pixel ratio") }

            Column
            {
                id: coldpr
                width: parent.width

                Slider {
                    id: sldpr
                    width: parent.width
                    label: qsTr("Device pixel ratio")
                    maximumValue: 2.3
                    minimumValue: 0.7
                    stepSize: 0.05
                    value: silica.theme_pixel_ratio
                    valueText: value
                    onPressAndHold: cancel()

                    onReleased: {
                        silica.theme_pixel_ratio = value;
                    }
                }

                LabelText {
                    text: qsTr("Change the display pixel ratio. To a smaller value corresponds an higher density.<br><br>Remember to restart the homescreen right after.")
                }
            }

            Column
            {
                id: coladpi
                width: parent.width
                visible: themepack.hasAndroidSupport

                SectionHeader { text: qsTr("Android DPI") }

                Slider {
                    id: sladpi
                    width: parent.width
                    label: qsTr("Android DPI value")
                    maximumValue: 600
                    minimumValue: 180
                    stepSize: 20
                    value: themepack.droidDPI
                    valueText: value
                    onReleased: themepackmodel.applyADPI(valueText)
                    onPressAndHold: cancel()
                }

                LabelText {
                    text: qsTr("Change the Android DPI value. To a smaller value corresponds an higher density.<br><br>Remember to restart the Android support or the homescreen right after.")
                }
            }

            SectionHeader { text: qsTr("Icon size") }
            Column
            {
                id: coliz
                width: parent.width

                ComboBox {
                    id: cbiz
                    width: parent.width
                    label: qsTr("Icon size")
                    value: silica.icon_size_launcher

                    menu: ContextMenu {
                        MenuItem { text: "86"; onClicked: silica.icon_size_launcher = 86 }
                        MenuItem { text: "108"; onClicked: silica.icon_size_launcher = 108 }
                        MenuItem { text: "129"; onClicked: silica.icon_size_launcher = 129 }
                        MenuItem { text: "151"; onClicked: silica.icon_size_launcher = 151 }
                        MenuItem { text: "172"; onClicked: silica.icon_size_launcher = 172 }
                    }
                }

                LabelText {
                    text: qsTr("Change the size of UI icons. To a greater value corresponds an huger size.<br><br>Remember to restart the homescreen right after.")
                }
            }

            Item {
                width: 1
                height: Theme.paddingLarge
            }

        }

        VerticalScrollDecorator { }

        }

    }

    }

    Item
    {

        id: dockedbar
        width: parent.width
        height: Theme.itemSizeLarge
        enabled: !busyindicator.running
        opacity: busyindicator.running ? 0.2 : 1.0
        anchors { left: parent.left; bottom: parent.bottom; right: parent.right }

        Separator {
            id: dockedbarSeparator
            width: parent.width
            color: Theme.primaryColor
            horizontalAlignment: Qt.AlignHCenter
        }

        BackgroundRectangle { anchors.fill: parent }

        Row {
            Item {
                id: homeButton
                property bool isActive: false

                width: dockedbar.width/2
                height: Theme.itemSizeLarge
                IconButton {
                    width: Theme.iconSizeMedium
                    height: Theme.iconSizeMedium
                    anchors.centerIn: parent
                    icon.source: homeButton.isActive ? "image://theme/icon-m-home?" + Theme.highlightColor : "image://theme/icon-m-home?" + Theme.primaryColor
                    onClicked: { handleHomeClicked(); }
                }
            }

            Item {
                id: densityButton
                property bool isActive: false

                width: dockedbar.width/2
                height: Theme.itemSizeLarge
                IconButton {
                    width: Theme.iconSizeMedium
                    height: Theme.iconSizeMedium
                    anchors.centerIn: parent
                    icon.source: densityButton.isActive ? "image://theme/icon-m-scale?" + Theme.highlightColor : "image://theme/icon-m-scale?" + Theme.primaryColor
                    onClicked: { handleDisplayClicked(); }
                }
            }

        }
    }


}
