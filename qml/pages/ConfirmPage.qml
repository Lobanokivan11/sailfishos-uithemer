import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.uithemer 1.0
import "../common"
import "../components"

Dialog
{
    property Settings settings

    property ThemePackModel themePackModel
    property int themePackIndex

    property bool hasIcons: themePackModel.hasIcons(themePackIndex)
    property bool hasIconOverlay: themePackModel.hasIconOverlay(themePackIndex)
    property bool hasFont: themePackModel.hasFont(themePackIndex)
    property bool hasFontNonLatin: themePackModel.hasFontNonLatin(themePackIndex)
    property string packDisplayName: themePackModel.packDisplayName(themePackIndex)
    property string packName: themePackModel.packName(themePackIndex)
    property alias iconsSelected: itsicons.checked
    property alias iconOverlaySelected: itsiconoverlay.checked
    property alias fontsSelected: itsfonts.checked
    property string selectedFont: hasFont ? fontweightmodel.firstWeight: ""

    id: confirmpage
    focus: true
    canAccept: itsicons.checked || itsiconoverlay.checked || itsfonts.checked
    backNavigation: !busyindicator.running
    forwardNavigation: !busyindicator.running
    showNavigationIndicator: !busyindicator.running

    BusyState { id: busyindicator }

    onAccepted: {
        settings.homeRefresh = tshomerefresh.checked;
    }

    Component.onCompleted: {
        if (hasIcons || hasIconOverlay)
                themePackModel.iconsPreview(themePackIndex)
    }

    Connections {
        target: themePackModel
        onIconsPreviewed: {
            imgpreview.source = "/usr/share/harbour-themepacksupport/tmp/iconspreview.png"
            busyimg.running = false
        }
    }

    Keys.onPressed: {
        handleKeyPressed(event);
    }

    function handleKeyPressed(event) {

        if (event.key === Qt.Key_Down) {
            flickable.flick(0, - confirmpage.height);
            event.accepted = true;
        }

        if (event.key === Qt.Key_Up) {
            flickable.flick(0, confirmpage.height);
            event.accepted = true;
        }

        if (event.key === Qt.Key_PageDown) {
            flickable.scrollToBottom();
            event.accepted = true;
        }

        if (event.key === Qt.Key_PageUp) {
            flickable.scrollToTop();
            event.accepted = true;
        }

        if ((event.key === Qt.Key_B) || (event.key === Qt.Key_C)) {
            pageStack.navigateBack();
            event.accepted = true;
        }

        if (event.key === Qt.Key_Return) {
            confirmpage.accept();
            event.accepted = true;
        }

        if (event.key === Qt.Key_G) {
            pageStack.push(Qt.resolvedUrl("menu/GuidePage.qml"));
            event.accepted = true;
        }
    }

    FontWeightModel { id: fontweightmodel; packName: confirmpage.packName }

    SilicaFlickable
    {
        id: flickable
        anchors.fill: parent
        contentHeight: content.height
        width: parent.width
        enabled: !busyindicator.running
        opacity: busyindicator.running ? 0.0 : 1.0

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingMedium

            DialogHeader { id: header; cancelText: qsTr("Cancel"); acceptText: qsTr("Apply") }

            ConfirmHeader { text: "%1".arg(packDisplayName) }

            SectionHeader {
                text: qsTr("Icons")
                visible: hasIcons || hasIconOverlay
            }

            Column {
                id: iconpreview
                width: parent.width
                height: 450
                visible: hasIcons || hasIconOverlay
                spacing: Theme.paddingMedium
                BusyIndicator { id: busyimg; running: true; size: BusyIndicatorSize.Medium; anchors.centerIn: parent }
                Image {
                    id: imgpreview
                    height: 450
                    anchors.horizontalCenter: parent.horizontalCenter
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit
                    cache: false
                }

            }
            IconTextSwitch {
                id: itsicons
                automaticCheck: true
                text: qsTr("Apply icons")
                visible: hasIcons
                checked: hasIcons
                enabled: hasIcons
                onClicked: {
                    iconsSelected = itsicons.checked;

                    if(!itsfonts.checked && !itsicons.checked)
                        confirmpage.canAccept = false
                    else
                        confirmpage.canAccept = true
                }
            }
            IconTextSwitch {
                id: itsiconoverlay
                automaticCheck: true
                text: qsTr("Apply icon overlay")
                description: qsTr("Apply an overlay on icons not available in the theme.")
                visible: hasIconOverlay
                checked: hasIconOverlay
                enabled: hasIconOverlay && itsicons.checked
                onClicked: {
                    iconOverlaySelected = itsiconoverlay.checked;
                }
            }

            SectionHeader {
                text: qsTr("Fonts")
                visible: hasFont || hasFontNonLatin
            }

            Column {
                id: fontsettings
                width: parent.width
                visible: hasFont
                spacing: Theme.paddingMedium

                Column {
                    id: fontpreview
                    width: parent.width
                    height: 400

                Loader {
                    id: fontloader
                    source: "../components/FontPreview.qml"
                    width: parent.width
                    height: 400
                    visible: false

                    function reload() {
                        source = ""
                        source = "../components/FontPreview.qml"
                    }
                }

                Label {
                    id: vphfont
                    width: parent.width - (x * 2)
                    height: 400
                    x: Theme.paddingLarge
                    text: qsTr("Choose a font weight to preview")
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                    truncationMode: TruncationMode.Fade
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeLarge
                }

                }

                IconTextSwitch {
                    id: itsfonts
                    automaticCheck: true
                    text: qsTr("Apply fonts")
                    visible: hasFont || hasFontNonLatin
                    checked: hasFont || hasFontNonLatin
                    enabled: hasFont || hasFontNonLatin

                    onClicked: {
                        fontsSelected = itsfonts.checked;

                        if(!itsfonts.checked && !itsicons.checked)
                            confirmpage.canAccept = false
                        else
                            confirmpage.canAccept = true
                    }
                }

                SectionHeader { text: qsTr("Font weight") }

                LabelText {
                    text: qsTr("Choose the main font weight for the UI.")
                }

                Repeater {
                    id: views
                    model: fontweightmodel

                    delegate: IconTextSwitch {
                        automaticCheck: true
                        enabled: itsfonts.checked
                        text: model.fontDisplayWeight

                        onClicked: {
                            var count = views.count;

                            for(var i = 0; i < views.count; i++)
                                views.itemAt(i).checked = false;

                            checked = true;
                            selectedFont = model.fontWeight;
                            vphfont.visible = false
                            fontloader.visible = true
                            fontloader.reload()
                        }
                    }
                }
            }

                LabelText {
                    text: "<br>" + qsTr("Remember to restart the homescreen right after.")
                }

                TextSwitch { id: tshomerefresh; text: qsTr("Restart homescreen"); checked: settings.homeRefresh }

                Item {
                    width: 1
                    height: Theme.paddingLarge
                }
        }
    }
}
