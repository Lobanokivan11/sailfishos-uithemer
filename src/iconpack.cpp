#include "iconpack.h"
#include <QDebug>
#include <sys/types.h>
#include <unistd.h>
#include "exec.h"
#include <QFileInfo>
#include <QDir>

#define setuid_ex(x) (void)setuid(x)

IconPack::IconPack(QObject* parent): QObject(parent)
{

}

QString IconPack::whoami() const
{ 
    setuid_ex(0);
    return QString::fromStdString(exec("whoami"));
}

QString IconPack::listIconPacks() const
{ 
    return QString::fromStdString(exec("cd /usr/share/; ls -d harbour-themepack-* | cut -c19-"));
}

bool IconPack::apply_icons(const QString& name, bool homescreen) const
{
    std::string c_name = name.toStdString();
    std::string command = "/usr/share/sailfishos-uithemer/apply.sh "+c_name;
    system(command.c_str());

    if(homescreen)
        system("/usr/share/sailfishos-uithemer/homescreen.sh");

    return true;
}

bool IconPack::apply_fonts(const QString& name, const QString& font_s) const
{
    std::string c_name = name.toStdString();
    std::string c_font_s = font_s.toStdString();
    std::string command = "/usr/share/sailfishos-uithemer/apply_font.sh "+c_name+" "+c_font_s;
    system(command.c_str());
    return true;
}

bool IconPack::restart_homescreen() const
{
    setuid_ex(0);
    system("/usr/share/sailfishos-uithemer/homescreen.sh");
    return true;
}

bool IconPack::reinstall_icons() const
{
     setuid_ex(0);
     system("/usr/share/sailfishos-uithemer/reinstall_icons.sh");
     return true;
}

bool IconPack::reinstall_fonts() const
{
     setuid_ex(0);
     system("/usr/share/sailfishos-uithemer/reinstall_fonts.sh");
     return true;
}

bool IconPack::apply_adpi(const QString& adpi) const
{
    std::string c_adpi = adpi.toStdString();
    std::string command = "/usr/share/sailfishos-uithemer/apply_adpi.sh "+c_adpi;
    system(command.c_str());
    return true;
}

bool IconPack::restore_adpi() const
{
    setuid_ex(0);
    system("/usr/share/sailfishos-uithemer/restore_adpi.sh");
    return true;
}

bool IconPack::restore_dpr() const
{
    setuid_ex(0);
    system("/usr/share/sailfishos-uithemer/restore_dpr.sh");
    return true;
}

QStringList IconPack::weights(const QString& packname) const
{
    QStringList ret;
    QStringList filter;
    filter << "*.ttf";
    QDir dir("/usr/share/harbour-themepack-"+packname+"/font");
    ret << dir.entryList(filter);
    return ret;
}

bool IconPack::restore(bool icons, bool fonts) const
{
    if(icons)
      system("/usr/share/sailfishos-uithemer/restore.sh");

    if(fonts)
      system("/usr/share/sailfishos-uithemer/restore_fonts.sh");
        
    return true;
}

QString IconPack::getDroidDPI() const
{
    return QString::fromStdString(exec("cat /usr/share/harbour-themepacksupport/droiddpi-current"));
}

bool IconPack::enable_service() const
{
    setuid_ex(0);
    system("/usr/share/sailfishos-uithemer/enable_service.sh");
    return true;
}

bool IconPack::disable_service() const
{
    setuid_ex(0);
    system("/usr/share/sailfishos-uithemer/disable_service.sh");
    return true;
}

QString IconPack::getTimer() const
{
    return QString::fromStdString(exec("cat /usr/share/harbour-themepacksupport/service/hours"));
}

bool IconPack::apply_hours(const QString& hours) const
{
    std::string c_hours = hours.toStdString();
    std::string command = "/usr/share/sailfishos-uithemer/apply_hours.sh "+c_hours;
    system(command.c_str());
    return true;
}
 
QStringList IconPack::capabilities(const QString& packname) const
{
    QStringList ret;
    QDir icon1("/usr/share/harbour-themepack-"+ packname +"/jolla");
    QDir icon2("/usr/share/harbour-themepack-"+ packname +"/native");
    QDir icon3("/usr/share/harbour-themepack-"+ packname +"/apk");
    QDir icon4("/usr/share/harbour-themepack-"+ packname +"/dynclock");
    QDir icon5("/usr/share/harbour-themepack-"+ packname +"/dyncal");

    bool icon_first_part = false;
    bool font_first_part = false;

    if(icon1.exists() || icon2.exists() || icon3.exists() || icon4.exists() || icon5.exists())
        icon_first_part = true;
    
    if(icon_first_part)
    {
        if(icon1.count() > 0 || icon2.count() > 0 || icon3.count() > 0 || icon4.count() > 0 || icon5.count() > 0)
            ret << QString("true");
        else
            ret << QString("false");
    }
    else
        ret << QString("false");

    QDir font1("/usr/share/harbour-themepack-"+packname+"/font");

    if(font1.exists())
        font_first_part = true;

    if(font_first_part)
    {
        if(font1.count() > 0)
            ret << QString("true");
        else
            ret << QString("false");
    }
    else
        ret << QString("false");
    
    return ret;
}

bool IconPack::hideIcon() const
{
    setuid_ex(0);
    system("echo \"NoDisplay=true\" >> /usr/share/applications/harbour-iconpacksupport.desktop");
    system("echo \"NoDisplay=true\" >> /usr/share/applications/harbour-themepacksupport.desktop");
    return true;
}

QString IconPack::getName(const QString& packname) const
{
    std::string c_packname = packname.toStdString();
    std::string command = "cat /usr/share/harbour-themepack-"+c_packname+"/package";
    return QString::fromStdString(exec(command.c_str())).trimmed();
}

bool IconPack::uninstall(const QString& packname) const
{
    std::string c_packname = packname.toStdString();
    std::string cmd = "rpm -qf /usr/share/harbour-themepack-"+c_packname+"/ --queryformat '%{NAME}\n'";
    std::string package = exec(cmd.c_str());
    std::string command = "pkcon remove "+package;
    system(command.c_str());
    return true;
}
