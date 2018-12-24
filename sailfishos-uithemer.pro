TARGET = sailfishos-uithemer

MY_FILES = \
other/apply.sh \
other/iconspreview.sh \
other/reapply_icons.sh \
other/restore.sh \
other/apply_font.sh \
other/homescreen.sh \
other/apply_adpi.sh \
other/restore_dpi.sh \
other/ocr.sh \
other/recovery.sh \
other/restore_iz.sh \
other/apply_hours.sh \
other/disable_service.sh \
other/enable_service.sh \
other/reinstall_fonts.sh \
other/reinstall_icons.sh \
other/install_dependencies.sh \
other/install_imagemagick.sh \
other/post_update.sh \
other/coverbg.png \
other/appinfo.png

appicons.path = /usr/share/icons/hicolor/
appicons.files = appicons/*

OTHER_SOURCES += $$MY_FILES

my_resources.path = $$PREFIX/share/$$TARGET
my_resources.files = $$MY_FILES

INSTALLS += my_resources appicons

CONFIG += sailfishapp c++11

SOURCES += src/sailfishos-uithemer.cpp \
    src/spawner.cpp \
    src/themepackmodel.cpp \
    src/fontweightmodel.cpp \
    src/themepack.cpp

OTHER_FILES += \
    qml/sailfishos-uithemer.qml \
    qml/common/Settings.qml \
    qml/components/AboutLanguage.qml \
    qml/components/AboutTranslator.qml \
    qml/components/BackgroundRectangle.qml \
    qml/components/BusyState.qml \
    qml/components/FontPreview.qml \
    qml/components/LabelText.qml \
    qml/components/Notification.qml \
    qml/components/themepacklistview/ThemePackItem.qml \
    qml/cover/CoverPage1.qml \
    qml/cover/CoverPage2.qml \
    qml/pages/ConfirmPage.qml \
    qml/pages/MainPage.qml \
    qml/pages/OptionsPage.qml \
    qml/pages/OCRPage.qml \
    qml/pages/RestartHSPage.qml \
    qml/pages/RestorePage.qml \
    qml/pages/RestoreDDPage.qml \
    qml/pages/WelcomePage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/GuidePage.qml \
    qml/pages/RecoveryPage.qml \
    qml/js/*.js \
    rpm/* \
    sailfishos-uithemer.desktop \

SAILFISHAPP_ICONS = 86x86

CONFIG += sailfishapp_i18n

TRANSLATIONS +=  translations/*.ts

HEADERS += \
    src/spawner.h \
    src/themepackmodel.h \
    src/fontweightmodel.h \
    src/themepack.h
