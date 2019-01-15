import QtQuick 2.0
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0

Item {
    property alias icon: icon.source
    property alias label: label.text

    width: parent.width
    height: rect.height

    Image {
        id: icon
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        width: Theme.iconSizeSmallPlus
        height: Theme.iconSizeSmallPlus
        visible: false
    }

    ColorOverlay {
        anchors.fill: icon
        source: icon
        color: Theme.highlightColor
    }

    Rectangle {
        id: rect
        anchors {
            right: parent.right
            left: icon.right
            leftMargin: Theme.paddingSmall
            verticalCenter: parent.verticalCenter
        }
        width: childrenRect.width
        height: childrenRect.height
        radius: Theme.paddingSmall/2
        color: Theme.rgba(Theme.highlightBackgroundColor, 0.5)

    Label {
        id: label
        x: Theme.paddingSmall
        width: parent.width - (x * 2)
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.highlightColor
        wrapMode: Text.Wrap
    }
    }

}
