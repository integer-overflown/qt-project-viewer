import QtQuick
import QtQuick.Controls

import com.overflown.qmlcomponents
import "qrc:/components"

Item {
    id: root
    required property string token

    // background
    Rectangle {
        anchors.fill: parent
        color: "lightgray"
    }
    Rectangle {
        id: header
        width: parent.width
        height: 40
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
        readonly property int itemPadding: 16
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        anchors {
            top: header.bottom
            left: itemsScroll.right
            right: parent.right
            bottom: parent.bottom
        }
        topPadding: tickets.itemSpacing
        leftPadding: itemPadding
        clip: true
        ListView {
            id: tickets
            property real itemWidth: root.width - (itemsScroll.width + 2 * parent.itemPadding)
            property int  itemSpacing: 12
            model: TicketModel {
                id: ticketModel
                token: root.token
                // prevent reading model data if the list hasn't been initialized yet
                projectId: items.currentItem ? items.currentItem.project.id : invalid
            }
            spacing: itemSpacing
            delegate: TicketItem {

            }
        }
    }
    // shadow under header
    Rectangle {
        anchors.top: header.bottom
        width: header.width
        height: 6
        gradient: Gradient {
            GradientStop { position: 0; color: "gray" }
            GradientStop { position: 1; color: "lightgray" }
        }
    }
    ScrollView {
        id: itemsScroll
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        anchors.top: header.bottom
        width: items.itemWidth
        height: parent.height - header.height
        clip: true
        Rectangle {
            anchors.fill: parent
        }
        ListView {
            id: items
            readonly property int iconSize: 32
            readonly property int horizontalPadding: 16
            readonly property int verticalPadding: 12
            readonly property int itemWidth: iconSize + 2 * horizontalPadding
            readonly property int itemHeight: iconSize + 2 * verticalPadding

            model: ProjectModel {
                token: root.token
            }
            anchors.fill: parent
            header: Rectangle {
                width: parent.width
                height: items.paddingY
            }
            delegate: ProjectItem {

            }
        }
    }
}
