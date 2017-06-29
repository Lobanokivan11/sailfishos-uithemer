import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"



Page {
    id: mainPage

    ListModel {
        id: pagesModel

        ListElement {
            page: "MainPage.qml"
            title: qsTr("Themes")
        }
        ListElement {
            page: "DdensityPage.qml"
            title: qsTr("Display density")
        }
    }
    SilicaListView {
        id: listView
        anchors.fill: parent
        model: pagesModel
        header: PageHeader { title: "UI Themer" }
        RemorsePopup { id: remorsehs; onTriggered: iconpack.restart_homescreen() }
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: {
                   pageStack.push("About.qml");
               }
            }
            MenuItem {
                text: qsTr("Tools")
                onClicked: pageStack.push("Tools.qml")
            }
            MenuItem {
                text: qsTr("Restart homescreen")
                onClicked: remorsehs.execute(qsTr("Restarting homescreen"))
            }
        }
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
