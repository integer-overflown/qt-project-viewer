import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

import "qrc:/components" as CustomComponents
import com.overflown.qmlcomponents

Item {
    id: root
    signal submit(string token)

    Rectangle {
        id: background
        anchors.fill: parent
        color: "steelblue"
    }

    ColumnLayout {
        id: credentials
        readonly property real itemWidth: window.width / 4
        readonly property real itemHeight: 36

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
            id: login
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: credentials.itemWidth
            Layout.preferredHeight: credentials.itemHeight
            placeholderText: "Login"
        }

        CustomComponents.CredentialsField {
            id: password
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
            onClicked: {
                Authenticator.verify(login.text, password.text);
            }
            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }
            // handle authentication attemps
            Connections {
                target: Authenticator
                function onSubmitted(token) {
                    root.submit(token);
                }
                function onRejected() {
                    console.log("Reject!"); // TODO: display a message
                }
                function onError(error) {
                    console.log("Error: ", error);
                }
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
