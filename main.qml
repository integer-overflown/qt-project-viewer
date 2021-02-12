import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml 2.3

Window {
    id: window
    width: 640
    height: 480
    x: (Screen.desktopAvailableWidth - window.width) / 2
    y: (Screen.desktopAvailableHeight - window.height) / 2
    visible: true
    title: qsTr("ProjectViewer")

    StackView {
        id: forms
        initialItem: root
        anchors.fill: parent

        replaceEnter: Transition {
            PropertyAnimation {
                property: "x"
                from: window.width
                to: 0
                duration: 500
            }
        }

        replaceExit: Transition {
            PropertyAnimation {
                property: "x"
                from: 0
                to: -window.width
                duration: 500
            }
        }
    }

    LoginForm {
        id: root
    }

    Component {
        id: projectView
        Item {
            Rectangle {
                anchors.fill: parent
                color: "green"
            }
            Text {
                anchors.centerIn: parent
                text: "Hello, second window!"
                font.pointSize: 24
            }
        }
    }
}
