#include "spawner.h"
#include <QProcess>

QHash<QProcess*, QJSValue> Spawner::_callbackmap;

Spawner::Spawner(QObject *parent) : QObject(parent)
{

}

void Spawner::execute(const QString &command, const QStringList &arguments, QJSValue done)
{
    QProcess* p = new QProcess();

    connect(p, static_cast<void(QProcess::*)(int)>(&QProcess::finished), [p](int) {
        QJSValue cb = _callbackmap[p];

        if(cb.isCallable())
            cb.call();

        _callbackmap.remove(p);
        p->deleteLater();
    });

    _callbackmap[p] = done;
    p->setProcessChannelMode(QProcess::ForwardedChannels);
    p->start(command, arguments);
}

void Spawner::execute(const QString &command, QJSValue done)
{
    Spawner::execute(command, QStringList(), done);
}
