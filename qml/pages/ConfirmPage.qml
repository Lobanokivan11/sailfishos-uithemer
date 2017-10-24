import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import "../common"

Dialog
{
    property Settings settings
    property ThemePackModel themePackModel
    property int themePackIndex

    property bool hasIcons: themePackModel.hasIcons(themePackIndex)
    property bool hasFont: themePackModel.hasFont(themePackIndex)
    property string packDisplayName: themePackModel.packDisplayName(themePackIndex)
    property string packName: themePackModel.packName(themePackIndex)
    property alias iconsSelected: itsicons.checked
    property alias fontsSelected: itsfonts.checked
    property string selectedFont: hasFont ? fontweightmodel.firstWeight: ""

    id: confirmpage

    onAccepted: {
        settings.homeRefresh = tshomerefresh.checked;
    }

    FontWeightModel { id: fontweightmodel; packName: confirmpage.packName }

    SilicaFlickable
    {
        id: flickable
        anchors.fill: parent
        anchors.bottomMargin: Theme.paddingLarge
        contentHeight: content.height
        width: parent.width

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingMedium

            DialogHeader { id: header; acceptText: qsTr("Apply"); cancelText: qsTr("Cancel") }

            Label {
                width: parent.width - (x * 2)
                x: Theme.paddingLarge
                text: qsTr("Do you want to apply <b>%1</b>?<br><br>Remember to restart the homescreen right after.<br>").arg(packDisplayName)
                textFormat: Text.RichText
                wrapMode: Text.Wrap
            }

            TextSwitch { id: tshomerefresh; text: qsTr("Restart homescreen"); checked: settings.homeRefresh }

            IconTextSwitch {
                id: itsicons
                automaticCheck: true
                text: qsTr("Install icons from theme")
                checked: hasIcons
                enabled: hasIcons

                onClicked: {
                    iconsSelected = itsicons.checked;

                    if(!itsfonts.checked && !itsicons.checked)
                        header.acceptText = qsTr("Cancel");
                    else
                        header.acceptText = qsTr("Apply");
                }
            }

            IconTextSwitch {
                id: itsfonts
                automaticCheck: true
                text: qsTr("Install fonts from theme")
                checked: hasFont
                enabled: hasFont

                onClicked: {
                    fontsSelected = itsfonts.checked;

                    if(!itsfonts.checked && !itsicons.checked)
                        header.acceptText = qsTr("Cancel");
                    else
                        header.acceptText = qsTr("Apply");
                }
            }

            Column {
                id: fontsettings
                width: parent.width
                visible: itsfonts.checked && itsfonts.enabled
                spacing: Theme.paddingMedium

                Button {
                    text: preview.visible ? qsTr("Hide font preview") : qsTr("Show font preview")
                    x: parent.width / 2 - width / 2

                    onClicked: {
                        preview.visible = !preview.visible;

                        if(preview.visible)
                            previewfont.source = "/usr/share/" + packName + "/font/" + fontweightmodel.firstWeightFont;
                    }
                }

                FontLoader { id: previewfont }

                Label {
                    id: preview
                    x: Theme.paddingLarge
                    width: parent.width - (x * 2)
                    visible: false
                    font.family: previewfont.name
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas non convallis lectus, vitae."
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }

                SectionHeader { text: qsTr("Font weight") }

                Repeater {
                    id: views
                    model: fontweightmodel

                    delegate: IconTextSwitch {
                        automaticCheck: true
                        text: model.fontDisplayWeight
                        checked: model.index === 0

                        onClicked: {
                            var count = views.count;

                            for(var i = 0; i < views.count; i++)
                                views.itemAt(i).checked = false;

                            checked = true;
                            selectedFont = model.fontWeight;
                        }
                    }
                }
            }
        }
    }
}
