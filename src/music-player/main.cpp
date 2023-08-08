#include <DApplication>
#include <DLog>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "network.h"
#include "player.h"

DWIDGET_USE_NAMESPACE;
DCORE_USE_NAMESPACE;

int main(int argc, char *argv[])
{
    if (!QString(qgetenv("XDG_CURRENT_DESKTOP")).toLower().startsWith("deepin")) {
        setenv("XDG_CURRENT_DESKTOP", "Deepin", 1);
    }
    // 告知PulseAudio系统当前的音频流是用于播放音乐，并希望系统能够相应地进行处理和调度。
    setenv("PULSE_PROP_media.role", "music", 1);

    if (qEnvironmentVariableIsEmpty("XDG_CURRENT_DESKTOP")) {
        qputenv("XDG_CURRENT_DESKTOP", "Deepin");
    }
    qputenv("D_POPUP_MODE", "embed");

    DApplication *app = new DApplication(argc, argv);
    app->setAttribute(Qt::AA_UseHighDpiPixmaps);
    app->setOrganizationName("ice");
    app->setApplicationName("music");

    app->setApplicationVersion(DApplication::buildVersion(APP_VERSION));

    DLogManager::registerConsoleAppender();
    DLogManager::registerFileAppender();

    QCommandLineParser parser;
    parser.setApplicationDescription("Deepin music player.");
    parser.addHelpOption();
    parser.addVersionOption();
    parser.process(*app);

    app->loadTranslator();

    // 在此处注册QML中的C++类型
    qmlRegisterType<Network>("network", 1, 0, "Network");
    qmlRegisterType<Player>("player", 1, 0, "Player");

    app->setApplicationName("music");
    qApp->setProductIcon(QIcon::fromTheme("deepin-music"));
    qApp->setApplicationDisplayName("music");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app->exec();
}