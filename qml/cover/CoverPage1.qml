import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import org.nemomobile.configuration 1.0
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
        source: "image://theme/graphic-busyindicator-medium"
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
        enabled: ((settings.activeIconPack === "none") || (settings.isRunning)) ? false : true
        CoverAction {
            iconSource: switch (conf.coverAction1) {
                        case 0:
                            return "image://theme/icon-cover-sync";
                        case 1:
                            return "image://theme/icon-cover-refresh";
                        case 2:
                            return "image://theme/icon-cover-cancel";
                        }
            onTriggered: {
                settings.isRunning = true
                switch (conf.coverAction1) {
                case 0:
                    return themepackmodel.reapplyIcons();
                case 1:
                    return themepack.restartHomescreen();
                case 2:
                    themepackmodel.ocr();
                    settings.deactivateFont();
                    settings.deactivateIcon();
                    break;
                }
            }
        }
    }

}
