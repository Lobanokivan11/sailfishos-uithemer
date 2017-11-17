import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import "../../components"
import org.nemomobile.configuration 1.0

Page
{
    property ThemePack themePack

    id: iconupdaterpage

    ConfigurationGroup {
        id: autoupd
        path: "/desktop/lipstick/sailfishos-uithemer"
        property bool homeRefresh: true
        property int autoUpdate: 0
    }

    SilicaFlickable
    {
        anchors.fill: parent
        anchors.bottomMargin: Theme.paddingLarge
        contentHeight: content.height

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader { title: qsTr("Icon updater") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Everytime an app is updated, you need to re-apply the theme in order to get the custom icon back. The Icon updater will automate this process, enabling automatic update of icons at a given time.")
            }

            ComboBox {
                function applyUpdater(setting, hours) {
                    autoupd.autoUpdate = setting;

                    if(setting === 0)
                        themePack.disableService();
                    else
                        themePack.applyHours(hours);
                }

                function applyDaily() {
                    var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog", { hourMode: DateTime.TwentyFourHours });
                    dialog.accepted.connect(function() { cbxupdate.applyUpdater(7, dialog.timeText); });
                }

                id: cbxupdate
                width: parent.width
                label: qsTr("Update icons")
                currentIndex: autoupd.autoUpdate

                menu: ContextMenu {
                    MenuItem { text: qsTr("Disabled"); onClicked: cbxupdate.applyUpdater(0) }
                    MenuItem { text: qsTr("30 minutes"); onClicked: cbxupdate.applyUpdater(1, 30) }
                    MenuItem { text: qsTr("1 hour"); onClicked: cbxupdate.applyUpdater(2, 1) }
                    MenuItem { text: qsTr("2 hours"); onClicked: cbxupdate.applyUpdater(3, 2) }
                    MenuItem { text: qsTr("3 hours"); onClicked: cbxupdate.applyUpdater(4, 3) }
                    MenuItem { text: qsTr("6 hours"); onClicked: cbxupdate.applyUpdater(5, 6) }
                    MenuItem { text: qsTr("12 hours"); onClicked: cbxupdate.applyUpdater(6, 12) }
                    MenuItem { text: qsTr("Daily"); onClicked: cbxupdate.applyDaily(); }
                }
            }
        }

        VerticalScrollDecorator { }
    }
}
