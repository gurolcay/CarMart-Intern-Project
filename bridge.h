#ifndef BRDGE_H
#define BRDGE_H

#include <QObject>

class Bridge : public QObject
{
    Q_OBJECT
public:
    explicit Bridge(QObject *parent = 0);

    Q_INVOKABLE QString readData();
    Q_INVOKABLE void saveData(const QString &data);

signals:

public slots:
};

#endif // BRDGE_H
