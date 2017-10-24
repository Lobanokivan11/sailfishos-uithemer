#include "themepack.h"
#include "spawner.h"
#include <unistd.h>
#include <QDebug>

ThemePack::ThemePack(QObject* parent): QObject(parent)
{

}

bool ThemePack::hasAndroidSupport() const
{
    return this->getDroidDPI(NULL);
}

double ThemePack::droidDPI() const
{
    double dpi = 0;
    this->getDroidDPI(&dpi);
    return dpi;
}

QString ThemePack::whoami() const
{ 
    setuid_ex(0);
    return Spawner::executeSync("whoami");
}

void ThemePack::restartHomescreen() const
{
    setuid_ex(0);
    Spawner::executeSync("/usr/share/sailfishos-uithemer/homescreen.sh");
}

void ThemePack::reinstallIcons() const
{
    setuid_ex(0);
    Spawner::execute("/usr/share/sailfishos-uithemer/reinstall_icons.sh", [this]() { emit iconsRestored(); });
}

void ThemePack::reinstallFonts() const
{
    setuid_ex(0);
    Spawner::execute("/usr/share/sailfishos-uithemer/reinstall_fonts.sh", [this]() { emit fontsRestored(); });
}

void ThemePack::applyADPI(const QString& adpi)
{
    Spawner::executeSync("/usr/share/sailfishos-uithemer/apply_adpi.sh " + adpi);
    emit droidDPIChanged();
}

void ThemePack::restoreADPI() const
{
    setuid_ex(0);
    Spawner::executeSync("/usr/share/sailfishos-uithemer/restore_adpi.sh");
}

void ThemePack::restoreDPR() const
{
    setuid_ex(0);
    Spawner::executeSync("/usr/share/sailfishos-uithemer/restore_dpr.sh");
}

void ThemePack::enableService() const
{
    setuid_ex(0);
    Spawner::executeSync("/usr/share/sailfishos-uithemer/enable_service.sh");
}

void ThemePack::disableService() const
{
    setuid_ex(0);
    Spawner::executeSync("/usr/share/sailfishos-uithemer/disable_service.sh");
}

QString ThemePack::getTimer() const
{
    return Spawner::executeSync("cat /usr/share/harbour-themepacksupport/service/hours");
}

void ThemePack::applyHours(const QString& hours) const
{
    Spawner::executeSync("/usr/share/sailfishos-uithemer/apply_hours.sh " + hours);
}
 
void ThemePack::hideIcon() const
{
    setuid_ex(0);
    Spawner::executeSync("echo \"NoDisplay=true\" >> /usr/share/applications/harbour-iconpacksupport.desktop");
    Spawner::executeSync("echo \"NoDisplay=true\" >> /usr/share/applications/harbour-themepacksupport.desktop");
}

bool ThemePack::getDroidDPI(double *dpi) const
{
    QString s = Spawner::executeSync("cat /usr/share/harbour-themepacksupport/droiddpi-current").simplified();

    if(s.isEmpty())
        return false;

    if(dpi)
    {
        bool ok = false;
        *dpi = s.toDouble(&ok);
        return ok;
    }

    return true;
}
