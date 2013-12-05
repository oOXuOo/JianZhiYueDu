import QtQuick 2.0
import QtQuick.Controls 1.0

Item {
    property bool next_but_visible: false
    width: parent.width
    height: parent.height

    Flickable{
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: 100
        Image{
            id: logo_on_top
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            source: "qrc:/images/logo"
            width: 150
            height: 150
        }
        Text{
            id: description1
            anchors.top: logo_on_top.bottom; anchors.topMargin: 5
            anchors.left: parent.left; anchors.leftMargin: 40
            anchors.right: parent.right; anchors.rightMargin: 40
            textFormat : Text.StyledText
            wrapMode : Text.WordWrap
            font.pixelSize: 20
            color: "black"
            text: "<div><p>大家好，欢迎使用简致阅读，一款为零散时光而生的阅读软件，为了给你精致的阅读体验，我们正不懈努力着，网站版手机版将会相继发布。</p>
<p>为了将阅读体验推到极致，为了保证文章的质量，我们不惜采用半自动的方式来采集文章；滤去一切的绚丽网页的浮华，和恼人广告的喧嚣，还原最本质的文章与文字的朴实之美。</p>
<p>我们不是文章的创造者，却是精美阅读体验的提倡者，为此，我们做的不再是文章的再链接，而是彻底的重提取，再排版。</p>
<p>热爱阅读，热爱人生，热爱简致！<br>欢迎访问我们的网址<a href='http://www.jianzhiyuedu.com'>http://www.jianzhiyuedu.com</a></p></div>"
        }
        Image{
            id: author_pic
            anchors.top: description1.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            source: "qrc:/images/my_logo"
            width: 150
            height: 150
        }
        Text{
            id: description2
            anchors.top: author_pic.bottom; anchors.topMargin: 5
            anchors.left: parent.left; anchors.leftMargin: 40
            anchors.right: parent.right; anchors.rightMargin: 40
            textFormat : Text.StyledText
            wrapMode : Text.WordWrap
            font.pixelSize: 20
            color: "black"
            text: "<div><p>黝～～，我是oOXuOo，简致阅读的发起者之一，也是Android，IOS客户端的作者，同时负责后端的文章采集和文章源的控制。<br>喜欢开源技术，喜欢精美文章，如果你对移动版本感兴趣，可以在GitHub上找到源码哦。地址是：<a href='https://github.com/oOXuOo/JianZhiYueDu'>https://github.com/oOXuOo/JianZhiYueDu</a></p></div>"
        }
    }
}
