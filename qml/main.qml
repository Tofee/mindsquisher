import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

import MindSquisher 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Mind Squisher")

    footer: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "Open"
            }
            ToolButton {
                width: parent.height
                text: "\u25A2"
                indicator: Rectangle {
                    radius: height/2
                    anchors.fill: parent
                    anchors.margins: 5
                    border.color: "blue"
                    color: "white"
                }
                onClicked: mindArea.insertShape("qrc:/CircleShape.qml");
            }
            ToolButton {
                width: parent.height*2
                text: "\u25CB"
                indicator: Rectangle {
                    radius: 4
                    anchors.fill: parent
                    anchors.margins: 5
                    border.color: "red"
                    color: "white"
                }
                onClicked: mindArea.insertShape("qrc:/RectangleShape.qml");
            }
            ToolButton {
                width: parent.height*2
                indicator: Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: "qrc:/images/emblem-symbolic-link.svg"
                }
                onClicked: mindArea.startConnect();
            }
            Item { Layout.fillWidth: true }
            ToolButton {
                //text: qsTr("\u2718 Quit")
                indicator: Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: "qrc:/images/window-close.svg"
                }
                onClicked: Qt.quit();
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
        clip: true
        anchors.fill: parent
    }
}

