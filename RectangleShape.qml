import QtQuick 2.0

BaseShape {
    id: base
    width: 50
    height: 30

    Rectangle {
        anchors.fill: parent

        radius: 5
        border.color: "red"
        color: base.selected ? "yellow" : "white"
    }
}
