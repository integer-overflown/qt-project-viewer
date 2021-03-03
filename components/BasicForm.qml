import QtQuick

Item {
    id: root
    required property string title
    property var header : header

    property var validator: DoubleValidator {}

    // background
    Rectangle {
        anchors.fill: parent
        color: "lightgray"
        z: root.validator.bottom
    }

    Rectangle {
        id: header
        width: parent.width
        height: 40
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
                text: root.title
                font.pointSize: 14
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: TextInput.AlignHCenter
            }
        }
    }

    // shadow under header
    Rectangle {
        anchors.top: header.bottom
        width: header.width
        height: 6
        gradient: Gradient {
            GradientStop { position: 0; color: "gray" }
            GradientStop { position: 1; color: "lightgray" }
        }
    }
}
