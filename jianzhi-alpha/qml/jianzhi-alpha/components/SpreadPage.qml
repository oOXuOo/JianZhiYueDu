
import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

Item {
    width: parent.width
    height: parent.height

    property real progress: 0
    property bool next_but_visible: false

    SequentialAnimation on progress {
        loops: Animation.Infinite
        running: true
        NumberAnimation {
            from: 0
            to: 1
            duration: 3000
        }
        NumberAnimation {
            from: 1
            to: 0
            duration: 3000
        }
    }

    Text{
        id: work_text
        anchors.top: parent.top; anchors.topMargin: 50
        anchors.left: parent.left;anchors.leftMargin: 50
        anchors.right: parent.right;anchors.rightMargin: 50
        textFormat : Text.StyledText
        font.pixelSize: 20
        wrapMode : Text.WordWrap
        color: "#111111"
        text: "<div><h1>努力开发中...</h1>
                <p>将支持腾讯微博，新浪微博，QQ空间，微信等多方信息共享平台，让您可以随时随地邀朋友共享美文</p></div>"
    }

    Column {
        spacing: 40
        anchors.centerIn: parent
        ProgressBar {
            anchors.margins: 20
            style: touchStyle
            width: 400
            value: progress
        }
    }

    Component {
        id: touchStyle
        ProgressBarStyle {
            panel: Rectangle {
                implicitHeight: 15
                implicitWidth: 400
                color: "#444"
                opacity: 0.8
                Rectangle {
                    antialiasing: true
                    radius: 1
                    color: "#468bb7"
                    height: parent.height
                    width: parent.width * control.value / control.maximumValue
                }
            }
        }
    }
}
