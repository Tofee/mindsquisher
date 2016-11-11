import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

import MindSquisher 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Mind Squisher")

    header: Row {
        height: 30
        Button {
            text: qsTr("File")
            onClicked: subMenuFile.open();
            height: parent.height
            Menu {
                id: subMenuFile
                title: qsTr("File")
                y: parent.height
                MenuItem {
                    text: qsTr("&Open")
                }
                MenuItem {
                    text: qsTr("Exit")
                    onTriggered: Qt.quit();
                }
            }
        }
        Button {
            text: qsTr("Insert")
            onClicked: subMenuInsert.open();
            height: parent.height
            Menu {
                id: subMenuInsert
                title: qsTr("Insert")
                y: parent.height
                MenuItem {
                    text: qsTr("&Circle")
                    onTriggered:mindArea.insertShape("qrc:/CircleShape.qml");
                }
                MenuItem {
                    text: qsTr("Rectangle")
                    onTriggered:mindArea.insertShape("qrc:/RectangleShape.qml");
                }
            }
        }
    }

    // background
    Rectangle {
        color: "grey"
        anchors.fill: parent
    }

    Drawer {
        edge: Qt.LeftEdge
        height: parent.height

        Column {
            width: 100

            Button {
                height: 60
                width: parent.width
                CircleShape {
                    anchors.centerIn: parent
                    radius: (parent.height/2) - 5
                    mouseAreaEnabled: false
                }

                onClicked: mindArea.insertShape("qrc:/CircleShape.qml");
            }
            Button {
                height: 60
                width: parent.width
                RectangleShape {
                    anchors.fill: parent
                    anchors.margins: 5
                    mouseAreaEnabled: false
                }

                onClicked: mindArea.insertShape("qrc:/RectangleShape.qml");
            }
        }
    }

    MindArea {
        id: mindArea
        clip: true
        anchors.fill: parent
    }
}

