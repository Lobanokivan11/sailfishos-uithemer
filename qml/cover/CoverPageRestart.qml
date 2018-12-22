import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import harbour.uithemer 1.0
import "../components"

CoverBackground
{
     Notification { id: notification }
     ThemePack {
         function notifyDone() {
             settings.isRunning = false;
             notification.publish();
         }
         id: themepack
         onHomescreenRestarted: notifyDone()
     }

    Image
    {
        id: coverimg
        fillMode: Image.PreserveAspectFit
        source: "../../coverbg.png"
        opacity: settings.isRunning ? 0.3 : 0.6
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: sourceSize.height * width / sourceSize.width
    }

    Image {
        id: refreshimg
        enabled: settings.isRunning ? true : false
        visible: settings.isRunning ? true : false
        source: "image://theme/icon-cover-sync"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
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

    CoverActionList {
        id: restartaction
        enabled: (settings.isRunning) ? false : true
        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
                settings.isRunning = true
                themepack.restartHomescreen()
            }
        }
    }

}
