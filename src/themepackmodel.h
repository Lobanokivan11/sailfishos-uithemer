#ifndef THEMEPACKMODEL_H
#define THEMEPACKMODEL_H

#include <QAbstractListModel>
#include <QDir>

class ThemePackModel : public QAbstractListModel
{
    Q_OBJECT

    public:
        enum ThemePackRoles { PackDisplayNameRole = Qt::UserRole, PackNameRole };

    public:
        explicit ThemePackModel(QObject *parent = 0);

    private:
        QString readThemePackName(const QString& packname) const;
        bool hasCapability(int index, const QString& capability) const;

    public slots:
        void applyIcons(int index, bool notify, bool overlay) const;
        void iconsPreview(int index) const;
        void applyFonts(int index, const QString& font) const;
        void restore(bool icons, bool fonts);
        void uninstall(int index);

    public slots:
        QString packName(int index) const;
        QString packDisplayName(int index) const;
        bool hasIcons(int index) const;
        bool hasJolla(int index) const;
        bool hasNative(int index) const;
        bool hasApk(int index) const;
        bool hasIconOverlay(int index) const;
        bool hasFont(int index) const;
        bool hasFontNonLatin(int index) const;
        bool hasDynClock(int index) const;
        bool hasDynCal(int index) const;
        void reloadAll();

    public:
        virtual QHash<int, QByteArray> roleNames() const;
        virtual QVariant data(const QModelIndex &index, int role) const;
        virtual int rowCount(const QModelIndex &) const;

    signals:
        void iconApplied();
        void fontApplied();
        void iconsPreviewed();
        void restoreCompleted();
        void uninstallCompleted();

    private:
        QStringList _packlist;
        QStringList _packnames;
};

#endif // THEMEPACKMODEL_H
