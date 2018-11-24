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
    Spawner::execute("/usr/share/sailfishos-uithemer/homescreen.sh", [this]() { emit restartHomescreenRestored(); });
}

void ThemePack::installDependencies() const
{
    setuid_ex(0);
    Spawner::execute("/usr/share/sailfishos-uithemer/install_dependencies.sh", [this]() { emit dependenciesInstalled(); });
}

void ThemePack::installImageMagick() const
{
    setuid_ex(0);
    Spawner::execute("/usr/share/sailfishos-uithemer/install_imagemagick.sh", [this]() { emit imageMagickInstalled(); });
}

void ThemePack::ocr() const
{
    setuid_ex(0);
    Spawner::execute("/usr/share/sailfishos-uithemer/ocr.sh", [this]() { emit ocrRestored(); });
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

void ThemePack::restoreIZ() const
{
    setuid_ex(0);
    Spawner::executeSync("/usr/share/sailfishos-uithemer/restore_iz.sh");
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
