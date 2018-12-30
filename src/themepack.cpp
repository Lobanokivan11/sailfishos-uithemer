#include "themepack.h"
#include "spawner.h"
#include <unistd.h>
#include <QFileInfo>
#include <QDebug>

ThemePack::ThemePack(QObject* parent): QObject(parent)
{

}

bool ThemePack::hasAndroidSupport() const
{
    return this->getDroidDPI(NULL);
}

bool ThemePack::hasStoremanInstalled() const
{
    bool res = QFileInfo("/usr/share/harbour-storeman/qml/harbour-storeman.qml").exists();

   qDebug("%d\n", res);
   return res;
}

bool ThemePack::hasImageMagickInstalled() const
{
    bool res = QFileInfo("/usr/bin/convert").exists();

   qDebug("%d\n", res);
   return res;
}

double ThemePack::droidDPI() const
{
    double dpi = 0;
    this->getDroidDPI(&dpi);
    return dpi;
}

qint64 ThemePack::getFileSize(const QString& file)
{
    QFileInfo fi("/usr/share/" + file);
    return fi.size();
}

QString ThemePack::whoami() const
{ 
    setuid_ex(0);
    return Spawner::executeSync("whoami");
}

void ThemePack::restartHomescreen() const
{
    setuid_ex(0);
    Spawner::execute("/usr/share/sailfishos-uithemer/scripts/homescreen.sh", [this]() { emit homescreenRestarted(); });
}

void ThemePack::installDependencies() const
{
    setuid_ex(0);
    Spawner::execute("/usr/share/sailfishos-uithemer/scripts/install_dependencies.sh", [this]() { emit dependenciesInstalled(); });
}

void ThemePack::installImageMagick() const
{
    setuid_ex(0);
    Spawner::execute("/usr/share/sailfishos-uithemer/scripts/install_imagemagick.sh", [this]() { emit imageMagickInstalled(); });
}

void ThemePack::restoreIZ() const
{
    setuid_ex(0);
    Spawner::executeSync("/usr/share/sailfishos-uithemer/scripts/restore_iz.sh");
}

void ThemePack::enableService() const
{
    setuid_ex(0);
    Spawner::executeSync("/usr/share/sailfishos-uithemer/scripts/enable_service.sh");
}

void ThemePack::disableService() const
{
    setuid_ex(0);
    Spawner::executeSync("/usr/share/sailfishos-uithemer/scripts/disable_service.sh");
}

QString ThemePack::getTimer() const
{
    return Spawner::executeSync("cat /usr/share/harbour-themepacksupport/service/hours");
}

void ThemePack::applyHours(const QString& hours) const
{
    Spawner::executeSync("/usr/share/sailfishos-uithemer/scripts/apply_hours.sh " + hours);
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
