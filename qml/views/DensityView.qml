import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0

SilicaFlickable
{
    id: densityview
    anchors.fill: parent
    contentHeight: content.height
    clip: true

    ConfigurationGroup {
        id: silica
        path: "/desktop/sailfish/silica"
        property real theme_pixel_ratio
        property real theme_icon_subdir
    }

    ConfigurationValue {
        id: themepixelratio
        key: "/desktop/sailfish/silica/theme_pixel_ratio"
    }

    ConfigurationValue {
        id: themeiconsubdir
        key: "/desktop/sailfish/silica/theme_icon_subdir"
    }

    PullDownMenu
    {
        MenuItem {
            text: qsTr("Restore Android DPI")
            visible: themepack.hasAndroidSupport

            onClicked: {
                remorsepopup.execute(qsTr("Restoring Android DPI"), function() {
                    themepack.restoreADPI();
                    notification.publish();

                    sladpi.value = themepack.droidDPI;
                });
            }
        }

        MenuItem {
            text: qsTr("Restore icon size")
            visible: themepack.getFileSize("harbour-themepacksupport/icon-z") > 0

            onClicked: {
                remorsepopup.execute(qsTr("Restoring icon size"), function() {
                    themepack.restoreIZ();
                    notification.publish();

                    sliz.value = themeiconsubdir.value;
                });
            }
        }

        MenuItem {
            text: qsTr("Restore device pixel ratio")

            onClicked: {
                remorsepopup.execute(qsTr("Restoring device pixel ratio"), function() {
                    themepack.restoreDPR();
                    notification.publish();

                    sldpr.value = themepixelratio.value;
                });
            }
        }
    }

    Column
    {
        id: content
        width: parent.width
        spacing: Theme.paddingMedium

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

            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Change the display pixel ratio. To a smaller value corresponds an higher density.<br><br>Remember to restart the homescreen right after.")
            }
        }

        Column
        {
            id: coliz
            width: parent.width
            visible: themepack.getFileSize("harbour-themepacksupport/icon-z") > 0

            Slider {
                id: sliz
                width: parent.width
                label: qsTr("Icon size")
                maximumValue: 2.0
                minimumValue: 1.0
                stepSize: 0.25
                value: silica.theme_icon_subdir
                valueText: value
                onPressAndHold: cancel()

                onReleased: {
                    silica.theme_icon_subdir = value;
                }
            }

            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Change the size of UI icons. To a greater value corresponds an huger size.<br><br>Remember to restart the homescreen right after.")
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
                onReleased: themepack.applyADPI(valueText)
                onPressAndHold: cancel()
            }

            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Change the Android DPI value. To a smaller value corresponds an higher density.<br><br>Remember to restart the Android support or the homescreen right after.")
            }
        }
    }
}
