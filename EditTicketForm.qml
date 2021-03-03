import QtQuick

Item {
    required property var ticket

    Text {
        anchors.centerIn: parent
        text: "Hello, " + ticket.name
    }
}
