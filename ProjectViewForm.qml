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

    Component {
        id: projectItemDelegate
        Rectangle {
            id: delegate
            required property var project // model property object
            required property int index

            width: ListView.view.itemWidth
            height: ListView.view.itemHeight
            color: ListView.isCurrentItem ? 'midnightblue' : 'transparent'

            RoundImage {
                anchors.centerIn: parent
                width: delegate.ListView.view.iconSize
                height: width
                source: project.icon
            }

            Separator {
            }

            Separator {
                y: parent.height - height
                visible: delegate.index === delegate.ListView.view.count - 1
            }

            TapHandler {
                onTapped: delegate.ListView.view.currentIndex = index;
            }

            HoverHandler {
                cursorShape: Qt.PointingHandCursor
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
            delegate: projectItemDelegate
        }
    }
    Component {
        id: ticketItemDelegate
        Rectangle {
            id: delegate
            required property var ticket

            width: ListView.view.itemWidth
            height: contents.height
            radius: 4

            Column {
                id: contents
                topPadding: 8
                bottomPadding: 4
                leftPadding: 8
                spacing: 4
                Text {
                    text: delegate.ticket.name
                    font {
                        bold: true
                        pointSize: 16
                    }
                }
                Text {
                    text: delegate.ticket.description ? delegate.ticket.description : "No description"
                    width: delegate.width - parent.leftPadding
                    elide: Text.ElideRight
                    font {
                        italic: !delegate.ticket.description
                        pointSize: 12
                    }
                }
                Text {
                    text: delegate.ticket.priority
                }
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
            delegate: ticketItemDelegate
        }
    }
}
