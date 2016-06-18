import QtQuick 2.0

QtObject {
    property point topLeft: Qt.point(-100,-100)
    property point bottomRight: Qt.point(100,100)

    readonly property real width: bottomRight.x - topLeft.x
    readonly property real height: bottomRight.y - topLeft.y
}
