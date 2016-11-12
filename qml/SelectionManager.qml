import QtQuick 2.0

import MindSquisher 1.0

ObjectList {
    id: root

    // List of all instanciated items
    property ObjectList itemsModel

    function selectItem(item, modifiers) {
        if(!item) return;
        if( modifiers & Qt.ControlModifier ) {
            item.selected = !item.selected
            if( item.selected ) {
                root.addItem(item);
            }
            else {
                root.removeItem(item);
            }
        }
        else {
            unselectAll();
            item.selected = true;
            root.addItem(item);
        }
    }

    function unselectAll() {
        var item;
        for(var i=root.itemCount-1; i>=0; --i) {
            item = root.get(i);
            item.selected = false;
            root.removeItem(i);
        }
    }
}
