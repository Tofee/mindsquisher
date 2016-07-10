import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import MindSquisher 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 600
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

    Component {
        id: circleShape
        Rectangle {
            width: 50
            height: width
            radius: width/2
            border.color: "blue"
            color: "white"

            Drag.active: dragArea.drag.active
            Drag.hotSpot.x: width/2
            Drag.hotSpot.y: height/2

            MouseArea {
                id: dragArea
                anchors.fill: parent
                drag.target: parent
                hoverEnabled: true
                preventStealing: true
            }
        }
    }
    Component {
        id: rectangleShape
        Rectangle {
            width: 50
            height: 30
            radius: 5
            border.color: "red"
            color: "white"

            Drag.active: dragArea.drag.active
            Drag.hotSpot.x: width/2
            Drag.hotSpot.y: height/2

            MouseArea {
                id: dragArea
                anchors.fill: parent
                drag.target: parent
                hoverEnabled: true
                preventStealing: true
            }
        }
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Column {
            width: 100
            Layout.minimumWidth: 50

            Button {
                height: 60
                width: parent.width
                Rectangle {
                    anchors.centerIn: parent
                    width: 50
                    height: width
                    radius: width/2
                    border.color: "blue"
                    color: "white"
                }

                onClicked: mindArea.insertShape(circleShape);
            }
            Button {
                height: 60
                width: parent.width
                Rectangle {
                    anchors.centerIn: parent
                    width: 50
                    height: 30
                    radius: 5
                    border.color: "red"
                    color: "white"
                }

                onClicked: mindArea.insertShape(rectangleShape);
            }
        }

        MindArea {
            id: mindArea
            clip: true

            Layout.minimumWidth: 50
            Layout.fillWidth: true
        }
    }
}

