import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import "../components"

Page {
    id: page

    Notification {
         id: notification
         category: "x-nemo.uithemer"
         appName: "UI Themer"
         appIcon: "image://theme/icon-s-installed"
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

    RemorsePopup {
        id: remorsedisable;
        onTriggered: {
            iconpack.disable_service();
            settings.autoupd = false;
            disabletimer.enabled = settings.autoupd;
            notification.publish();
        }
   }

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

            ButtonLayout {
        Button {
            id: settimer
            text: qsTr("Set")
            onClicked: {
                var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog", {
                    hourMode: DateTime.TwentyFourHours
                })
                dialog.accepted.connect(function() {
                    iconpack.apply_hours(dialog.timeText);
                    settings.autoupd = true;
                    disabletimer.enabled = settings.autoupd;
                    notification.publish();
                })
            }
        }

        Button {
            id: disabletimer
            text: qsTr("Disable")
            enabled: settings.autoupd
            onClicked: remorsedisable.execute(qsTr("Disabling Icon updater..."))
        }
}
        Placeholder { }

    }
}
}
