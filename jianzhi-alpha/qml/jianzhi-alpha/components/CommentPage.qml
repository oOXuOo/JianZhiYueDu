import QtQuick 2.0
import QtQuick.Controls 1.0

Item {
    property bool edit_but_visible: true
    property alias cmd_v: write_cm.visible
    width: parent.width
    height: parent.height

    //给出列表模板(主要是项数和文字，不含样式信息)
    ListModel {
        id: commentpageModel
        ListElement {
            text: "<div><h1>Ooops</h1><p>文章写的很有深意~~</p></div>"
        }
        ListElement {
            text: "<div><h1>Yicong</h1><p>要是大家都这么想，这么做该有多好</p></div>"
        }
        ListElement {
            text: "<div><h1>oOXuOo</h1><p>以后多弄这样的文章，很好，很有嚼头。。。</p></div>"
        }
        ListElement {
            text: "<div><h1>我是丫头</h1><p>这个阅读器很好玩的嘛</p></div>"
        }
        ListElement {
            text: "<div><h1>花花</h1><p>真的不知道要说什么了，好赶啊，下雨啊，比赛啊，什么的。。。还有就是乱写的啊，冒充评论啊，不要这样子啊，不知到几点能回去啊啊。
一聪今天很紧张啊，哈哈，不过表现不错的，至少分很高的说。</p></div>"
        }
        ListElement {
            text: "<div><h1></h1><p>blabla</p></div>"
        }
        ListElement {
            text: "<div><h1>ShopAssistant</h1><p>这个大哥好奇怪啊，一边不断的强调什么语言平台都是浮云什么的，
一边却在不断强调这个东东用windows+C++来实现是多么的困难，额，这是什么逻辑啊！</p></div>"
        }
    }
    //根据模板生成列表
    ListView {
        model: commentpageModel
        anchors.top: write_cm.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        //指定列表及项的样式--CommentsDelegate
        delegate: CommentsDelegate {
            user_and_comment_text: text
        }
    }
    //可呼出--发表评论的控件
    Rectangle {
        id: write_cm
        anchors.top: parent.top;anchors.topMargin: 6
        anchors.left: parent.left;anchors.leftMargin: 6
        anchors.right: parent.right;anchors.rightMargin: 6
        color: "#cccccc"
        height: visible?200:0
        Behavior on height {NumberAnimation{duration: 300;easing.type: Easing.InOutQuint}}
        visible: false
        /*灰色的纸*/
        Rectangle{
            anchors.fill: parent
            anchors.leftMargin: 1
            anchors.rightMargin: 1
            anchors.bottomMargin: 2
            color: '#dddddd'

            //输入名字
            TextInput{
               id: write_name
               visible: write_cm.height===200?true:false
               height:40
               anchors.top: flick.bottom;anchors.topMargin: 6
               anchors.left: parent.left;anchors.leftMargin: 6
               text: "请留下您的大名"
               focus: false
               color: "#222222"
               font.pixelSize: 20
            }

            //分割符
            Image {
                anchors.top: flick.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                visible: write_cm.height===200?true:false
                anchors.margins: 1
                height: 2
                source: "qrc:/images/divider"
            }

            //输入评论文字
            Flickable {
                 id: flick
                 visible: write_cm.height===200?true:false
                 height: 140;
                 width: parent.width-12
                 anchors.top: parent.top;anchors.topMargin: 6
                 anchors.horizontalCenter: parent.horizontalCenter
                 contentWidth: edit.paintedWidth
                 contentHeight: edit.paintedHeight
                 clip: true
                 function ensureVisible(r)
                 {
                     if (contentX >= r.x)
                         contentX = r.x;
                     else if (contentX+width <= r.x+r.width)
                         contentX = r.x+r.width-width;
                     if (contentY >= r.y)
                         contentY = r.y;
                     else if (contentY+height <= r.y+r.height)
                         contentY = r.y+r.height-height;
                 }

                 TextEdit {
                     id: edit
                     text: "请在此处写下评论..."
                     width: flick.width
                     height: flick.height
                     focus: false
                     wrapMode: TextEdit.Wrap
                     font.pixelSize: 20
                     onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                 }
             }

            //发表按钮
            Button {
                id: make_cmt
                visible: write_cm.height===200?true:false
                height: 40
                width: 150
                anchors.top: flick.bottom;anchors.topMargin: 6
                anchors.right: parent.right;anchors.rightMargin: 6
                text: "发表评论"
                onClicked: {cmd_v=false;write_name.focus=false;edit.focus=false}
            }
        }
    }
}

