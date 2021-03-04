import QtQuick
import QtQuick.Controls

import com.overflown.qmlcomponents
import "qrc:/components" as CustomComponents

CustomComponents.BasicForm {
    id: root
    required property string token

    title: "All projects"

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
        z: -1
        ListView {
            id: tickets
            property real itemWidth: root.width - (itemsScroll.width + 2 * parent.itemPadding)
            property int  itemSpacing: 12
            model: TicketModel {
                id: ticketModel
                token: root.token
            }
            spacing: itemSpacing
            delegate: CustomComponents.TicketItem {

            }
            onCurrentItemChanged: {
                if (tickets.count > 0)
                    root.state = "ready";
            }
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
            delegate: CustomComponents.ProjectItem {

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
