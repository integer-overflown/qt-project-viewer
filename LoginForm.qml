import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "qrc:/components" as CustomComponents
import com.overflown.qmlcomponents

Item {
    id: root
    property bool isBeingVerified: false
    signal submit(string token)

    function verifyLoginAttempt() {
        if (!isBeingVerified) {
            isBeingVerified = true;
            Authenticator.verify(login.text, password.text);
        }
    }

    states: [
        State {
            name: "normal"
        },
        State {
            name: "rejected"
            PropertyChanges {
                target: loginError
                x: loginError.posX + login.width
            }
            PropertyChanges {
                target: passwordError
                x: passwordError.posX + password.width
            }
            PropertyChanges {
                target: login
                onTextEdited: root.state = "normal"
            }
            PropertyChanges {
                target: password
                onTextEdited: root.state = "normal"
            }
        },
        State {
            name: "unknownError"
        }
    ]

    state: "normal"
    onStateChanged: isBeingVerified = false

    transitions: Transition {
        PropertyAnimation {
            property: "x"
            duration: 250
        }
    }

    Dialog {
        id: unknownErrorDialog
        property string reason: ""

        anchors.centerIn: parent
        title: "Network error"
        standardButtons: Dialog.Ok
        visible: root.state === "unknownError"
        onClosed: root.state = "normal"
        modal: true

        Text {
            anchors.centerIn: parent
            text:
                "Something went wrong while connecting to a server.<br>"
                + "Please, check our connection and try again.<br>"
                + "<b>Reason</b>: " + unknownErrorDialog.reason
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "steelblue"
    }

    CustomComponents.ErrorMessage {
        id: loginError
        posX: credentials.x + login.x + login.fieldLeftPadding
        posY: credentials.y + login.y + (login.height - height) / 2
    }

    CustomComponents.ErrorMessage {
        id: passwordError
        posX: credentials.x + password.x + password.fieldLeftPadding
        posY: credentials.y + password.y + (password.height - height) / 2
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
            Layout.preferredWidth: 128
            Layout.preferredHeight: 128
        }

        CustomComponents.CredentialsField {
            id: login
            verifier: root
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: credentials.itemWidth
            Layout.preferredHeight: credentials.itemHeight
            placeholderText: "Login"
            Component.onCompleted: forceActiveFocus()
        }

        CustomComponents.CredentialsField {
            id: password
            verifier: root
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: credentials.itemWidth
            Layout.preferredHeight: credentials.itemHeight
            placeholderText: "Password"
            echoMode: TextInput.Password
        }

        CustomComponents.RoundButton {
            id: submit
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: credentials.itemWidth
            Layout.preferredHeight: credentials.itemHeight
            text: "Login"
            onClicked: root.verifyLoginAttempt();
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
    // handle authentication attemps
    Connections {
        target: Authenticator
        function onSubmitted(token) {
            root.submit(token);
        }
        function onRejected() {
            root.state = "rejected";
        }
        function onError(error) {
            unknownErrorDialog.reason = error;
            root.state = "unknownError";
        }
    }
}
