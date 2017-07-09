import QtQuick 2.0
import Sailfish.Silica 1.0

    
    Label {
        id: smallheader
        width: parent.width
        y: Theme.paddingHuge
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignRight
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeMedium * 1.1
        anchors {
            left: parent.left
            right: parent.right
            rightMargin: Theme.paddingLarge
        }
    }
