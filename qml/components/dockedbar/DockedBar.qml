import QtQuick 2.0
import Sailfish.Silica 1.0
import ".."

Item
{
    readonly property var currentPage: pageStack.currentPage

    id: dockedbar
    height: Theme.itemSizeLarge
    enabled: !busyindicator.running
    opacity: busyindicator.running ? 0.0 : 1.0

    BackgroundRectangle { anchors.fill: parent }

    IconButton
    {
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            margins: Theme.paddingLarge
        }

        icon.source: "image://theme/icon-m-file-image"

        onClicked: {
            loader.source = Qt.resolvedUrl("../themepacklistview/ThemePackListView.qml");
        }
    }

    IconButton
    {
        anchors { centerIn: parent; verticalCenter: parent.verticalCenter; margins: Theme.paddingLarge }
        icon.source: "image://theme/icon-m-display"

        onClicked: {
            loader.source = Qt.resolvedUrl("../../views/DensityView.qml");
        }
    }

    IconButton
    {
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            margins: Theme.paddingLarge
        }

        icon.source: "image://theme/icon-m-menu"

        onClicked: {
            loader.source = Qt.resolvedUrl("../../views/ToolsView.qml");
        }
    }
}
