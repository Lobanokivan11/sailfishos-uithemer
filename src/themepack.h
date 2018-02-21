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
        bool hasAndroidSupport() const;

    public slots:
        QString whoami() const;                         // function to test what user runs app
        QString getTimer() const;                       // gets hours from timer
        double droidDPI() const;
        qint64 getFileSize(const QString& file);
        void restartHomescreen() const;
        void ocr() const;
        void reinstallIcons() const;
        void reinstallFonts() const;
        void applyHours(const QString& hours) const;
        void applyADPI(const QString& adpi);
        void restoreADPI() const;
        void restoreDPR() const;                        // function to test what user runs app
        void restoreIZ() const;
        void enableService() const;
        void disableService() const;
        void hideIcon() const;                          // hides icon of original app, so user does not have to have two same icons on home screen

    private:
        bool getDroidDPI(double *dpi) const;

    signals:
        void iconsRestored();
        void fontsRestored();
        void ocrRestored();
        void droidDPIChanged();
};

#endif // THEMEPACK_H

