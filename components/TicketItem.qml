import QtQuick

import com.overflown.qmlcomponents

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
            rightPadding: 8
            spacing: 8
            Text {
                text: delegate.ticket.name
                font {
                    bold: true
                    pointSize: 16
                }
            }
            Text {
                text: delegate.ticket.description ? delegate.ticket.description : "No description"
                width: delegate.width - parent.leftPadding - parent.rightPadding
                wrapMode: Text.Wrap
                font {
                    italic: !delegate.ticket.description
                    pointSize: 12
                }
            }
            PriorityWidget {
                priority: ticket.priority
                width: 64
                height: 32
            }
        }
    }
}
