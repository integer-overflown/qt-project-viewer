import QtQuick

import "qrc:/components" as CustomComponents

CustomComponents.BasicForm {
    required property var ticket

    title: "Edit ticket"

    Image {
        source: "qrc:/images/arrow_back.svg"
        width: 24
        height: 24
        anchors {
            verticalCenter: header.verticalCenter
            left: parent.left
            leftMargin: 12
        }
        HoverHandler {
            cursorShape: Qt.PointingHandCursor
        }
        TapHandler {
            onTapped: forms.pop()
        }
    }

    Text {
        anchors.centerIn: parent
        text: "Hello, " + ticket.name
    }
}
