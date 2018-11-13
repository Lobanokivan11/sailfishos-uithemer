import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"
import harbour.uithemer 1.0
import org.nemomobile.notifications 1.0
import org.nemomobile.configuration 1.0

Page
{
    id: welcomepage
    property bool vDep: false
    property bool vDon: false

    ThemePack { id: themepack; }
    BusyIndicator { id: busyindicator; running: false; size: BusyIndicatorSize.Large; anchors.centerIn: parent }
    Notification
    {
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

    Connections
    {
        function notify() {
            busyindicator.running = false;
            notification.publish();
            vDep = true
            installdep.enabled = false
            itsdep.enabled = false
        }

        target: themepack
        onDependenciesInstalled: notify()
    }

    ConfigurationGroup {
        id: conf
        path: "/desktop/lipstick/sailfishos-uithemer"
        property bool wizardDone: false
    }

    SilicaFlickable
    {
        anchors.fill: parent
        anchors.bottomMargin: Theme.paddingLarge
        contentHeight: content.height
        enabled: !busyindicator.running
        opacity: busyindicator.running ? 0.0 : 1.0

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader { title: qsTr("Welcome to UI Themer") }

            Item {
                height: appicon.height + Theme.paddingMedium
                width: parent.width

                Image { id: appicon; anchors.horizontalCenter: parent.horizontalCenter; source: "../../appinfo.png" }
            }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: qsTr("UI Themer lets you customize icons, fonts and pixel density in Sailfish OS.")
            }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                text: qsTr("UI Themer needs some additional dependencies in order to function properly. Install them now if you haven't already.")
            }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                text: qsTr("It may take a while, do not quit.")
            }

             Button {
                  id: installdep
                  anchors.horizontalCenter: parent.horizontalCenter
                  enabled: true
                  text: qsTr("Install dependencies")
                  onClicked: {
                      busyindicator.running = true;
                      themepack.installDependencies();
                  }
              }

            IconTextSwitch {
                id: itsdep
                enabled: true
                automaticCheck: true
                text: qsTr("I have already installed the dependencies")
                checked: false

                onClicked: {
                    if (itsdep.checked) {
                        installdep.enabled = false;
                        vDep = true;
                    } else {
                        installdep.enabled = true;
                        vDep = false;
                    }
                }
            }

            SectionHeader { text: qsTr("Support") }

            Label {
                x: Theme.paddingLarge
                width: parent.width - (x * 2)
                wrapMode: Text.Wrap
                text: qsTr("If you like my work and want to buy me a beer, feel free to do it!")
            }

            Button {
                id: donate
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Donate")
                onClicked: {
                    Qt.openUrlExternally("https://www.paypal.me/fravaccaro");
                    vDon = true
                    itsdon.enabled = false
                }
            }

            IconTextSwitch {
                id: itsdon
                enabled: true
                automaticCheck: true
                text: qsTr("I don't care donating")
                checked: false

                onClicked: {
                    if (itsdon.checked) {
                        donate.enabled = false;
                        vDon = true;
                    } else {
                        donate.enabled = true;
                        vDon = false;
                    }
                }
            }

             Button {
                  id: startuit
                  anchors.horizontalCenter: parent.horizontalCenter
                  enabled: vDep && vDon
                  text: qsTr("Start UI Themer")
                  onClicked: {
                      conf.wizardDone = true;
                      pageStack.replace("MainPage.qml");
                  }
              }
        }

        VerticalScrollDecorator { }
    }
}
