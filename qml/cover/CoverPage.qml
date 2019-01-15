import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import harbour.uithemer 1.0
import "../components"

CoverBackground
{
     Notification { id: notification }
     ThemePackModel {
         function notifyDone() {
             settings.isRunning = false;
             notification.publish();
         }
         id: themepackmodel
         onIconReapplied: notifyDone()
         onOcrRestored: notifyDone()
     }
     ThemePack {
         function notifyDone() {
             settings.isRunning = false;
             notification.publish();
         }
         id: themepack
         onHomescreenRestarted: notifyDone()
     }

    Rectangle {
        anchors.fill: parent
        color: "transparent"

    Image {
        id: coverimg
        fillMode: Image.PreserveAspectFit
        source: "../../images/coverbg.png"
        opacity: settings.isRunning ? 0.2 : 0.4
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: sourceSize.height * width / sourceSize.width
    }

    Image {
        id: refreshimg
        enabled: settings.isRunning ? true : false
        visible: settings.isRunning ? true : false
        source: "image://theme/graphic-busyindicator-medium"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        width: 100
        height: 100
        opacity: 0.6
        RotationAnimation on rotation {
            duration: 2000;
            loops: Animation.Infinite;
            running : true
            from: 0; to: 360
        }
    }

     }

    Column {
        spacing: Theme.paddingSmall
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Theme.paddingMedium
        anchors.rightMargin: Theme.paddingMedium
        anchors.top: parent.top
        anchors.topMargin: parent.height/7
        anchors.verticalCenter: parent.verticalCenter
        visible: (settings.coverActiveTheme && !settings.isRunning)
        CoverLabel {
            visible: (settings.activeIconPack !== 'default')
            icon: "image://theme/icon-m-file-image"
            label: themepackmodel.readThemePackName("harbour-themepack-" + settings.activeIconPack)
        }
        CoverLabel {
            visible: (settings.activeFontPack !== 'default')
            icon: "image://theme/icon-m-font-size"
            label: themepackmodel.readThemePackName("harbour-themepack-" + settings.activeFontPack)
        }
    }

    Loader {
        source: {
            if (settings.coverAction1 !== 3 && settings.coverAction2 !== 3)
            return Qt.resolvedUrl("CoverActionList2.qml")
            else
            Qt.resolvedUrl("CoverActionList1.qml")
        }
    }

}
