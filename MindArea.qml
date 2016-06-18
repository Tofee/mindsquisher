import QtQuick 2.0

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick.Scene3D 2.0

Item {
    Scene3D {
        id: scene3d
        anchors.fill: parent
        anchors.margins: 10
        focus: true
        aspects: "input"

        GridEntity {}
    }
}

