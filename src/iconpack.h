#ifndef ICONPACK_H
#define ICONPACK_H

#include <QStringList>
#include <QString>
#include <QObject>
#include <QtQml>

class IconPack : public QObject
{
    Q_OBJECT

    public:
        explicit IconPack(QObject* parent = 0);

    public slots:
        QString whoami() const;                                               // function to test what user runs app
        QString listIconPacks() const;                                        // list all dirs in /usr/share which start with harbour-iconpack- prefix
        QString getDroidDPI() const;                                          // gets hours from timer
        QString getTimer() const;                                             // gets hours from timer
        QString getName(const QString& packname) const;                       // gets name from the package file
        QStringList capabilities(const QString& packname) const;
        QStringList weights(const QString& packname) const;
        void apply_icons(const QString& name, QJSValue done) const; // calls apply script, which then runs original application and tells it to apply the icon theme
        bool apply_fonts(const QString& name, const QString& font_s, QJSValue done) const;
        bool restart_homescreen() const;
        bool reinstall_icons(QJSValue done) const;
        bool reinstall_fonts(QJSValue done) const;
        bool apply_adpi(const QString& adpi) const;
        bool restore_adpi() const;
        bool restore_dpr() const;                                             // function to test what user runs app
        bool restore(bool icons, bool fonts, QJSValue done) const;                           // calls restore script, which runs original application and restores original icon pack
        bool enable_service() const;
        bool disable_service() const;
        bool apply_hours(const QString& hours) const;
        bool hideIcon() const;                                                // hides icon of original app, so user does not have to have two same icons on home screen
        bool uninstall(const QString& packname, QJSValue done) const;
};

#endif // ICONPACK_H

