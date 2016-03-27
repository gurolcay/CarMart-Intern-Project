#include "getjson.h"
#include <QGuiApplication>
#include <QStandardPaths>
#include <QList>

GetJson::GetJson(QObject *parent) : QObject(parent)
{
}
QString GetJson::readData()
{
    QString copyPath;
#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS)
    copyPath = QStandardPaths::standardLocations(QStandardPaths::DataLocation).at(0);
#else
    copyPath = QGuiApplication::applicationDirPath();
#endif

    QFile file(copyPath + "/jSonFile.json");
    qDebug() << "Get Absolute Path" << file.fileName();

    if(!file.exists()){
        QFile resource (":/jSonFile.json");
        if(!resource.copy(copyPath + "/jSonFile.json")){
            qDebug()<<"File could not copy!";
            return QString();
        }
        resource.setPermissions( QFile::ReadOwner | QFile::WriteOwner | QFile::ExeOwner);
    }
    file.open(QFile::ReadOnly);
    QString data = QString::fromUtf8(file.readAll());
    file.close();
    return data;
}
