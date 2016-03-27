#include "main.h"

void Makes::readJson(QJsonObject &json)
{
    QFile inputFile;
    inputFile.setFileName("jSonFile.json");
    inputFile.open(QIODevice::ReadOnly | QIODevice::Text);

    name = json["name"].toString();
    miles = json["miles"].toString();
    drive = json["drive"].toString();

    inputFile.close();
    //qWarning() << val;

    //emit sgnl(val.name);

}
