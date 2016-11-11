TEMPLATE = subdirs
SUBDIRS = src \
          plugin


# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    README.md

