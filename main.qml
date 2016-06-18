import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Mind Squisher")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: qsTr("Insert")
            MenuItem {
                text: qsTr("&Circle")
                onTriggered:mindArea.insertShape("circle");
            }
            MenuItem {
                text: qsTr("Rectangle")
                onTriggered:mindArea.insertShape("rectangle");
            }
        }
    }

    // background
    Rectangle {
        color: "grey"
        anchors.fill: parent
    }

    MindArea {
        id: mindArea
        anchors.fill: parent
    }
}

