import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

SilicaListView
{
    id: menuview
    clip: true
    anchors.fill: parent
    anchors.bottomMargin: Theme.paddingLarge

    header: PageHeader { title: qsTr("UI Themer") }

    model: ListModel {
        ListElement { title: qsTr("Icon updater"); page: "IconUpdaterPage.qml"; category: qsTr("Utility") }
        ListElement { title: qsTr("Tools"); page: "ToolsPage.qml"; category: qsTr("Utility") }
        ListElement { title: qsTr("Usage guide"); page: "GuidePage.qml"; category: qsTr("Help") }
        ListElement { title: qsTr("About UI Themer"); page: "AboutPage.qml"; category: qsTr("Help") }
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

    section {
           property: "category"
           criteria: ViewSection.FullString
           delegate: SectionHeader {
                   text: section
               }
           }

    VerticalScrollDecorator { }
}
