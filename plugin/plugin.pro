TEMPLATE = lib

QT += qml quick
CONFIG += qt plugin

DESTDIR = ../build/imports/MindSquisher 
TARGET  = qmlmindsquisherplugin

SOURCES += plugin.cpp \
           ideabase.cpp \
           line.cpp \
           qobjectlistmodel.cpp
HEADERS += plugin.h \
           ideabase.h \
           line.h \
           qobjectlistmodel.h

pluginfiles.files += qmldir 

target.path += $${DESTDIR}
pluginfiles.path += $${DESTDIR}

INSTALLS += target pluginfiles



