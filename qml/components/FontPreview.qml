import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    height: previewlabel.height
    width: parent.width

FontLoader {
    id: previewfont
    source: "/usr/share/" + packName + "/font/" + selectedFont + ".ttf"
}

Label {
    id: previewlabel
    width: parent.width - (x * 2)
    x: Theme.paddingLarge
    height: 350
    font.family: previewfont.name
    font.weight: selectedFont
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas imperdiet finibus venenatis. Suspendisse mollis urna sed luctus sodales."
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    wrapMode: Text.WordWrap
    truncationMode: TruncationMode.Fade
}

}
