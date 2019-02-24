import QtQuick 2.0
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0

Item {
    property alias icon: icon.source
    property alias label: label.text

    width: parent.width
    height: label.height + Theme.paddingSmall

    Image {
        id: icon
        anchors {
            left: parent.left
            leftMargin: Theme.paddingMedium
            rightMargin: Theme.paddingMedium
            verticalCenter: parent.verticalCenter
        }
        width: Theme.iconSizeSmall
        height: Theme.iconSizeSmall
        visible: false
    }

    ColorOverlay {
        anchors.fill: icon
        source: icon
        color: Theme.highlightColor
    }

    Label {
        id: label
        anchors {
            right: parent.right
            left: icon.right
            leftMargin: Theme.paddingMedium
            rightMargin: Theme.paddingMedium
            verticalCenter: parent.verticalCenter
        }
        x: Theme.paddingSmall
        width: parent.width - (x * 2)
        font.pixelSize: Theme.fontSizeMedium
        color: Theme.highlightColor
        wrapMode: Text.Wrap
    }

}
