import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"



Page {
    id: mainPage
    PullDownMenu {

        MenuItem {
            text: qsTr("About")
            onClicked: {
                pageStack.push("About.qml");
            }
        }

    }

    ListModel {
        id: pagesModel

        ListElement {
            page: "MainPage.qml"
            title: qsTr("Themes")
            subtitle: "Assorted Button variants"
        }
        ListElement {
            page: "DprPage.qml"
            title: qsTr("Device pixel ratio")
            subtitle: "ComboBox component"
        }
    }
    SilicaListView {
        id: listView
        anchors.fill: parent
        model: pagesModel
        header: PageHeader { title: "UI themer" }
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: {
                    pageStack.push("About.qml");
                }
            }
            MenuItem {
                text: qsTr("Restart homescreen")
                onClicked: {
                    pageStack.push("Restart.qml");
                }
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
