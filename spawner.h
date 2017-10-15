#ifndef SPAWNER_H
#define SPAWNER_H

#include <QJSValue>
#include <QObject>
#include <QProcess>
#include <QHash>

#define SPAWN_ARGS(...) (QStringList() << __VA_ARGS__)

class Spawner : public QObject
{
    Q_OBJECT

    private:
        explicit Spawner(QObject *parent = nullptr);

    public:
        static void execute(const QString& command, const QStringList& arguments, QJSValue done);
        static void execute(const QString& command, QJSValue done);

    private:
        static QHash<QProcess*, QJSValue> _callbackmap;
};

#endif // SPAWNER_H
