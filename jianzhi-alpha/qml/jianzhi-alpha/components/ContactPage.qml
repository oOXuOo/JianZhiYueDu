import QtQuick 2.0
import QtQuick.Controls 1.0

Item {
    property bool next_but_visible: false
    width: parent.width
    height: parent.height

    Text{
        id: text1
        anchors.top: parent.top
        anchors.left: parent.left;anchors.leftMargin: 40
        anchors.right: parent.right;anchors.rightMargin: 40
        textFormat : Text.StyledText
        font.pointSize: 18
        wrapMode : Text.WordWrap
        color: "#111111"
        text: "<div><h1>Feedback</h1>
                <p>Have any comments about the app?<br>Send an email to olmpichero@163.com</p></div>"
    }
    Button {
        id: btn1
        height: 50
        anchors.top: text1.bottom
        anchors.left: parent.left;anchors.leftMargin: 40
        anchors.right: parent.right;anchors.rightMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Send An Email"
    }
    Text{
        id: text2
        anchors.top: btn1.bottom
        anchors.left: parent.left;anchors.leftMargin: 40
        anchors.right: parent.right;anchors.rightMargin: 40
        textFormat : Text.StyledText
        font.pointSize: 18
        wrapMode : Text.WordWrap
        color: "#111111"
        text: "<div><h1>Tips</h1>
                <p>Have a tip?<br>Use our tip form linked below.</p></div>"
    }
    Button {
        id: btn2
        height: 50
        anchors.top: text2.bottom
        anchors.left: parent.left;anchors.leftMargin: 40
        anchors.right: parent.right;anchors.rightMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Tips Form"
    }
}


