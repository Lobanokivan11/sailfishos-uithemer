TARGET = sailfishos-uithemer

MY_FILES = \
other/apply.sh \
other/restore.sh \
other/apply_font.sh \
other/restore_fonts.sh \
other/homescreen.sh \
other/apply_adpi.sh \
other/restore_adpi.sh \
other/restore_dpr.sh \
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

CONFIG += sailfishapp

SOURCES += src/sailfishos-uithemer.cpp

OTHER_FILES += qml/sailfishos-uithemer.qml \
    qml/cover/CoverPage.qml \
    rpm/sailfishos-uithemer.changes.in \
    rpm/sailfishos-uithemer.spec \
    rpm/sailfishos-uithemer.yaml \
    sailfishos-uithemer.desktop \
    qml/js/*.js \
    qml/components/Button.qml \
    qml/components/SLabel.qml \
    qml/components/AboutLanguage.qml \
    qml/components/AboutTranslator.qml \
    qml/pages/MainPage.qml \
    qml/pages/Confirm.qml \
    qml/pages/Restore.qml \
    qml/pages/About.qml \
    qml/components/Placeholder.qml \
    qml/pages/Uninstall.qml \
    qml/pages/HomePage.qml \
    qml/pages/DdensityPage.qml \
    qml/components/UITnotifier.qml \
    qml/pages/Tools.qml \
    qml/pages/AutoUpdPage.qml

SAILFISHAPP_ICONS = 86x86

CONFIG += sailfishapp_i18n

TRANSLATIONS +=  translations/*.ts

HEADERS += \
    exec.h \
    iconpack.h

DISTFILES += \

