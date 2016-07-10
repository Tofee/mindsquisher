TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    line.cpp \
    qobjectlistmodel.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    README.md

HEADERS += \
    line.h \
    qobjectlistmodel.h

