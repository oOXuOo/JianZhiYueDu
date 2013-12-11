#include "qtquick2controlsapplicationviewer.h"
#include <QFontDatabase>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //设置应用名字和版本
    app.setApplicationName("简致阅读");
    app.setApplicationVersion("alpha");
    //添加fontawesome设置应用字体
    int fontId = QFontDatabase::addApplicationFont(":/fonts/aw");
    QString msyh = QFontDatabase::applicationFontFamilies ( fontId ).at(0);
    QFont f(msyh);
    app.setFont(f);

    QtQuick2ControlsApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/jianzhi-alpha/main.qml"));
    viewer.show();

    return app.exec();
}
