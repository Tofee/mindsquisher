import QtQuick 2.0

QtObject {
    property point topLeft
    property point bottomRight

    readonly property real width: bottomRight.x - topLeft.x
    readonly property real height: bottomRight.y - topLeft.y
    readonly property point center: Qt.point(0.5*(topLeft.x+bottomRight.x), 0.5*(topLeft.y+bottomRight.y))

    function insert(item) {
        if(item.x < topLeft.x) {
            topLeft.x = item.x;
        }
        else if(item.x > bottomRight.x) {
            bottomRight.x = item.x;
        }
        if(item.y < topLeft.y) {
            topLeft.y = item.y;
        }
        else if(item.y > bottomRight.y) {
            bottomRight.y = item.y;
        }
    }

    function stringify() {
        return "(" + topLeft + "," + bottomRight + ")"
    }
}
