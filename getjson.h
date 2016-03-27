#ifndef GETJSON_H
#define GETJSON_H

#include <QObject>
#include <QFile>
#include <QDebug>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QScreen>

#if defined(Q_OS_ANDROID)
    #include <QtAndroidExtras>
#endif

class GetJson : public QObject
{
    Q_OBJECT
public:
    explicit GetJson(QObject *parent = 0);

    Q_INVOKABLE QString readData();
signals:

public slots:
};

#endif // GETJSON_H
