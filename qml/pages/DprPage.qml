import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"
import org.nemomobile.configuration 1.0

Page {
    id: page
    ConfigurationGroup {
	id: silica
	path: "/desktop/sailfish/silica"
	property real theme_pixel_ratio
    }

    SilicaFlickable {
    anchors.fill: parent
    RemorsePopup { id: remorsedpr; onTriggered: iconpack.restore_dpr() }
    PullDownMenu {
        MenuItem {
            text: qsTr("Restore device pixel ratio")
            onClicked: remorsedpr.execute(qsTr("Restoring device pixel ratio..."))
        }
    }

    Column {
	    id: content
            width: parent.width
            spacing: Theme.paddingLarge
            PageHeader { title: qsTrId("Device pixel ratio") }
                    Slider {
                        id: dpr_slider
                        width: parent.width
                        label: qsTr("Device pixel ratio")
                        maximumValue: 2.0
                        minimumValue: 0.8
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

            }
    }
}
