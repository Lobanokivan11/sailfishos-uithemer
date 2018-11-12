TARGET = sailfishos-uithemer

MY_FILES = \
other/apply.sh \
other/restore.sh \
other/apply_font.sh \
other/restore_fonts.sh \
other/homescreen.sh \
other/ocr.sh \
other/apply_adpi.sh \
other/restore_adpi.sh \
other/restore_dpr.sh \
other/restore_iz.sh \
other/apply_hours.sh \
other/disable_service.sh \
other/enable_service.sh \
other/reinstall_fonts.sh \
other/reinstall_icons.sh \
other/coverbg.png\
other/appinfo.png

OTHER_SOURCES += $$MY_FILES

my_resources.path = $$PREFIX/share/$$TARGET
my_resources.files = $$MY_FILES

INSTALLS += my_resources

CONFIG += sailfishapp c++11

SOURCES += src/sailfishos-uithemer.cpp \
    src/spawner.cpp \
    src/themepackmodel.cpp \
    src/fontweightmodel.cpp \
    src/themepack.cpp

OTHER_FILES += qml/sailfishos-uithemer.qml \
    qml/cover/CoverPage.qml \
    rpm/sailfishos-uithemer.changes.in \
    rpm/sailfishos-uithemer.spec \
    sailfishos-uithemer.desktop \
    qml/js/*.js \
    qml/components/AboutLanguage.qml \
    qml/components/AboutTranslator.qml \
    qml/common/Settings.qml \
    qml/pages/MainPage.qml

SAILFISHAPP_ICONS = 86x86

CONFIG += sailfishapp_i18n

TRANSLATIONS +=  translations/*.ts

HEADERS += \
    src/spawner.h \
    src/themepackmodel.h \
    src/fontweightmodel.h \
    src/themepack.h

DISTFILES += \
    qml/components/themepacklistview/ThemePackListView.qml \
    qml/components/dockedbar/DockedBar.qml \
    qml/components/BackgroundRectangle.qml \
    qml/components/themepacklistview/ThemePackItem.qml \
    qml/pages/ConfirmPage.qml \
    qml/pages/RestorePage.qml \
    qml/views/DensityView.qml \
    qml/pages/menu/AboutPage.qml \
    qml/pages/menu/GuidePage.qml \
    qml/js/Database.js \
    qml/pages/menu/RecoveryPage.qml \
    qml/views/ToolsView.qml \
