import QtQuick 2.0
import QtQuick.Controls 2.0

import MindSquisher 1.0

IdeaBase {
    id: base

    property real centerX: x + width/2;
    property real centerY: y + height/2;

    property SelectionManager selectionMgr;

    property bool selected: false;
    onSelectedChanged: {
        if(!selected) textArea.focus = false;
    }

    text: "(click me)"

    TextArea {
        id: textArea

        z: 2
        anchors.fill: parent
        text: base.text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        onEditingFinished: deselect();

        MouseArea {     // drag mouse area
            z: 2
            anchors.fill: parent
            enabled: !parent.focus
            onClicked: {
                selectionMgr.selectItem(base, mouse.modifiers);
                if(selectionMgr.itemCount === 1 && selectionMgr.get(0) === base) {
                    textArea.focus = true;
                }
            }
        }
    }

    ResizeArea {
        z: 2
        anchors.fill: parent
        targetItem: parent
        visible: base.selected
    }
}
