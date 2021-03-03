import QtQuick
import QtQuick.Controls

import com.overflown.qmlcomponents
import "qrc:/components"

Item {
    id: root
    required property string token

    states: [
        State {
            name: "loading"
            StateChangeScript {
                script: {
                    tickets.model.clear();
                }
            }
        },
        State {
            name: "ready"
        },
        State {
            name: "noTicketsPresent"
        }
    ]

    state: "loading"

    // background
    Rectangle {
        anchors.fill: parent
        color: "lightgray"
    }

    Rectangle {
        id: contentArea
        anchors {
            top: header.bottom
            right: parent.right
            bottom: parent.bottom
            left: itemsScroll.right
        }
        color: 'transparent'
    }

    BusyIndicator {
        anchors.centerIn: contentArea
        running: root.state === "loading"
    }

    Text {
        anchors.centerIn: contentArea
        font {
            pointSize: 14
            italic: true
        }
        text: "Nothing here yet\u2026" // unicode symbol stands for ellipsis
        visible: root.state === "noTicketsPresent"
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
            }
            spacing: itemSpacing
            delegate: TicketItem {

            }
            onCurrentItemChanged: {
                if (tickets.count > 0)
                    root.state = "ready";
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
            onCurrentItemChanged: {
                if (root.state !== "loading")
                    root.state = "loading";
                tickets.model.projectId = items.currentItem.project.id;
            }
        }
    }

    Connections {
        target: tickets.model
        function onPushed(count) {
            // check if no items were pushed and list is empty
            if (count + tickets.count === 0)
                root.state = "noTicketsPresent";
        }
    }
}
