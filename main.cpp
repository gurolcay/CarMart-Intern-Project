#include "getjson.h"

//cihaz ekranina gore boyutlandırma yapilmasi icin gerekli kod
static inline void setCalculatedDpiScale(QQmlContext *rootContext)
{
    int dpi = 0;
    int actualDpi = 0;

    QScreen *screen = qApp->primaryScreen();

#if defined(Q_OS_OSX) || defined(Q_OS_WIN)
    dpi = screen->logicalDotsPerInch() * screen->devicePixelRatio();
    actualDpi = dpi;
#elif defined(Q_OS_ANDROID)
    QAndroidJniEnvironment env;
    QAndroidJniObject activity = QtAndroid::androidActivity();
    QAndroidJniObject resources = activity.callObjectMethod("getResources","()Landroid/content/res/Resources;");
    if(env->ExceptionCheck()){
        env->ExceptionDescribe();
        env->ExceptionClear();

        dpi = screen->physicalDotsPerInch()*screen->devicePixelRatio();
    }
    else{
        QAndroidJniObject displayMetrics = resources.callObjectMethod("getDisplayMetrics","()Landroid/util/DisplayMetrics;");
        if(env->ExceptionCheck()){
            env->ExceptionDescribe();
            env->ExceptionClear();

            dpi = screen->physicalDotsPerInch() * screen->devicePixelRatio();
        }
        else{
            dpi = displayMetrics.getField<int>("densityDpi");
        }
    }
    actualDpi = dpi;
#elif defined (Q_OS_IOS)
    dpi = screen->physicalDotsPerInch();
    actualDpi = screen->physicalDotsPerInch()*screen->devicePixelRatio();
#else
    dpi = screen->physicalDotsPerInch()*screen->devivePixelRatio();
    actualDpi = dpi;
#endif

    if(dpi < 160)
        dpi = 160;
    int scaleFactor = (int)(dpi/160);
    int actualScaleFactor = (int)(actualDpi / 160);

    rootContext->setContextProperty(QLatin1String("dpiScaleFactor"),scaleFactor);
    rootContext->setContextProperty(QLatin1String("dpiActualScaleFactor"),actualScaleFactor);

    qDebug() << "[MAIN]" << "DPI" << dpi << "Scale Factor" << scaleFactor << "Actual Scale Factor" << actualScaleFactor;

}
//boyutlandırma kodu sonu

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    GetJson getJson;

    QQmlApplicationEngine engine;

    QQmlContext *context1 = engine.rootContext();
    setCalculatedDpiScale(context1);

    engine.rootContext()->setContextProperty("getJson",&getJson);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    return app.exec();
}
