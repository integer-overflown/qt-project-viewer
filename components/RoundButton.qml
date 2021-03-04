import QtQuick
import QtQuick.Controls

Button {
    id: root
    contentItem: Text {
        text: root.text
        font.bold: true
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        color: root.down ? "#00376f" : "#2a609e"
        radius: 2
    }
    HoverHandler {
        cursorShape: Qt.PointingHandCursor
    }
}
