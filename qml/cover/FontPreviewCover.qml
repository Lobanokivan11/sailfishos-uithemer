import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    width: parent.width
    height: previewlabel.height

FontLoader {
    id: previewfont
    source: "/usr/share/" + pageStack.currentPage.packName + "/font/" + pageStack.currentPage.selectedFont + ".ttf"
}

Label {
    id: previewlabel
    width: parent.width - (x * 2)
    x: Theme.paddingLarge
    font.family: previewfont.name
    font.weight: pageStack.currentPage.selectedFont
    font.pixelSize: Theme.fontSizeExtraSmall
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas imperdiet finibus venenatis."
    verticalAlignment: Text.AlignVCenter
    wrapMode: Text.WordWrap
    truncationMode: TruncationMode.Fade
}

}
