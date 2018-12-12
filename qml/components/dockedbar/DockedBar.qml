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
    opacity: busyindicator.running ? 0.3 : 1.0

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
                   pageStack.replaceAbove(null, Qt.resolvedUrl("../../pages/MainPage.qml"), null, PageStackAction.Immediate);
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
                    pageStack.replaceAbove(null, Qt.resolvedUrl("../../pages/DensityPage.qml"), null, PageStackAction.Immediate);
                }
            }
        }

        Item {
            width: dockedbar.width/3
            height: Theme.itemSizeLarge
            IconButton {
                anchors.centerIn: parent
                icon.source: "image://theme/icon-m-developer-mode"
                onClicked: {
                    pageStack.replaceAbove(null, Qt.resolvedUrl("../../pages/OptionsPage.qml"), null, PageStackAction.Immediate);
                }
            }
        }
    }
}
