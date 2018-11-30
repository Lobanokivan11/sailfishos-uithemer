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
    font.family: previewfont.name
    font.weight: selectedFont
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    horizontalAlignment: Text.AlignHCenter
    wrapMode: Text.WordWrap
}

}
