#ifndef THEMEPACK_H
#define THEMEPACK_H

#include <QObject>

class ThemePack : public QObject
{
    Q_PROPERTY(bool hasAndroidSupport READ hasAndroidSupport CONSTANT FINAL)
    Q_PROPERTY(double droidDPI READ droidDPI NOTIFY droidDPIChanged)

    Q_OBJECT

    public:
        explicit ThemePack(QObject* parent = 0);

    public slots:
        bool hasAndroidSupport() const;
        bool hasStoremanInstalled() const;
        bool hasImageMagickInstalled() const;
        QString whoami() const;                         // function to test what user runs app
        QString getTimer() const;                       // gets hours from timer
        double droidDPI() const;
        qint64 getFileSize(const QString& file);
        void installDependencies() const;
        void installImageMagick() const;
        void restartHomescreen() const;
        void applyHours(const QString& hours) const;
        void enableddensity() const;
        void disableddensity() const;
        void restoreIZ() const;
        void enableserviceautoupdate() const;
        void disableserviceautoupdate() const;
        void enableservicesu() const;
        void disableservicesu() const;
        void hideIcon() const;                          // hides icon of original app, so user does not have to have two same icons on home screen

    private:
        bool getDroidDPI(double *dpi) const;

    signals:
        void dependenciesInstalled();
        void imageMagickInstalled();
        void homescreenRestarted();
        void droidDPIChanged();
        void serviceChanged();
};

#endif // THEMEPACK_H

