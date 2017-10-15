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

    ConfigurationValue {
        id: themepixelratiovalue
        key: "/desktop/sailfish/silica/theme_pixel_ratio"
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

    onStatusChanged: {
        if (status === PageStatus.Active && pageStack.depth === 1) {
            pageStack.pushAttached("HomePage.qml", {});
        }
    }

    SilicaFlickable {
    anchors.fill: parent
    VerticalScrollDecorator { }
    contentHeight: content.height
    RemorsePopup { id: remorsedpr; onTriggered: {
            iconpack.restore_dpr();
            notification.publish();
            dpr_slider.value = themepixelratiovalue.value
            dpr_slider.valueText = dpr_slider.value
        }
    }
    RemorsePopup { id: remorseradpi; onTriggered: {
            iconpack.restore_adpi()
            adpi_slider.value = iconpack.getDroidDPI()
            adpi_slider.valueText = adpi_slider.value
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
            PageHeader { title: qsTr("Display density") }

            SectionHeader { text: qsTr("Device pixel ratio") }
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

            SectionHeader { text: qsTr("Android DPI") }
            Slider {
                id: adpi_slider
                width: parent.width
                label: qsTr("Android DPI value")
                maximumValue: 360
                minimumValue: 180
                stepSize: 20
                value: iconpack.getDroidDPI()
                valueText: value
                onReleased: iconpack.apply_adpi(value)
                onPressAndHold: cancel()
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
