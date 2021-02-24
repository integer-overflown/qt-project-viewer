import QtQuick
import QtQuick.Controls

import com.overflown.qmlcomponents

Item {
    id: root
    required property string token

    Rectangle {
        id: header
        width: parent.width
        height: 40
        color: "lightgray"
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
    Component {
        id: projectItemDelegate
        Rectangle {
            id: delegate
            required property var project // model property object
            required property int index

            width: ListView.view.itemWidth()
            height: ListView.view.itemHeight()
            color: ListView.isCurrentItem ? 'midnightblue' : 'transparent'

            RoundImage {
                anchors.centerIn: parent
                width: delegate.ListView.view.iconSize
                height: width
                source: project.icon
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
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        anchors.top: header.bottom
        width: items.itemWidth()
        height: parent.height - header.height
        clip: true
        ListView {
            id: items
            readonly property int iconSize: 32
            readonly property int horizontalPadding: 16
            readonly property int verticalPadding: 12
            function itemWidth () { return iconSize + 2 * horizontalPadding; }
            function itemHeight() { return iconSize + 2 * verticalPadding;   }
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
}
