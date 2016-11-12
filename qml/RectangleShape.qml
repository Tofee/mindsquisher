import QtQuick 2.0

BaseShape {
    id: base
    width: 100
    height: 60

    Rectangle {
        anchors.fill: parent

        radius: 5
        border.color: "red"
        color: base.selected ? "yellow" : "white"
    }
}
