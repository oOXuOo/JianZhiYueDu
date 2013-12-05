import QtQuick 2.1
import QtQuick.Controls 1.0
import "components"

ApplicationWindow {

    width: 500
    height: 1000

    Rectangle {
        id: appbackground
        color: "#f0f0f0"
        anchors.fill: parent
        states: [
            State {
                name: "contextMenuOpen"
                //当mainView不再拥有焦点时
                when: !mainView.activeFocus
                PropertyChanges { target: contextMenu; x: 0 }
                PropertyChanges { target: mainView; x: 300 }
                PropertyChanges { target: shade; opacity: 0.4 }
            }
        ]
        transitions: Transition {
            NumberAnimation { properties: "x,opacity"; duration: 500; easing.type: Easing.OutQuint }
        }
    }

    toolBar: BorderImage {
        border.top: 3;border.bottom: 3;border.left: 2;border.right: 2
        source: 'qrc:/images/toolbar'
        width: parent.width
        height: 80
        Rectangle {
            id: navButton
            width: 50
            height: 50
            radius: 5
            color: backmouse.pressed ? "#3d3d3d" : "transparent"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            Text{
                opacity: backmouse.pressed? 0.25:1
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: "<font color='white'>\uf00b</font>"
                style: Text.Raised
                styleColor : "#7176e9"
                font.pixelSize: 38
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                /*防止点击区域过小，外延10px*/
                anchors.margins: -10
                /*点击：呼出|隐藏 导航栏--contextMenu*/
                onClicked: if(contextMenu.focus){
                               contextMenu.focus=false
                               mainView.focus=true
                           }else{
                               contextMenu.focus=true
                               mainView.focus=false
                           }
            }
        }
        Rectangle {
            id: nextButton
            width: 50
            height: 50
            radius: 5
            color: nextmouse.pressed ? "#3d3d3d" : "transparent"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            opacity: stackView.currentItem.next_but_visible?1:0
            visible: opacity?true:false
            Behavior on opacity {NumberAnimation{}}
            Text{
                opacity: nextmouse.pressed? 0.25:1
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: "<font color='white'>\uf061</font>"
                style: Text.Raised
                styleColor : "#7176e9"
                font.pixelSize: 40
            }

            MouseArea {
                id: nextmouse
                anchors.fill: parent
                /*防止点击区域过小，外延10px*/
                anchors.margins: -10
                /*点击：载入下一篇*/
                onClicked: {}
            }
        }
        Rectangle {
            id: editButton
            width: 50
            height: 50
            radius: 5
            color: editmouse.pressed ? "#3d3d3d" : "transparent"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            opacity: stackView.currentItem.edit_but_visible?1:0
            visible: opacity?true:false
            Behavior on opacity {NumberAnimation{}}
            Text{
                opacity: nextmouse.pressed? 0.25:1
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: "<font color='white'>\uf14b</font>"
                style: Text.Raised
                styleColor : "#7176e9"
                font.pixelSize: 38
            }

            MouseArea {
                id: editmouse
                anchors.fill: parent
                /*防止点击区域过小，外延10px*/
                anchors.margins: -10
                /*点击：载入下一篇*/
                onClicked: {
                    if(!stackView.currentItem.cmd_v)
                        stackView.currentItem.cmd_v=true;
                }
            }
        }
        Text {
            //This kit will change later
            id: text_logo
            font.pixelSize: 45
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: "<b>简致阅读</b>"
            style: Text.Raised
            styleColor : "#7176e9"
        }
    }

    FocusScope {
        id: mainView
        width: parent.width; height: parent.height
        focus: true

        StackView {
                id: stackView
                anchors.fill: parent
                initialItem: Qt.resolvedUrl("components/HomePage.qml")
        }
        Rectangle {
            id: shade
            anchors.fill: parent
            color: "black"
            opacity: 0
        }
    }

    Rectangle {
        id: contextMenu
        x: -305; width: 300; height: parent.height
        focus: true
        color: "#3d3d3d"
        //给出列表模板(主要是项数和文字，不含样式信息)
        ListModel {
            id: pageModel
            ListElement {
                title: "Home"
                page: "components/HomePage.qml"
                icon_source: "<font>\uf015</font>"
            }
            ListElement {
                title: "Spread"
                page: "components/SpreadPage.qml"
                icon_source: "<font>\uf0a1</font>"
            }
            ListElement {
                title: 'Comment'
                page: "components/CommentPage.qml"
                icon_source: "<font color='white'>\uf10d</font>"
            }
            ListElement {
                title: "Save"
                page: "components/SavePage.qml"
                icon_source: "<font>\uf019</font>"
            }
            ListElement {
                title: "Contact"
                page: "components/ContactPage.qml"
                icon_source: "<font>\uf0e0</font>"

            }
            ListElement {
                title: "About"
                page: "components/AboutPage.qml"
                icon_source: "<font>\uf113</font>"
            }
        }
        //根据模板生成列表
        ListView {
            model: pageModel
            anchors.fill: parent
            //指定列表及项的样式--AndroidDelegate
            delegate: AndroidDelegate {
                text: title
                icon: icon_source
                onClicked: {
                    contextMenu.focus=false
                    mainView.focus=true
                    stackView.push({item:Qt.resolvedUrl(page),immediate: true})
                }
            }
        }
    }

}
