import QtQuick 2.0
import QtQuick.Controls 1.0

Item {
    property bool next_but_visible: true
    width: parent.width
    height: parent.height

    Flickable{
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: ar_text.contentHeight+ar_btn.height+22+
                       white_paper_module_and_shadow.anchors.margins*2
        /*白纸模具和阴影*/
        Rectangle {
            id: white_paper_module_and_shadow
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
                    id: ar_text
                    anchors.fill: parent
                    anchors.leftMargin: 20;anchors.rightMargin: 20
                    textFormat : Text.StyledText
                    wrapMode : Text.WordWrap
                    font.pointSize: 18
                    color: "#111111"
                    text: qsTr("<div><h1>愿</h1><p>作者：许地山</p>
<p>南普陀寺里的大石，雨后稍微觉得干净了些，不过绿苔长多了一些，天涯的淡霞好像在给我们一个天晴的信号。</p>
<p>树林里的虹气，被阳光分成七色。树上，雄虫求雌的声音，凄凉得使人不忍听下去。</p>
<p>妻子坐在石上，见我来，就问：“你从哪里来？我等你许久了。”</p>
<p>“我领着孩子们到海边捡贝壳呢。阿琼捡着一个破贝，虽不完整，里面却像藏着珠子的样子。等他来了，我叫他拿出来给你看一看。</p>
<p>“在这树阴底下坐着，真舒服呀！我们天天到这里来，多好啊！”</p>
<p>妻说：“你哪里能够……”</p>
<p>“为什么不能？”</p>
<p>“你应当‘做荫’，不应当‘受荫’。”</p>
<p>“你愿我做这样的荫吗？”</p>
<p>“这样的荫算什么！我愿你做无边宝华盖，能普荫一切世间诸有情；愿你为如意净明珠，能普照一切世间诸有情；愿你为降魔金刚杵，能破坏一切世间诸障碍；愿你为多宝盂兰盆，能盛百味，滋养一切世间诸饿渴者；愿你有六手、十二手、百手、千万手，无量数那由他如意手，能成全一切世间美善事。”</p>
<p>我说：“极善，极妙！但我愿做调味的精盐，渗入食品中，把自己的形骸融散，且恢复当时在海里的面目，使一切有情得尝咸味，而不见盐体。”</p>
<p>妻子说：“只有调味，就能使一切有情都满足吗？”</p>
<p>我说：“盐的功用，若只在调味，那就不配称为盐了。”</p>
</div>")
                }
                //纸上的按钮
                Button {
                    id: ar_btn
                    height: 50
                    width: parent.width-30
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: 10
                    text: "\uf164我喜欢,赞一个"
                }
            }
        }
    }
}
