import QtQuick 2.0

Item {
    id: root

    signal backgroundClicked();

    property alias contentItem: flickableViewport.contentItem

    property BoundingBox modelBoundingBox: BoundingBox {
        topLeft: Qt.point(-200,-200)
        bottomRight: Qt.point(200, 200)
    }

    // grid size
    property real gridSize: 32

    // Zoom management
    property int zoomLevel: 0
    readonly property alias zoomRatio: flickableViewport.zoomRatio
    property int subGridZoomLevel: zoomLevel
    property bool _enableGridZoomAnimation: true
    onZoomLevelChanged: {
        // When the zooming animation is finished, this function updates the
        // grid zoom level to always have a grid/subgrid of an acceptable size
        var newSubGridZoomLevel = _positiveModulo(zoomLevel,4);
        _enableGridZoomAnimation = (Math.abs(newSubGridZoomLevel-subGridZoomLevel) === 1);
        subGridZoomLevel = newSubGridZoomLevel;
        _enableGridZoomAnimation = true;
    }
    function _positiveModulo(n, m) {
        return ((n%m) + m) % m;
    }

    // Have a clickable background behind the main contentItem of the flickable
    Component.onCompleted: mouseAreaBgComp.createObject(flickableViewport, { "z": -1 });
    Component {
        id: mouseAreaBgComp
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.backgroundClicked();
            }
        }
    }

    // Background grid
    Item {
        id: greyGrid
        // This is the main grid, appearing in grey behind the main grid
        anchors.fill: flickableViewport

        layer.enabled: true
        layer.effect: ShaderEffect {
            property size start: Qt.size(flickableViewport.contentX/flickableViewport.width, flickableViewport.contentY/flickableViewport.height)
            property size gridRatio: Qt.size(flickableViewport.width/gridSize, flickableViewport.height/gridSize);
            property real zoom: flickableViewport.getZoomRatioFromZoomLevel(subGridZoomLevel);
            Behavior on zoom {
                enabled: root._enableGridZoomAnimation
                NumberAnimation { id: zoomAnimation; duration: 300 }
            }

            fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform lowp float qt_Opacity; // inherited opacity of this item
                uniform highp vec2 start;
                uniform highp vec2 gridRatio;
                uniform highp float zoom;
                void main() {

                    highp vec2 shiftedTexCoord  = gridRatio*(qt_TexCoord0 + start)/zoom + 0.5;

                    // Compute anti-aliased world-space grid lines
                    highp vec2 grid = abs(fract(shiftedTexCoord) - 0.5) / fwidth(shiftedTexCoord);
                    float line = min(grid.x, grid.y);

                    // Just visualize the grid lines directly
                    gl_FragColor = vec4(vec3(1.0 - min(line, 1.0)), 1.0);
                }"
        }
    }
    Item {
        id: whiteSuperGrid
        anchors.fill: flickableViewport
        // This is the super-grid, appearing in white

        layer.enabled: true
        layer.effect: ShaderEffect {
            property size start: Qt.size(flickableViewport.contentX/flickableViewport.width, flickableViewport.contentY/flickableViewport.height)
            property size gridRatio: Qt.size(flickableViewport.width/gridSize, flickableViewport.height/gridSize);
            property real zoom: flickableViewport.getZoomRatioFromZoomLevel(subGridZoomLevel+4)
            Behavior on zoom {
                enabled: root._enableGridZoomAnimation
                NumberAnimation { id: zoomAnimation; duration: 300 }
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

        property real zoomRatio: getZoomRatioFromZoomLevel(root.zoomLevel)
        Behavior on zoomRatio { NumberAnimation { duration: 300  } }

        function getZoomRatioFromZoomLevel(_zoomLevel) {
            return Math.exp(_zoomLevel * Math.log(2)/2);
        }

        property Scale contentScaling: Scale {
            origin.x: 0
            origin.y: 0
            xScale: flickableViewport.zoomRatio
            yScale: flickableViewport.zoomRatio
        }
        Component.onCompleted: {
            flickableViewport.contentItem.transform = contentScaling;
        }

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
        //scrollGestureEnabled: false
        onWheel: {
            var currentZoom = flickableViewport.zoomRatio
            root.zoomLevel += wheel.angleDelta.y/120;

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
