import QtQuick 2.1

Item {
    id: root
    width: parent.width
    height: c_text.contentHeight+10
    property alias user_and_comment_text: c_text.text

    /*白纸模具和阴影*/
    Rectangle {
        anchors.fill: parent
        anchors.margins: 6
        color: "#cccccc"
        /*白纸*/
        Rectangle{
            id: white_paper
            anchors.fill: parent
            anchors.leftMargin: 1
            anchors.rightMargin: 1
            anchors.bottomMargin: 2
            color: 'white'
            //纸上的文字
            Text{
                id: c_text
                anchors.fill: parent
                anchors.leftMargin: 20;anchors.rightMargin: 20
                textFormat : Text.StyledText
                wrapMode : Text.WordWrap
                font.pointSize: 18
                color: "#111111"
                text: modelData
            }
        }
    }
}
