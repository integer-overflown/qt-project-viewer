import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/components" as CustomComponents
import com.overflown.qmlcomponents as Widgets

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
                onTapped: {
                    root.ticket.priority = index + 1
                    delegate.ListView.view.currentIndex = index
                }
            }

            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }
        }
    }

    ScrollView {
        id: priorities
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
            id: priorityList
            contentHeight: contentItem.childrenRect.height
            orientation: Qt.Horizontal
            spacing: 8
            model: priorityNames
            delegate: priorityItem
            currentIndex: root.ticket.priority - 1  // doesn't create a binding since ticket is not a QObject
        }
    }

    ColumnLayout {
        anchors {
            top: priorities.bottom
            topMargin: 16
            right: parent.right
            rightMargin: 16
            left: parent.left
            leftMargin: 16
        }
        spacing: 16
        RowLayout {
            Widgets.PriorityWidget {
                Layout.preferredWidth: 80
                Layout.preferredHeight: 20
                Layout.alignment: Qt.AlignVCenter
                priority: priorityList.currentIndex + 1
                colorInactive: 'white'
            }
            TextInput {
                id: title
                Layout.alignment: Qt.AlignVCenter
                font {
                    bold: true
                    pointSize: 16
                }
                text: root.ticket.name
                selectByMouse: true

                HoverHandler {
                    // caret to indicate ability of receiving text input
                    cursorShape: Qt.IBeamCursor
                }

                onActiveFocusChanged: {
                    if (!activeFocus && !text.length) text = root.ticket.name
                }
            }
        }

        Flickable {
            id: flickable
            Layout.preferredHeight: contentHeight
            contentWidth: width
            contentHeight: textArea.implicitHeight
            clip: true
            Layout.fillWidth: true
            // limits to five lines at most
            Layout.maximumHeight: (contentHeight / textArea.lineCount) * 5 + textArea.topPadding + textArea.bottomPadding

            TextArea.flickable: TextArea {
                id: textArea
                background: Rectangle {
                    radius: 4
                }
                text: root.ticket.description
                cursorPosition: root.ticket.description.length
                topPadding: 12
                bottomPadding: 12
                placeholderText: "<i>Description</i>"
                wrapMode: Text.Wrap
                KeyNavigation.priority: KeyNavigation.BeforeItem
                KeyNavigation.tab: title
            }
            ScrollBar.vertical: ScrollBar {}
            boundsMovement: Flickable.StopAtBounds
            boundsBehavior: Flickable.DragAndOvershootBounds
        }

        Row {
            spacing: 8
            Layout.alignment: Qt.AlignRight
            CustomComponents.RoundButton {
                text: "Cancel"
                height: 32
            }
            CustomComponents.RoundButton {
                text: "Confirm"
                height: 32
            }
        }
    }
}
