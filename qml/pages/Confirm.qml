import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../js/db.js" as DB
import "../js/functions.js" as Func
import "../components"


/*
 This is a dialog, which just tells user what will happen, if user clicks Yes, MainPage.qml handles it and takes action
 */
Dialog {
    id: page
    property string iconpack
    property string name: ip.getName(iconpack)
    property var capabilities: Func.getCapabilities();
    property var fonts: capabilities.fonts
    property bool icons: capabilities.icons
    property string font_active_sailfish

    // these properties are handed from MainPage, at default state they copy the capabilities, but when changed, they overwrite capabilities
    property bool input_fonts: capabilities.fonts
    property bool input_icons: capabilities.icons
    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height
        width: parent.width
        Column {
            id: column
            width: parent.width
            DialogHeader {
                id: header
                acceptText: qsTr("Apply")
                cancelText: qsTr("Cancel")
            }
            Label {
                width: parent.width - Theme.paddingLarge * 2
                x: Theme.paddingLarge
                text: qsTr("Do you want to apply <b>%1</b>? The UI may not respond for a while, do NOT close the app.<br><br>Remember to restart the homescreen right after.<br>").arg(name)
                textFormat: Text.RichText
                wrapMode: Text.Wrap
            }
            IconTextSwitch {
                id: include_icons
                automaticCheck: true
                text: qsTr("Install icons from theme")
                checked: true
                enabled: capabilities.icons
                onClicked: {
                    icons = include_icons.checked
                    if(!include_fonts.checked && !include_icons.checked) {
                        header.acceptText = qsTr("Cancel");
                    } else {
                        header.acceptText = qsTr("Apply");
                    }
                }
            }

            IconTextSwitch {
                id: include_fonts
                automaticCheck: true
                text: qsTr("Install fonts from theme")
                checked: true
                enabled: capabilities.fonts
                onClicked: {
                    fonts = include_fonts.checked
                    if(!include_fonts.checked && !include_icons.checked) {
                        header.acceptText = qsTr("Cancel");
                    } else {
                        header.acceptText = qsTr("Apply");
                    }
                }
            }

            Column {
                id: fontsettings
                width: parent.width
                visible: include_fonts.checked && include_fonts.enabled

                Placeholder { }

                Button {
                    text: preview.visible?qsTr("Hide font preview"):qsTr("Show font preview")
                    x: parent.width / 2 - width / 2
                    onClicked: {
                        preview.visible = !preview.visible
                    }
                }

                FontLoader {
                    id: previewfont
                    source: "/usr/share/harbour-themepack-"+iconpack+"/font/"+ip.weights(iconpack)[0];
                    Component.onCompleted: {
                        console.log(source);
                    }
                }

                Placeholder {
                    visible: preview.visible
                }

                Label {
                    id: preview
                    visible: false
                    font.family: previewfont.name
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas non convallis lectus, vitae."
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width - Theme.paddingLarge * 2
                    x: Theme.paddingLarge
                    wrapMode: Text.WordWrap
                }

                Placeholder { }

                SectionHeader {
                    text: qsTr("Font weight")
                }

                ListModel { // weight model, sailfish
                    id: wmodels
                }

                Repeater {
                    id: views
                    model: wmodels
                    IconTextSwitch {
                        automaticCheck: true
                        text: w_name
                        checked: w_checked
                        onClicked: {
                            var count = wmodels.count;
                            for(var i = 0; i < count; i++) {
                                views.itemAt(i).checked = false;
                            }
                            checked = true;
                            font_active_sailfish = text;
                        }
                    }
                }


                Placeholder { }

                Component.onCompleted:  {
                    var weights = Func.getWeights();
                    for(var i in weights) {
                        var w_checked = i == 0;
                        var w_name = weights[i];
                        if(i == 0) {
                            font_active_sailfish = w_name;
                        }

                        wmodels.append({w_checked: w_checked, w_name: w_name});
                    }
                }
            }

            Component.onCompleted: {

                if(capabilities.fonts != input_fonts) {
                    console.log("Fonts capabilities changed");
                    capabilities.fonts = input_fonts;
                    include_fonts.enabled = capabilities.fonts;
                }

                if(capabilities.icons != input_icons) {
                    console.log("Icons capabilities changed");
                    capabilities.icons = input_icons;
                    include_icons.enabled = capabilities.icons;
                }

                console.log("Fonts: "+capabilities.fonts);
                console.log("Icons: "+capabilities.icons);

                if(!capabilities.fonts) {
                    fonts = false;
                    include_fonts.checked = false;
                }
                if(!capabilities.icons) {
                    icons = false;
                    include_icons.checked = false;
                }

                if(!include_fonts.checked && !include_icons.checked) {
                    header.acceptText = qsTr("Cancel");
                } else {
                    header.acceptText = qsTr("Apply");
                }
            }
        }
    }
}
