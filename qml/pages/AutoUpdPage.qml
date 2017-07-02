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

    RemorsePopup {
        id: remorseenable;
        onTriggered: {
            iconpack.enable_service()
            notification.publish();
        }
   }

    RemorsePopup {
        id: remorsedisable;
        onTriggered: {
            iconpack.disable_service()
            notification.publish();
        }
   }

    RemorsePopup {
        id: remorsehours;
        onTriggered: {
            iconpack.apply_hours(hoursvalue.text);
            hoursvalue.focus = false;
            hoursvalue.text = "";
            notification.publish();
        }
   }

    Column {
        id: content
            width: parent.width
            spacing: Theme.paddingLarge
            PageHeader { title: qsTr("Icon updater") }

            Label {
                 x: Theme.paddingLarge
                 width: parent.width - 2 * Theme.paddingLarge
                 wrapMode: Text.Wrap
                 textFormat: Text.RichText
                 text: qsTr("When an app is updated, you will need to re-apply the theme in order to get the custom icon back. The Icon updater will automate this process, enabling automatic update of icons at a given time.<br><br>Note: You can set the hours of your choice in the form below. Type them in the format hh:mm separated by a comma, eg <i>06:00,18:20</i> and press enter.")
             }

            Placeholder { }

        TextField {
            width: parent.width
            id: hoursvalue
            placeholderText: qsTr("Hours")
            text: iconpack.getTimer()
            label: qsTr("Insert hours")
//            validator: RegExpValidator { regExp: /(\d{2})([,:]\d{2})?$/ }
            color: errorHighlight? Theme.secondaryColor : Theme.primaryColor
            EnterKey.enabled: text.length > 4
            EnterKey.iconSource: "image://theme/icon-m-enter-accept"
            EnterKey.onClicked: remorsehours.execute(qsTr("Updating timer..."))
        }

        Button {
            width: Theme.buttonWidthLarge
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Enable Icon updater")
            onClicked: remorseenable.execute(qsTr("Enabling Icon updater..."))
            }
        Button {
            width: Theme.buttonWidthLarge
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Disable Icon updater")
            onClicked: remorsedisable.execute(qsTr("Disabling Icon updater..."))
        }

        Placeholder { }

    }
}
}
