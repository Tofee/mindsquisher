import QtQuick 2.0

Item {
    property rect modelBoundingBox: Qt.rect(0, 0, 5000, 5000)

    Flickable {
        id: mindAreaFlickable
        anchors.fill: parent
        contentWidth: mindAreaItem.width*zoomLevel + mindAreaFlickable.width
        contentHeight: mindAreaItem.height*zoomLevel + mindAreaFlickable.height
        flickableDirection: Flickable.HorizontalAndVerticalFlick

        Component.onCompleted: {
            contentX = modelBoundingBox.width/2 - mindAreaFlickable.width/2;
            contentY = modelBoundingBox.height/2 - mindAreaFlickable.height/2;
        }

        property real zoomLevel: 1

        Item {
            id: mindAreaItem
            width: modelBoundingBox.width
            height: modelBoundingBox.height
            transform: Scale {
                origin.x: mindAreaItem.width/2
                origin.y: mindAreaItem.height/2
                xScale: mindAreaFlickable.zoomLevel
                yScale: mindAreaFlickable.zoomLevel
            }

            Item {
                visible: false
                anchors.fill: parent
                layer.enabled: true
                layer.effect: ShaderEffect {
                    fragmentShader: "
                        varying highp vec2 qt_TexCoord0;
                        uniform sampler2D source;
                        uniform lowp float qt_Opacity; // inherited opacity of this item
                        void main() {
                            if(fract(qt_TexCoord0.x / 0.01f) < 0.02f || fract(qt_TexCoord0.y / 0.01f) < 0.02f)
                                gl_FragColor = vec4(0) * qt_Opacity;   // draw a black line
                            else
                                gl_FragColor = vec4(1,1,1,1);          // transparent
                        }"
                }
            }
            Grid {
                id: mindGrid
                anchors.fill: mindAreaItem
                columns: Math.floor(mindAreaItem.width / 300)
                spacing: 250
                Repeater {
                    model: mindGrid.columns * mindGrid.columns
                    Rectangle {
                        width: 50
                        height: 50
                        color: "green"
                    }
                }
            }
        }
        PinchArea {
            anchors.fill: parent
            pinch.target: mindAreaItem
        }
        MouseArea {
            anchors.fill: parent
            onWheel: {
                mindAreaFlickable.zoomLevel *= Math.pow(1.25, wheel.angleDelta.y/120);
            }
        }
    }

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: "bbox: " + modelBoundingBox
        color: "black"
    }
}

