#include "global.h"

#include <DStandardPaths>
DCORE_USE_NAMESPACE;

static QString appName;

Global::Global(QObject *parent)
    : QObject(parent){};

void Global::setAppName(const QString &name)
{
    appName = name;
}

QString Global::getAppName()
{
    return appName;
}
