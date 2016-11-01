import QtQuick 2.0
import QtQml.Models 2.2

import MindSquisher 1.0

Item {
    FlickableViewport {
        id: flickableViewport
        anchors.fill: parent
    }

    ObjectList {
        id: itemArray

        onRowsInserted: {
            if(last>0) {
                var item = lineComp.createObject(flickableViewport.contentItem,
                                                  { "p1": Qt.binding(function() { return Qt.point(itemArray.get(0).centerX, itemArray.get(0).centerY); }),
                                                    "p2": Qt.binding(function() { return Qt.point(itemArray.get(last).centerX, itemArray.get(last).centerY); }) } );
                flickableViewport.insertItemAtPos(item, Qt.point(0,0));
                console.log(item + " " + item.thickness + " " + item.color + " " + item.p1 + " " + item.p2);
            }
        }
    }

    Component {
        id: lineComp
        Line {
            z: -1
        }
    }

    function insertShape(componentFile) {
        var component = Qt.createComponent(componentFile);
        var newItem = flickableViewport.instantiateComponentAt(component, Qt.point(0, 0));
        itemArray.addItem(newItem);
    }

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: "bbox: " + flickableViewport.modelBoundingBox.stringify() + ", mindAreaFlickable.zoomLevel: " + flickableViewport.zoomLevel
        color: "white"
    }
    Row {
        anchors.top: parent.top
        Repeater {
            model:itemArray
            delegate: Rectangle {
                width: 10; height: 40
                border.width: 1
                color: "yellow"
            }
        }
    }
}

