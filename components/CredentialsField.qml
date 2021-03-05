import QtQuick
import QtQuick.Controls

TextField {
    required property var verifier
    readonly property int fieldLeftPadding: 12

    font.italic: true
    leftPadding: fieldLeftPadding
    background: Rectangle {
        color: "#8eaed7"
        radius: 2
        border {
            width: verifier.state === "rejected" ? 1 : 0
            color: 'red'
        }
    }
    selectByMouse: true
    Keys.onPressed: {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
            verifier.verifyLoginAttempt();
    }
}
