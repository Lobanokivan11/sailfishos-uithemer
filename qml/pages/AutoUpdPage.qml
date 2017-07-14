import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page

    SilicaFlickable {
    anchors.fill: parent
    VerticalScrollDecorator { }
    contentHeight: content.height

    Column {
        id: content
            width: parent.width
            PageHeader { title: qsTr("Icon updater") }

            Label {
                 x: Theme.paddingLarge
                 width: parent.width - 2 * Theme.paddingLarge
                 wrapMode: Text.Wrap
                 textFormat: Text.RichText
                 text: qsTr("Everytime an app is updated, you need to re-apply the theme in order to get the custom icon back. The Icon updater will automate this process, enabling automatic update of icons at a given time.")
             }

            Placeholder { height: 60 }

            ComboBox {
                width: parent.width
                label: qsTr("Update icons")
                currentIndex: settings.autoupd
                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("Disabled")
                        onClicked: {
                            settings.autoupd = 0;
                            iconpack.disable_service();
                        }
                    }
                    MenuItem {
                        text: qsTr("30 minutes")
                        onClicked: {
                            settings.autoupd = 1;
                            iconpack.apply_hours(30);
                        }
                    }
                    MenuItem {
                        text: qsTr("1 hour")
                        onClicked: {
                            settings.autoupd = 2;
                            iconpack.apply_hours(1);
                        }
                    }
                    MenuItem {
                        text: qsTr("2 hours")
                        onClicked: {
                            settings.autoupd = 3;
                            iconpack.apply_hours(2);
                        }
                    }
                    MenuItem {
                        text: qsTr("3 hours")
                        onClicked: {
                            settings.autoupd = 4;
                            iconpack.apply_hours(3);
                        }
                    }
                    MenuItem {
                        text: qsTr("6 hours")
                        onClicked: {
                            settings.autoupd = 5;
                            iconpack.apply_hours(6);
                        }
                    }
                    MenuItem {
                        text: qsTr("12 hours")
                        onClicked: {
                            settings.autoupd = 6;
                            iconpack.apply_hours(12);
                        }
                    }
                    MenuItem {
                        text: qsTr("Daily")
                        onClicked: {
                            var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog", {
                                                            hourMode: DateTime.TwentyFourHours
                                                        })
                            dialog.accepted.connect(function() {
                                iconpack.apply_hours(dialog.timeText);
                                settings.autoupd = 7;
                            })
                        }
                    }
                }
            }
            Placeholder { }
    }
    }
}
