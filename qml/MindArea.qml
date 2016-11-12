import QtQuick 2.0
import QtQml.Models 2.2

import MindSquisher 1.0

Item {
    FlickableViewport {
        id: flickableViewport
        anchors.fill: parent

        onBackgroundClicked: mainSelectionManager.unselectAll();
    }

    SelectionManager {
        id: mainSelectionManager

        itemsModel: itemArray
    }

    ObjectList {
        id: itemArray
    }

    function insertShape(componentFile) {
        var component = Qt.createComponent(componentFile);
        var newItem = flickableViewport.instantiateComponentAt(component, Qt.point(0, 0));
        newItem.selectionMgr = mainSelectionManager;
        itemArray.addItem(newItem);
    }

    function startConnect() {
        var i,j;
        if(mainSelectionManager.itemCount >= 2) {
            for(i=0; i<mainSelectionManager.itemCount; ++i) {
                for(j=i+1;j<mainSelectionManager.itemCount; j++) {
                    connectItems(mainSelectionManager.get(i), mainSelectionManager.get(j));
                }
            }
        }
    }

    function connectItems(item1, item2) {
        var lineComp = Qt.createComponent("qrc:/ConnectionLine.qml");
        lineComp.createObject(flickableViewport.contentItem, { "from": item1, "to": item2, "z": -1 } );
        //item1.Component.onDestruction.connect(lineComp.destroy);
        //item2.Component.onDestruction.connect(lineComp.destroy);
    }

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: "bbox: " + flickableViewport.modelBoundingBox.stringify() + ", mindAreaFlickable.zoomRatio: " + flickableViewport.zoomRatio
        color: "white"
    }
}

