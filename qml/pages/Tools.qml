import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import "../components"

Page {
    id: page
    backNavigation: !busyindicator.running
    showNavigationIndicator: !busyindicator.running

    BusyIndicator {
        id: busyindicator
        running: false
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
    }

    Connections
    {
        target: iconpack

        onIconsRestored: {
            busyindicator.running = false;
            notification.publish();
        }

        onFontsRestored: {
            busyindicator.running = false;
            notification.publish();
        }
    }

    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height
        enabled: !busyindicator.running
        opacity: busyindicator.running ? 0.0 : 1.0

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

    RemorsePopup { id: remorsehs; onTriggered: iconpack.restart_homescreen() }

    RemorsePopup { id: reicons; onTriggered: {
            busyindicator.running = true;
            iconpack.reinstall_icons();
        }
    }
    RemorsePopup { id: refonts; onTriggered: {
            busyindicator.running = true;
            iconpack.reinstall_fonts();
        }
    }

        Column {
            id: column
            width: parent.width
            PageHeader {
                title: qsTr("Tools")
            }
            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Here you can find some recovery tools in case anything goes wrong (eg if you forget to restore the default theme before performing a system update).<br><br>Remember to restart the homescreen right after.")
            }

            Placeholder { }

            SectionHeader {
                text: qsTr("Restart homescreen")
            }
            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Restart the homescreen, to make your modifications effective. Your currently opened apps will be closed.")
            }

            Placeholder { }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Restart")
                onClicked: {
                    remorsehs.execute(qsTr("Restarting homescreen"))
                }
            }

            Placeholder { }

            SectionHeader {
                text: qsTr("Icons")
            }
            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("If any error occurs during themes applying/restoring, you can end up with messed up icons. From here, you can reinstall default Jolla app icons while, for thirdy party apps, you may need to reinstall/update apps to restore the default look.")
            }

            Placeholder { }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Reinstall icons")
                onClicked: {
                    reicons.execute(qsTr("Reinstalling icons"))
                }
            }

            Placeholder { }

                  SectionHeader {
                      text: qsTr("Fonts")
                  }
            Label {
                x: Theme.paddingLarge
                width: parent.width - 2 * Theme.paddingLarge
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("Reinstall default fonts, if font applying/restoring fails.")
            }

            Placeholder { }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Reinstall fonts")
                onClicked: {
                    refonts.execute(qsTr("Reinstalling fonts"))
                }
            }

              Placeholder { }

        }
		VerticalScrollDecorator {}
    }
}
