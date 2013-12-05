#include "qtquick2controlsapplicationviewer.h"
#include <QFontDatabase>

int main(int argc, char *argv[])
{
    Application app(argc, argv);

    //添加图标字体
    int awesome_index = QFontDatabase::addApplicationFont(":/fonts/aw");
    if(awesome_index==-1)   return -2;

    QtQuick2ControlsApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/jianzhi-alpha/main.qml"));
    viewer.show();

    return app.exec();
}
