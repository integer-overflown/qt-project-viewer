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
        ListElement { name: "Minor"; color: '#b1cddb' }
        ListElement { name: "Revision"; color: '#819ca9' }
        ListElement { name: "Normal"; color: '#546e7a' }
        ListElement { name: "Important"; color: '#ffca28' }
        ListElement { name: "Hotfix"; color: '#fb8c00' }
    }

    Component {
        id: priorityItem
        Rectangle {
            id: delegate
            readonly property int horizontalPadding: 12
            readonly property int verticalPadding: 8

            anchors.verticalCenter: parent.verticalCenter
            implicitWidth: priority.width + 2 * horizontalPadding
            implicitHeight: priority.height + 2 * verticalPadding
            radius: width / 4
            border {
                width: 1
                color: model.color
            }
            color: ListView.isCurrentItem ? model.color : 'white'

            Text {
                id: priority
                anchors.centerIn: parent
                text: model.name
                color: delegate.ListView.isCurrentItem ? 'white' : 'black'
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
