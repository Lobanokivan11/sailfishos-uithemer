import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem
{
    property bool fontInstalled: false
    property bool iconInstalled: false

    signal uninstallRequested()

    id: themepackitem
    width: parent.width
    contentHeight: Theme.itemSizeSmall

    Rectangle { id: rect; anchors.fill: parent; visible: fontInstalled || iconInstalled; color: Theme.rgba(Theme.highlightBackgroundColor, 0.5) }

    Label {
        anchors {
            fill: parent
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
        }
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

        text: {
            var s = model.packDisplayName;
            var types = [];

            if(fontInstalled)
                types.push(qsTr("fonts"));

            if(iconInstalled)
                types.push(qsTr("icons"));

            if(types.length <= 0)
                return s;

            return s + " (" + types.join(", ") + ")";
        }
    }

    menu: ContextMenu {
        MenuItem { text: qsTr("Uninstall"); onClicked: uninstallRequested() }
    }
}
