import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml 2.3

import "components" as CustomComponents

Window {
    id: root
    width: 640
    height: 480
    x: (Screen.desktopAvailableWidth - root.width) / 2
    y: (Screen.desktopAvailableHeight - root.height) / 2
    visible: true
    title: qsTr("ProjectViewer")

    Rectangle {
        id: background
        anchors.fill: parent
        color: "steelblue"
    }

    ColumnLayout {
        readonly property real itemWidth: root.width / 4
        readonly property real itemHeight: 36

        id: credentials
        anchors.centerIn: parent
        spacing: 16

        Image {
            id: letter
            source: "qrc:/images/q_letter.png"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 180
            Layout.preferredHeight: 90
            Layout.bottomMargin: 8
        }

        CustomComponents.CredentialsField {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: credentials.itemWidth
            Layout.preferredHeight: credentials.itemHeight
            placeholderText: "Login"
        }

        CustomComponents.CredentialsField {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: credentials.itemWidth
            Layout.preferredHeight: credentials.itemHeight
            placeholderText: "Password"
            echoMode: TextInput.Password
        }

        Button {
            id: submit
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: credentials.itemWidth
            Layout.preferredHeight: credentials.itemHeight
            contentItem: Text {
                text: "Login"
                font.bold: true
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                color: submit.down ? "#00376f" : "#2a609e" //TODO: maybe add light variant for 'hovered' state
                radius: 2
            }
            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }
        }

        Text {
            id: restorePassword
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 10
            text: "Forgot your password?"
            opacity: hoverHandler.hovered ? 1 : 0.6
            color: "white"
            HoverHandler {
                id: hoverHandler
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
}
