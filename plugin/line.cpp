#include "line.h"

#include <QtQuick/qsgnode.h>
#include <QtQuick/qsgflatcolormaterial.h>

Line::Line(QQuickItem *parent)
    : QQuickItem(parent)
    , m_p1(0, 0)
    , m_p2(1, 0)
    , m_thickness(2)
    , m_color(QColor(255,0,0))
{
    setFlag(ItemHasContents, true);
    setAntialiasing(true);
}

Line::~Line()
{
}

void Line::setP1(const QPointF &p)
{
    if (p == m_p1)
        return;

    m_p1 = p;
    emit p1Changed(p);
    update();
}

void Line::setP2(const QPointF &p)
{
    if (p == m_p2)
        return;

    m_p2 = p;
    emit p2Changed(p);
    update();
}

void Line::setThickness(int thickness)
{
    if (thickness == m_thickness)
        return;

    m_thickness = thickness;
    emit thicknessChanged(thickness);
    update();
}

void Line::setColor(const QColor &color)
{
    if (color == m_color)
        return;

    m_color = color;
    emit colorChanged(color);
    update();
}

QSGNode *Line::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *)
{
    QSGGeometryNode *node = 0;
    QSGGeometry *geometry = 0;

    if (!oldNode) {
        node = new QSGGeometryNode;

        geometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), 2);
        geometry->setLineWidth(m_thickness);
        geometry->setDrawingMode(GL_LINE_STRIP);
        node->setGeometry(geometry);
        node->setFlag(QSGNode::OwnsGeometry);

        QSGFlatColorMaterial *material = new QSGFlatColorMaterial;
        material->setColor(m_color);
        node->setMaterial(material);
        node->setFlag(QSGNode::OwnsMaterial);
    } else {
        node = static_cast<QSGGeometryNode *>(oldNode);
        geometry = node->geometry();
        geometry->allocate(2);
        geometry->setLineWidth(m_thickness);
        QSGFlatColorMaterial *material = static_cast<QSGFlatColorMaterial *>(node->material());
        material->setColor(m_color);
    }

    QSGGeometry::Point2D *vertices = geometry->vertexDataAsPoint2D();
    vertices[0].set(m_p1.x(), m_p1.y());
    vertices[1].set(m_p2.x(), m_p2.y());

    node->markDirty(QSGNode::DirtyGeometry);

    return node;
}

