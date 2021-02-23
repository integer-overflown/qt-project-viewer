import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    required property string token

    Rectangle {
        id: header
        width: parent.width
        height: 40
        color: "lightgray"
        Row {
            anchors.centerIn: parent
            height: parent.height
            spacing: 4
            Image {
                source: "qrc:/images/q_letter.png"
                anchors.verticalCenter: parent.verticalCenter
                width: 40
                height: 20
            }
            Text {
                text: "All projects"
                font.pointSize: 14
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: TextInput.AlignHCenter
            }
        }
    }
    ScrollView {
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        anchors.top: header.bottom
        width: 2 * items.paddingX + items.itemSize
        height: parent.height - header.height
        clip: true
        ListView {
            readonly property int itemSize: 32
            readonly property int paddingX: 16
            readonly property int paddingY: 12
            id: items
            model: 20
            spacing: 8
            anchors.fill: parent
            header: Rectangle {
                width: parent.width
                height: items.paddingY
            }
            delegate: Rectangle {
                x: items.paddingX
                width: items.itemSize
                height: items.itemSize
                radius: items.itemSize / 2
                color: "green"
            }
        }
    }
}
