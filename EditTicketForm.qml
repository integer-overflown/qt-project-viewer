import QtQuick
import QtQuick.Controls

import "qrc:/components" as CustomComponents

CustomComponents.BasicForm {
    id: root
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

    ListModel {
        id: priorityNames
        ListElement { name: "Minor" }
        ListElement { name: "Revision" }
        ListElement { name: "Normal" }
        ListElement { name: "Important" }
        ListElement { name: "Hotfix" }
    }

    Component {
        id: priorityItem
        Rectangle {
            readonly property int horizontalPadding: 12
            readonly property int verticalPadding: 8

            anchors.verticalCenter: parent.verticalCenter
            implicitWidth: priority.width + 2 * horizontalPadding
            implicitHeight: priority.height + 2 * verticalPadding
            radius: width / 4

            Text {
                id: priority
                anchors.centerIn: parent
                text: modelData
            }
        }
    }

    ScrollView {
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        anchors {
            top: root.header.bottom
            left: root.left
            right: root.right
        }
        topPadding: 8
        leftPadding: 16
        rightPadding: 16
        ListView {
            id: priorities
            contentHeight: contentItem.childrenRect.height
            orientation: Qt.Horizontal
            spacing: 8
            model: priorityNames
            delegate: priorityItem
        }
    }

    Text {
        anchors.centerIn: parent
        text: "Hello, " + ticket.name
    }
}
