import QtQuick

import com.overflown.qmlcomponents

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
