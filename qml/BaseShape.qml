import QtQuick 2.0
import MindSquisher 1.0

IdeaBase {
    id: base

    property real centerX: x + width/2;
    property real centerY: y + height/2;

    property alias mouseAreaEnabled: dragArea.enabled

    property bool selected: false;
    signal clicked();

    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: width/2
    Drag.hotSpot.y: height/2

    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        hoverEnabled: true
        preventStealing: true

        onClicked: {
            base.selected = !base.selected;
            base.clicked();
        }
    }

    Rectangle {
        id: shapeRect

        z: 2

        anchors.fill: parent
        color: "transparent"
        border.color: "yellow"
        border.width: 2
        visible: base.selected
    }
}
