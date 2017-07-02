import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import org.nemomobile.configuration 1.0
import "../components"

Page {
    id: page
    ConfigurationGroup {
    id: silica
    path: "/desktop/sailfish/silica"
    property real theme_pixel_ratio
    }
    Notification {
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
    SilicaFlickable {
    anchors.fill: parent
    VerticalScrollDecorator { }
    contentHeight: content.height
    RemorsePopup { id: remorsedpr; onTriggered: {
            iconpack.restore_dpr();
            notification.publish();
        }
    }
    RemorsePopup {
        id: remorseadpi;
        onTriggered: {
            iconpack.apply_adpi(adpivalue.text);
            adpivalue.focus = false;
            adpivalue.text = "";
            notification.publish();
        }
   }
    RemorsePopup { id: remorseradpi; onTriggered: {
            iconpack.restore_adpi()
            notification.publish();
        }
    }
    PullDownMenu {
        MenuItem {
            text: qsTr("Restore Android DPI")
            onClicked: remorseradpi.execute(qsTr("Restoring Android DPI"))
        }
        MenuItem {
            text: qsTr("Restore device pixel ratio")
            onClicked: remorsedpr.execute(qsTr("Restoring device pixel ratio"))
        }
    }

    Column {
        id: content
            width: parent.width
            spacing: Theme.paddingLarge
            PageHeader { title: qsTr("Device pixel ratio") }
                    Slider {
                        id: dpr_slider
                        width: parent.width
                        label: qsTr("Device pixel ratio")
                        maximumValue: 2.3
                        minimumValue: 0.7
                        stepSize: 0.05
                        value: silica.theme_pixel_ratio
                        valueText: value
                        onReleased: silica.theme_pixel_ratio = value
                        onPressAndHold: cancel()
                    }

                Label {
                    x: Theme.paddingLarge
                    width: parent.width - 2 * Theme.paddingLarge
                    wrapMode: Text.Wrap
                    textFormat: Text.RichText
                    text: qsTr("Change the display pixel ratio. To a smaller value corresponds an higher density.<br><br>Remember to restart the homescreen right after.")
                }

                Placeholder { }

            PageHeader { title: qsTr("Android DPI") }
        TextField {
            width: parent.width
            id: adpivalue
            placeholderText: qsTr("Android DPI value")
            text: iconpack.getDroidDPI()
            label: qsTr("Android DPI value")
            validator: RegExpValidator { regExp: /^[0-9\ ]{3,}$/ }
            color: errorHighlight? Theme.secondaryColor : Theme.primaryColor
            inputMethodHints: Qt.ImhDigitsOnly
            EnterKey.enabled: text.length > 2
            EnterKey.iconSource: "image://theme/icon-m-enter-accept"
            EnterKey.onClicked: remorseadpi.execute(qsTr("Applying Android DPI..."))
        }
               Label {
                    x: Theme.paddingLarge
                    width: parent.width - 2 * Theme.paddingLarge
                    wrapMode: Text.Wrap
                    textFormat: Text.RichText
                    text: qsTr("Change the Android DPI value. To a smaller value corresponds an higher density.<br><br>Remember to restart the Android support or the homescreen right after.")
                }

               Placeholder { }
            }
    }
}
