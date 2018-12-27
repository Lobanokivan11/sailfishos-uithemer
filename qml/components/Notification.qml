import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0

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
