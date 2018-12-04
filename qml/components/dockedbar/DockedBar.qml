import QtQuick 2.0
import Sailfish.Silica 1.0
import ".."

Item
{
    readonly property var currentPage: pageStack.currentPage

    id: dockedbar
    width: parent.width
    height: Theme.itemSizeLarge
    enabled: !busyindicator.running
    opacity: busyindicator.running ? 0.0 : 1.0

    Separator {
        id: dockedbarSeparator
        width: parent.width
        color: Theme.primaryColor
        horizontalAlignment: Qt.AlignHCenter
    }

    BackgroundRectangle { anchors.fill: parent }

    Row {
        Item {
            width: dockedbar.width/3
            height: Theme.itemSizeLarge
            IconButton {
                anchors.centerIn: parent
                icon.source: "image://theme/icon-m-home"
                onClicked: {
                    loader.source = Qt.resolvedUrl("../themepacklistview/ThemePackListView.qml");
                }
            }
        }

        Item {
            width: dockedbar.width/3
            height: Theme.itemSizeLarge
            IconButton {
                anchors.centerIn: parent
                icon.source: "image://theme/icon-m-scale"
                onClicked: {
                    loader.source = Qt.resolvedUrl("../../views/DensityView.qml");
                }
            }
        }

        Item {
            width: dockedbar.width/3
            height: Theme.itemSizeLarge
            IconButton {
                anchors.centerIn: parent
                icon.source: "image://theme/icon-m-menu"
                onClicked: {
                    loader.source = Qt.resolvedUrl("../../views/ToolsView.qml");
                }
            }
        }
    }
}
