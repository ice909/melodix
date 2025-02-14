#include <DApplication>
#include <DLog>
#include <QCommandLineParser>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "api.h"
#include "player.h"
#include "worker.h"

DWIDGET_USE_NAMESPACE;
DCORE_USE_NAMESPACE;

int main(int argc, char *argv[])
{
    if (!QString(qgetenv("XDG_CURRENT_DESKTOP")).toLower().startsWith("deepin")) {
        setenv("XDG_CURRENT_DESKTOP", "Deepin", 1);
    }
    // 告知PulseAudio系统当前的音频流是用于播放音乐，并希望系统能够相应地进行处理和调度。
    setenv("PULSE_PROP_media.role", "music", 1);

    DApplication *app = new DApplication(argc, argv);
    app->setAttribute(Qt::AA_UseHighDpiPixmaps);
    app->setOrganizationName("ice");
    app->setApplicationName("Melodix");

    app->setApplicationVersion(DApplication::buildVersion(APP_VERSION));
    app->setQuitOnLastWindowClosed(false);

    DLogManager::registerConsoleAppender();
    DLogManager::registerFileAppender();

    QCommandLineParser parser;
    parser.setApplicationDescription(
        "Melodix is an online music player with a beautiful interface.");
    parser.addHelpOption();
    parser.addVersionOption();
    parser.process(*app);

    app->loadTranslator();

    // 在此处注册QML中的C++类型
    qmlRegisterSingletonInstance<Player>("Melodix.Player", 1, 0, "Player", Player::instance());
    qmlRegisterSingletonInstance<API>("Melodix.API", 1, 0, "API", API::instance());

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Worker", Worker::instance());
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app->exec();
}