import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import harbour.uithemer 1.0
import "../components/themepacklistview"
import "../components/dockedbar"

Page
{
    id: mainpage

    RemorsePopup { id: remorsepopup }
    ThemePack { id: themepack; onIconsRestored: settings.deactivateIcon(); onFontsRestored: settings.deactivateFont() }

    Loader
    {
        id: loader
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: dockedbar.top }
        source: Qt.resolvedUrl("../components/themepacklistview/ThemePackListView.qml");
    }

    BusyIndicator { id: busyindicator; running: false; size: BusyIndicatorSize.Large; anchors.centerIn: parent }

    DockedBar
    {
        id: dockedbar
        anchors { left: parent.left; bottom: parent.bottom; right: parent.right }
    }

    Notification
    {
         id: notification
         category: "x-nemo.uithemer"
         appName: "UI Themer"
         appIcon: "/usr/share/icons/hicolor/86x86/apps/sailfishos-uithemer.png"
         previewSummary: "UI Themer"
         previewBody: qsTr("Settings applied.")
         itemCount: 1
         expireTimeout: 5000
         remoteActions: [ {
             "name": "default",
             "service": "org.nemomobile.uithemer",
             "path": "/done",
             "iface": "org.nemomobile.uithemer",
             "method": "themeApplied"
         } ]
     }
}
