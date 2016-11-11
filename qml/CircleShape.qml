import QtQuick 2.0

BaseShape {
    id: base
    property real radius: 20

    width: radius*2
    height: width

    Rectangle {
        id: shapeRect

        radius: base.radius
        anchors.fill: parent

        border.color: "blue"
        color: base.selected ? "yellow" : "white"
    }
}
