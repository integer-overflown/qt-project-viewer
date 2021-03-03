import QtQuick 2.9
import QtQuick.Controls 2.5

TextField {
    required property var stateSource
    readonly property int fieldLeftPadding: 12

    font.italic: true
    leftPadding: fieldLeftPadding
    background: Rectangle {
        color: "#8eaed7"
        radius: 2
        border {
            width: stateSource.state === "rejected" ? 1 : 0
            color: 'red'
        }
    }
    onActiveFocusChanged: {
        if (activeFocus && stateSource.state === "rejected") {
            stateSource.state = "normal";
            clear();
        }
    }
}
