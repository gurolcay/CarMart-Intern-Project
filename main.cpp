#include "bridge.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Bridge bridge;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("bridge", &bridge);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
