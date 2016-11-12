import QtQuick 2.0

BaseShape {
    id: base

    readonly property real radius: width/2

    width: 100
    height: width
    onWidthChanged: height = width; // ensure height and width are always equal
    onHeightChanged: width = height;

    Rectangle {
        id: shapeRect

        radius: base.radius
        anchors.fill: parent

        border.color: "blue"
        color: base.selected ? "yellow" : "white"
    }
}
