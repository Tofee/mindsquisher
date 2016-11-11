import QtQuick 2.0

Item {
    property BoundingBox modelBoundingBox: BoundingBox {
        topLeft: Qt.point(-200,-200)
        bottomRight: Qt.point(200, 200)
    }

    property real gridSize: 50

    property alias zoomLevel: flickableViewport.zoomLevel
    readonly property alias zoomRatio: flickableViewport.zoomRatio

    // Background grid
    Item {
        anchors.fill: flickableViewport

        layer.enabled: true
        layer.effect: ShaderEffect {
            property size start: Qt.size(flickableViewport.contentX/flickableViewport.width, flickableViewport.contentY/flickableViewport.height)
            property size gridRatio: Qt.size(flickableViewport.width/gridSize, flickableViewport.height/gridSize);
            property real zoom: flickableViewport.getZoomRatioFromZoomLevel(positiveModulo(flickableViewport.zoomLevel, 6))

            function positiveModulo(n, m) {
                return ((n%m) + m) % m;
            }

            fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform lowp float qt_Opacity; // inherited opacity of this item
                uniform highp vec2 start;
                uniform highp vec2 gridRatio;
                uniform highp float zoom;
                void main() {

                    highp vec2 shiftedTexCoord  = gridRatio*(qt_TexCoord0 + start)/zoom;

                    // Compute anti-aliased world-space grid lines
                    highp vec2 grid = abs(fract(shiftedTexCoord) - 0.5) / fwidth(shiftedTexCoord);
                    float line = min(grid.x, grid.y);

                    // Just visualize the grid lines directly
                    gl_FragColor = vec4(vec3(1.0 - min(line, 1.0)), 1.0);
                }"
        }
    }
    Item {
        anchors.fill: flickableViewport

        layer.enabled: true
        layer.effect: ShaderEffect {
            property size start: Qt.size(flickableViewport.contentX/flickableViewport.width, flickableViewport.contentY/flickableViewport.height)
            property size gridRatio: Qt.size(flickableViewport.width/gridSize, flickableViewport.height/gridSize);
            property real zoom: flickableViewport.getZoomRatioFromZoomLevel((flickableViewport.zoomLevel%3) !== 0 ? 0 : 3)

            function positiveModulo(n, m) {
                return ((n%m) + m) % m;
            }

            fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform lowp float qt_Opacity; // inherited opacity of this item
                uniform highp vec2 start;
                uniform highp vec2 gridRatio;
                uniform highp float zoom;
                void main() {

                    highp vec2 shiftedTexCoord  = gridRatio*(qt_TexCoord0 + start)/zoom;

                    // Compute anti-aliased world-space grid lines
                    highp vec2 grid = abs(fract(shiftedTexCoord) - 0.5) / fwidth(shiftedTexCoord);
                    float line = min(grid.x, grid.y);

                    // Just visualize the grid lines directly
                    gl_FragColor = vec4(vec3(1.0 - min(line, 1.0)), 0.5);
                }"
        }
    }

    // Infinite viewport
    Flickable {
        id: flickableViewport
        anchors.fill: parent
        flickableDirection: Flickable.HorizontalAndVerticalFlick

        // put infinite margins
        topMargin: 1e10;
        bottomMargin: 1e10;
        leftMargin: 1e10;
        rightMargin: 1e10;

        contentX: modelBoundingBox.center.x - flickableViewport.width/2;
        contentY: modelBoundingBox.center.y - flickableViewport.height/2;

        property int zoomLevel: 0
        readonly property real zoomRatio: getZoomRatioFromZoomLevel(zoomLevel)

        function getZoomRatioFromZoomLevel(_zoomLevel) {
            return Math.exp(_zoomLevel * Math.log(1.25));
        }

        property Scale contentScaling: Scale {
            origin.x: 0
            origin.y: 0
            xScale: flickableViewport.zoomRatio
            yScale: flickableViewport.zoomRatio
        }
        Component.onCompleted: flickableViewport.contentItem.transform = contentScaling;

        Rectangle {
            id: viewportBoundingBackground
            x: modelBoundingBox.topLeft.x
            y: modelBoundingBox.topLeft.y
            width: modelBoundingBox.width
            height: modelBoundingBox.height

            color: "lightgray"
            opacity: 0.4
        }
    }
    PinchArea {
        anchors.fill: flickableViewport
        pinch.target: flickableViewport.contentItem
    }
    MouseArea {
        anchors.fill: flickableViewport
        acceptedButtons: Qt.NoButton // let the Flickable viewport handle the swipes
        onWheel: {
            var currentZoom = flickableViewport.zoomRatio
            flickableViewport.zoomLevel += wheel.angleDelta.y/120;

            // we want the (x,y) point to be an invariant of the zoom change,
            // so we have to adapt the flickable offset to achieve this effect
            var contentX = ((wheel.x + flickableViewport.contentX) / currentZoom) * flickableViewport.zoomRatio - wheel.x
            var contentY = ((wheel.y + flickableViewport.contentY) / currentZoom) * flickableViewport.zoomRatio - wheel.y

            flickableViewport.contentX = contentX;
            flickableViewport.contentY = contentY;
        }
    }

    function fitInAll() {
        flickableViewport.contentX = modelBoundingBox.center.x - flickableViewport.width/2;
        flickableViewport.contentY = modelBoundingBox.center.y - flickableViewport.height/2;
    }

    function instantiateComponentAt(component, pos) {
        var item = component.createObject(flickableViewport.contentItem,
                                          { "x": pos.x, "y": pos.y } );

        // update bouding box
        modelBoundingBox.insert(item);

        return item;
    }

    function insertItemAtPos(item, pos) {
        item.parent = flickableViewport.contentItem;
        item.x = pos.x;
        item.y = pos.y;

        // update bouding box
        modelBoundingBox.insert(item);
    }
}
