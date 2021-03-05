import QtQuick

Item {
    id: root
    required property string title
    property var header : header
    property var validator: DoubleValidator {}
    signal backClicked

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
                width: 32
                height: 32
            }
            Text {
                text: root.title
                font.pointSize: 14
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: TextInput.AlignHCenter
            }
        }
    }

    Image {
        id: abc
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
            onTapped: backClicked()
        }
        // forms is id of main app window's stack view
        // defined in main.qml
        // StackView.view attached prop is not initialized during creation of this component
        visible: !forms.busy && forms.depth > 1
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
