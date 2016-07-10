#include <QApplication>
#include <QQmlApplicationEngine>

#include "line.h"
#include "qobjectlistmodel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<Line>("MindSquisher", 1, 0, "Line");
    qmlRegisterType<QObjectListModel>("MindSquisher", 1, 0, "ObjectList");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

