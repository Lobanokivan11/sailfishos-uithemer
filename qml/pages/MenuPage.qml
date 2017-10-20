import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"



Page {
    id: page

    DockedPanel {
        id: panel
        open: true
        animationDuration: 0
        onOpenChanged: if (!open) show()
        width: page.isPortrait ? parent.width : Theme.itemSizeLarge
        height: page.isPortrait ? Theme.itemSizeLarge : parent.height
        dock: page.isPortrait ? Dock.Bottom : Dock.Right

            IconButton {
                anchors {
                    left: page.isPortrait ? parent.left : undefined
                    top: page.isPortrait ? undefined : parent.top
                    horizontalCenter: page.isPortrait ? undefined : parent.horizontalCenter
                    verticalCenter: page.isPortrait ? parent.verticalCenter : undefined
                    margins: Theme.paddingLarge
                }
                icon.source: "image://theme/icon-m-file-image"
                onClicked: pageStack.replace("MainPage.qml",{},PageStackAction.Immediate)
                enabled: true
            }
            IconButton {
                anchors {
                    centerIn: parent
                    verticalCenter: parent.verticalCenter
                    margins: Theme.paddingLarge
                }
                icon.source: "image://theme/icon-m-display"
                onClicked: pageStack.replace("DdensityPage.qml",{},PageStackAction.Immediate)
                enabled: true
            }
            IconButton {
                anchors {
                    right: page.isPortrait ? parent.right : undefined
                    bottom: page.isPortrait ? undefined : parent.bottom
                    horizontalCenter: page.isPortrait ? undefined : parent.horizontalCenter
                    verticalCenter: page.isPortrait ? parent.verticalCenter : undefined
                    margins: Theme.paddingLarge
                }
                icon.source: "image://theme/icon-m-menu"
                onClicked: pageStack.replace("MenuPage.qml",{},PageStackAction.Immediate)
                enabled: false
            }
    }

    ListModel {
        id: pagesModel

        ListElement {
            title: qsTr("Icon updater")
            page: "AutoUpdPage.qml"
        }
        ListElement {
            title: qsTr("Tools")
            page: "Tools.qml"
        }
        ListElement {
            title: qsTr("Usage guide")
            page: "Guide.qml"
        }
        ListElement {
            title: qsTr("About UI Themer")
            page: "About.qml"
        }
    }
    SilicaListView {
        id: listView
        anchors {
            fill: parent
            bottomMargin: page.isPortrait ? panel._visibleSize() : 0
            rightMargin: page.isPortrait ? 0 : panel._visibleSize()
        }
        clip: panel.expanded
        model: pagesModel
        header: PageHeader { title: qsTr("More")}

        delegate: BackgroundItem {
            width: listView.width
            Label {
                id: firstName
                text: model.title
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
            }
            onClicked: pageStack.push(Qt.resolvedUrl(page))
        }

        VerticalScrollDecorator {}
    }

}
