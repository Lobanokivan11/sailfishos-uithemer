import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

SilicaListView
{
    id: menuview
    clip: true
    anchors.fill: parent
    anchors.bottomMargin: Theme.paddingLarge

    header: PageHeader { title: qsTr("More") }

    model: ListModel {
        ListElement { title: qsTr("Icon updater"); page: "IconUpdaterPage.qml" }
        ListElement { title: qsTr("Tools"); page: "ToolsPage.qml" }
        ListElement { title: qsTr("Usage guide"); page: "GuidePage.qml" }
        ListElement { title: qsTr("About UI Themer"); page: "AboutPage.qml" }
    }

    delegate: ListItem {
        width: menuview.width
        contentHeight: Theme.itemSizeSmall

        Label {
            width: parent.width
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            text: model.title
            color: highlighted ? Theme.highlightColor : Theme.primaryColor
            anchors {
                fill: parent
                left: parent.left
                leftMargin: Theme.horizontalPageMargin
                right: parent.right
                rightMargin: Theme.horizontalPageMargin
            }
        }

        onClicked: pageStack.push(Qt.resolvedUrl("../pages/menu/" + model.page), { "themePack": themepack, "notification": notification })
    }

    VerticalScrollDecorator { }
}
