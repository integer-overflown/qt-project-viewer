import QtQuick

import com.overflown.qmlcomponents
import "qrc:/scripts/util.js" as Utils

Rectangle {
    id: delegate
    required property var ticket

    width: ListView.view.itemWidth
    height: contents.height
    radius: 4
    color: hoverHandler.hovered ? '#e1f5fe' : 'white'

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

    HoverHandler {
        id: hoverHandler
        cursorShape: Qt.PointingHandCursor
    }

    TapHandler {
        onTapped: {
            const o = Utils.instantiateObject("qrc:/forms/EditTicketForm.qml", window, { ticket: delegate.ticket });
            forms.push(o);
        }
    }
}
