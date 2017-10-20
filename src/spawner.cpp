#include "spawner.h"
#include <QProcess>

QHash< QProcess*, std::function<void()> > Spawner::_callbackmap;

Spawner::Spawner(QObject *parent) : QObject(parent)
{

}

void Spawner::execute(const QString &command, const QStringList &arguments, std::function<void ()> done)
{
    QProcess* p = new QProcess();

    connect(p, static_cast<void(QProcess::*)(int)>(&QProcess::finished), [p](int) {
        auto cb = _callbackmap[p];

        if(cb)
            cb();

        _callbackmap.remove(p);
        p->deleteLater();
    });

    _callbackmap[p] = done;
    p->setProcessChannelMode(QProcess::ForwardedChannels);
    p->start(command, arguments);
}

void Spawner::execute(const QString &command, std::function<void()> done)
{
    Spawner::execute(command, QStringList(), done);
}
