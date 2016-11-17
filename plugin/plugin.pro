TEMPLATE = lib

QT += qml quick
CONFIG += qt plugin

DESTDIR = $${OUT_PWD}/../build/imports/MindSquisher
TARGET  = qmlmindsquisherplugin

SOURCES += plugin.cpp \
           ideabase.cpp \
           line.cpp \
           qobjectlistmodel.cpp
HEADERS += plugin.h \
           ideabase.h \
           line.h \
           qobjectlistmodel.h

OTHER_FILES += qmldir

target.path += $${DESTDIR}

qmldir.files = qmldir
qmldir.path = $${DESTDIR}

INSTALLS += target qmldir

