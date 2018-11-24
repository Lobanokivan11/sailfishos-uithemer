#include "themepackmodel.h"
#include "spawner.h"
#include <unistd.h>
#include <algorithm>
#include <QDebug>

#define setuid_ex(x) if(setuid(x)) { }
#define RAW_PACK_NAME(x) QString(x).replace("harbour-themepack-", "")

ThemePackModel::ThemePackModel(QObject *parent) : QAbstractListModel(parent)
{
    this->reloadAll();
}

QString ThemePackModel::readThemePackName(const QString &packname) const
{
    QFile file("/usr/share/" + packname + "/package");
    file.open(QFile::ReadOnly);
    QString s = file.readAll().simplified();
    file.close();
    return s;
}

bool ThemePackModel::hasCapability(int index, const QString &capability) const
{
    if(this->_packnames.empty())
        return false;

    QDir dir("/usr/share/" + this->_packlist[index] + "/" + capability);

    if(!dir.exists())
        return false;

    return dir.count() > 0;
}

void ThemePackModel::applyIcons(int index, bool notify, bool overlay) const
{
    Spawner::execute("/usr/share/sailfishos-uithemer/apply.sh", SPAWN_ARGS(RAW_PACK_NAME(this->_packlist[index]) << QString::number(overlay)), [this, notify]() {
        if(!notify)
            return;

        emit iconApplied();
    });
}

void ThemePackModel::applyFonts(int index, const QString &font) const
{
    Spawner::execute("/usr/share/sailfishos-uithemer/apply_font.sh", SPAWN_ARGS(RAW_PACK_NAME(this->_packlist[index]) << font), [this]() { emit fontApplied(); });
}

void ThemePackModel::restore(bool icons, bool fonts)
{
    if(icons)
    {
        Spawner::execute("/usr/share/sailfishos-uithemer/restore.sh", [this, fonts]() {
            if(fonts)
                return;

            emit restoreCompleted();
        });
    }

    if(fonts)
        Spawner::execute("/usr/share/sailfishos-uithemer/restore_fonts.sh", [this, fonts]() { emit restoreCompleted(); });
}

void ThemePackModel::uninstall(int index)
{
    QString package = Spawner::executeSync("rpm -qf /usr/share/" + this->_packlist[index] + "/ --queryformat '%{NAME}\n'");

    Spawner::execute("rpm", SPAWN_ARGS("-e" << package), [this, index]() {
        this->beginRemoveRows(QModelIndex(), index, index);
        this->_packlist.removeAt(index);
        this->_packnames.removeAt(index);
        this->endRemoveRows();

        emit uninstallCompleted();
    });
}

QString ThemePackModel::packName(int index) const
{
    if(this->_packlist.empty())
        return QString();

    return this->_packlist[index];
}

QString ThemePackModel::packDisplayName(int index) const
{
    if(this->_packnames.empty())
        return QString();

    return this->_packnames[index];
}

bool ThemePackModel::hasIcons(int index) const
{
    return this->hasJolla(index) || this->hasNative(index) || this->hasApk(index) ||
           this->hasDynClock(index) || this->hasDynCal(index);
}

bool ThemePackModel::hasJolla(int index) const
{
    return this->hasCapability(index, "jolla");
}

bool ThemePackModel::hasNative(int index) const
{
    return this->hasCapability(index, "native");
}

bool ThemePackModel::hasApk(int index) const
{
    return this->hasCapability(index, "apk");
}

bool ThemePackModel::hasIconOverlay(int index) const
{
    return this->hasCapability(index, "overlay");
}

bool ThemePackModel::hasFont(int index) const
{
    return this->hasCapability(index, "font");
}

bool ThemePackModel::hasFontNonLatin(int index) const
{
    return this->hasCapability(index, "font-nonlatin");
}

bool ThemePackModel::hasDynClock(int index) const
{
    return this->hasCapability(index, "dynclock");
}

bool ThemePackModel::hasDynCal(int index) const
{
    return this->hasCapability(index, "dyncal");
}

void ThemePackModel::reloadAll()
{
    QDir dir("/usr/share");
    dir.setNameFilters(QDir::nameFiltersFromString("harbour-themepack-*"));

    this->beginResetModel();
    QStringList entries = dir.entryList(QDir::Dirs, QDir::Name);

    this->_packlist.clear();
    this->_packnames.clear();

    std::for_each(entries.begin(), entries.end(), [this](const QString& packname) {
        this->_packlist << packname;
        this->_packnames << this->readThemePackName(packname);
    });

    this->endResetModel();
}

QHash<int, QByteArray> ThemePackModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[ThemePackRoles::PackDisplayNameRole] = "packDisplayName";
    roles[ThemePackRoles::PackNameRole] = "packName";
    return roles;
}

QVariant ThemePackModel::data(const QModelIndex &index, int role) const
{
    if(role == ThemePackRoles::PackDisplayNameRole)
        return this->_packnames[index.row()];

    if(role == ThemePackRoles::PackNameRole)
        return RAW_PACK_NAME(this->_packlist[index.row()]);

    return QVariant();
}

int ThemePackModel::rowCount(const QModelIndex &) const
{
    return this->_packlist.count();
}
