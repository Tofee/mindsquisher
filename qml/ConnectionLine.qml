import QtQuick 2.0

import MindSquisher 1.0

Line {
    property Item from
    property Item to

    onFromChanged: if(!from) destroy();
    onToChanged: if(!to) destroy();

    p1: Qt.point(from.centerX, from.centerY);
    p2: Qt.point(to.centerX, to.centerY);
}
