import QtQuick 2.0

Item {
    FlickableViewport {
        id: flickableViewport
        anchors.fill: parent
    }

    Component {
        id: circleShape
        Rectangle {
            width: 50
            height: width
            radius: width/2
            border.color: "blue"
            color: "transparent"
        }
    }
    Component {
        id: rectangleShape
        Rectangle {
            width: 50
            height: 30
            radius: 5
            border.color: "red"
            color: "transparent"
        }
    }

    function insertShape(shape) {
        if(shape==="circle") {
            flickableViewport.instantiateComponentAt(circleShape, Qt.point(-230, -90));
        }
        else if(shape==="rectangle") {
            flickableViewport.instantiateComponentAt(rectangleShape, Qt.point(50, 90));
        }
    }

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: "bbox: " + flickableViewport.modelBoundingBox.stringify() + ", mindAreaFlickable.zoomLevel: " + flickableViewport.zoomLevel
        color: "white"
    }
}

