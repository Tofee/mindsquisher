TEMPLATE = app

DESTDIR = ../build
TARGET  = mindsquisher

QT += qml quick widgets

SOURCES += main.cpp

RESOURCES += ../qml/qml.qrc

target.path += $${DESTDIR}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = imports

