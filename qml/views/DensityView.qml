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
        property real icon_size_launcher
    }

    PullDownMenu
    {

        MenuItem {
            text: qsTr("Restore icon size")
            onClicked: {
                themepack.restoreIZ();
                cbiz.value = silica.icon_size_launcher;
            }
        }

        MenuItem {
            text: qsTr("Restore Android DPI")
            visible: themepack.hasAndroidSupport
            onClicked: {
                themepack.restoreADPI();
                sladpi.value = themepack.droidDPI;
            }
        }

        MenuItem {
            text: qsTr("Restore device pixel ratio")

            onClicked: {
                themepack.restoreDPR();
                sldpr.value = silica.theme_pixel_ratio;
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

            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Change the size of UI icons. To a greater value corresponds an huger size.<br><br>Remember to restart the homescreen right after.")
            }
        }

    }
}
