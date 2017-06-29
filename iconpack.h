#ifndef ICONPACK
#define ICONPACK

#include <QObject>
#include <QDebug>
#include <sys/types.h>
#include <unistd.h>
#include "exec.h"
#include <QFileInfo>
#include <QDir>

class IconPack : public QObject {
    Q_OBJECT
public:
    Q_INVOKABLE QString whoami() const { // function to test what user runs app
        setuid(0);
        return QString::fromStdString(exec("whoami"));
    }

    Q_INVOKABLE QString listIconPacks() const { // list all dirs in /usr/share which start with harbour-iconpack- prefix
        return QString::fromStdString(exec("cd /usr/share/; ls -d harbour-themepack-* | cut -c19-"));
    }

    Q_INVOKABLE bool apply_icons(const QString name, const bool homescreen = false) const { // calls apply script, which then runs original application and tells it to apply the icon theme
        std::string c_name = name.toStdString();
        std::string command = "/usr/share/sailfishos-uithemer/apply.sh "+c_name;
        system(command.c_str());
        if(homescreen) {
            system("/usr/share/sailfishos-uithemer/homescreen.sh");
        }
        return true;
    }

    Q_INVOKABLE bool apply_fonts(const QString name, const QString font_s) const {
        std::string c_name = name.toStdString();
        std::string c_font_s = font_s.toStdString();
        std::string command = "/usr/share/sailfishos-uithemer/apply_font.sh "+c_name+" "+c_font_s;
        system(command.c_str());
        return true;
    }

Q_INVOKABLE bool restart_homescreen() const {
    setuid(0);
    system("/usr/share/sailfishos-uithemer/homescreen.sh");
    return true;
}

 Q_INVOKABLE bool reinstall_icons() const {
     setuid(0);
     system("/usr/share/sailfishos-uithemer/reinstall_icons.sh");
     return true;
 }

 Q_INVOKABLE bool reinstall_fonts() const {
     setuid(0);
     system("/usr/share/sailfishos-uithemer/reinstall_fonts.sh");
     return true;
 }

    Q_INVOKABLE bool apply_adpi(const QString adpi) const {
        std::string c_adpi = adpi.toStdString();
        std::string command = "/usr/share/sailfishos-uithemer/apply_adpi.sh "+c_adpi;
        system(command.c_str());
        return true;
}

Q_INVOKABLE bool restore_adpi() const {
    setuid(0);
    system("/usr/share/sailfishos-uithemer/restore_adpi.sh");
    return true;
}
Q_INVOKABLE bool restore_dpr() const { // function to test what user runs app
    setuid(0);
    system("/usr/share/sailfishos-uithemer/restore_dpr.sh");
    return true;
}

    Q_INVOKABLE QStringList weights(const QString packname) const {
        QStringList ret;
        QStringList filter;
        filter << "*.ttf";
        QDir dir("/usr/share/harbour-themepack-"+packname+"/font");
        ret << dir.entryList(filter);
        return ret;
    }

    Q_INVOKABLE bool restore(const bool icons, const bool fonts) const { // calls restore script, which runs original application and restores original icon pack
        if(icons) {
            system("/usr/share/sailfishos-uithemer/restore.sh");
        }
        if(fonts) {
            system("/usr/share/sailfishos-uithemer/restore_fonts.sh");
        }
        return true;
    }

    Q_INVOKABLE QStringList capabilities(const QString packname) const {
        QStringList ret;
        QDir icon1("/usr/share/harbour-themepack-"+packname+"/jolla");
        QDir icon2("/usr/share/harbour-themepack-"+packname+"/native");
        QDir icon3("/usr/share/harbour-themepack-"+packname+"/apk");
        QDir icon4("/usr/share/harbour-themepack-"+packname+"/dynclock");
        QDir icon5("/usr/share/harbour-themepack-"+packname+"/dyncal");

        bool icon_first_part = false;
        bool font_first_part = false;

        if(icon1.exists() || icon2.exists() || icon3.exists() || icon4.exists() || icon5.exists()) {
            icon_first_part = true;
        }
        if(icon_first_part) {
            if(icon1.count() > 0 || icon2.count() > 0 || icon3.count() > 0 || icon4.count() > 0 || icon5.count() > 0) {
                ret << QString("true");
            } else {
                ret << QString("false");
            }
        } else {
            ret << QString("false");
        }

        QDir font1("/usr/share/harbour-themepack-"+packname+"/font");

        if(font1.exists()) {
            font_first_part = true;
        }

        if(font_first_part) {
            if(font1.count() > 0) {
                ret << QString("true");
            } else {
                ret << QString("false");
            }
        } else {
            ret << QString("false");
        }
        return ret;
    }

    Q_INVOKABLE bool hideIcon() const { // hides icon of original app, so user does not have to have two same icons on home screen
        setuid(0);
        system("echo \"NoDisplay=true\" >> /usr/share/applications/harbour-iconpacksupport.desktop");
        system("echo \"NoDisplay=true\" >> /usr/share/applications/harbour-themepacksupport.desktop");
        return true;
    }

    Q_INVOKABLE QString getName(const QString packname) const { // gets name from the package file
        std::string c_packname = packname.toStdString();
        std::string command = "cat /usr/share/harbour-themepack-"+c_packname+"/package";
        return QString::fromStdString(exec(command.c_str())).trimmed();
    }

    Q_INVOKABLE bool uninstall(const QString packname) const {
        std::string c_packname = packname.toStdString();
        std::string cmd = "rpm -qf /usr/share/harbour-themepack-"+c_packname+"/ --queryformat '%{NAME}\n'";
        std::string package = exec(cmd.c_str());
        std::string command = "pkcon remove "+package;
        system(command.c_str());
        return true;
    }
};

#endif // ICONPACK

