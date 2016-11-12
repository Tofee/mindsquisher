import QtQuick 2.0

Rectangle {
    id: selComp
    border {
        width: 2
        color: "steelblue"
    }
    color: "#354682B4"

    property int rulersSize: 18
    property real minimumWidth: 40
    property real minimumHeight: 40

    property Item targetItem

    MouseArea {     // drag mouse area
        anchors.fill: parent
        preventStealing: true
        drag{
            target: selComp.parent
            smoothed: true
        }
    }

    Rectangle {
        width: rulersSize
        height: rulersSize
        radius: rulersSize
        color: "steelblue"
        anchors.horizontalCenter: parent.left
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            anchors.fill: parent
            preventStealing: true
            drag{ target: parent; axis: Drag.XAxis }
            onMouseXChanged: {
                if(drag.active){
                    targetItem.width = Math.max(targetItem.width - mouseX, selComp.minimumWidth);
                    targetItem.x = targetItem.x + mouseX
                }
            }
        }
    }

    Rectangle {
        width: rulersSize
        height: rulersSize
        radius: rulersSize
        color: "steelblue"
        anchors.horizontalCenter: parent.right
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            anchors.fill: parent
            preventStealing: true
            drag{ target: parent; axis: Drag.XAxis }
            onMouseXChanged: {
                if(drag.active){
                    targetItem.width = Math.max(targetItem.width + mouseX, selComp.minimumWidth);
                }
            }
        }
    }

    Rectangle {
        width: rulersSize
        height: rulersSize
        radius: rulersSize
        x: parent.x / 2
        y: 0
        color: "steelblue"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.top

        MouseArea {
            anchors.fill: parent
            preventStealing: true
            drag{ target: parent; axis: Drag.YAxis }
            onMouseYChanged: {
                if(drag.active){
                    targetItem.height = Math.max(targetItem.height - mouseY, selComp.minimumHeight);
                    targetItem.y = targetItem.y + mouseY
                }
            }
        }
    }


    Rectangle {
        width: rulersSize
        height: rulersSize
        radius: rulersSize
        x: parent.x / 2
        y: parent.y
        color: "steelblue"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.bottom

        MouseArea {
            anchors.fill: parent
            preventStealing: true
            drag{ target: parent; axis: Drag.YAxis }
            onMouseYChanged: {
                if(drag.active){
                    targetItem.height = Math.max(targetItem.height + mouseY, selComp.minimumHeight);
                }
            }
        }
    }

    Rectangle {
        width: rulersSize
        height: rulersSize
        radius: rulersSize
        color: "#e80202"
        anchors.horizontalCenter: parent.right
        anchors.verticalCenter: parent.top
        Text {
            anchors.centerIn: parent
            text: "X"
            color: "black"
        }
        MouseArea {
            anchors.fill: parent
            preventStealing: true
            onClicked: targetItem.destroy();
        }
    }

}
