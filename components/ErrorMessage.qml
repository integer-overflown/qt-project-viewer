import QtQuick

Text {
    required property int posX
    required property int posY

    x: posX
    y: posY
    text: "Invalid value!";
    font.italic: true
    color: 'red'
}
