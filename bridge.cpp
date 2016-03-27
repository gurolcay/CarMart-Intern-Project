#include "bridge.h"
#include <QFile>
#include <QDebug>

Bridge::Bridge(QObject *parent) : QObject(parent)
{

}

QString Bridge::readData()
{
    QFile file("jSonFile.json");
    if (!file.exists()) {
        QFile resource(":/jSonFile.json");
        if (!resource.copy("jSonFile.json")) {
            qDebug() << "File could not copy.";
            return QString();
        }
        resource.setPermissions(
                    QFile::ReadOwner | QFile::WriteOwner | QFile::ExeOwner
                    /* = 0x1000,
                    ReadUser  = 0x0400, WriteUser  = 0x0200, ExeUser  = 0x0100,
                    ReadGroup = 0x0040, WriteGroup = 0x0020, ExeGroup = 0x0010,
                    ReadOther = 0x0004, WriteOther = 0x0002, ExeOther = 0x0001*/
                    );
    }

    file.open(QFile::ReadOnly);
    QString data = QString::fromUtf8(file.readAll());
    file.close();

    return data;
}

void Bridge::saveData(const QString &data)
{
    QFile file("jSonFile.json");
    if (!file.exists()) {
        QFile resource(":/jSonFile.json");
        if (!resource.copy("jSonFile.json")) {
            qDebug() << "File could not copy.";
            return;
        }
        resource.setPermissions(
                    QFile::ReadOwner | QFile::WriteOwner | QFile::ExeOwner
                    /* = 0x1000,
                    ReadUser  = 0x0400, WriteUser  = 0x0200, ExeUser  = 0x0100,
                    ReadGroup = 0x0040, WriteGroup = 0x0020, ExeGroup = 0x0010,
                    ReadOther = 0x0004, WriteOther = 0x0002, ExeOther = 0x0001*/
                    );
    }

    file.open(QFile::WriteOnly);
    file.write(data.toUtf8());
    file.close();
}
