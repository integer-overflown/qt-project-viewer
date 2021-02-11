import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml 2.3

Window {
    id: root
    width: 640
    height: 480
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

        TextField {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: credentials.itemWidth
            Layout.preferredHeight: credentials.itemHeight
            placeholderText: "Login"
        }

        TextField {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: credentials.itemWidth
            Layout.preferredHeight: credentials.itemHeight
            placeholderText: "Password"
            echoMode: TextInput.Password
        }

        Button {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: credentials.itemWidth
            Layout.preferredHeight: credentials.itemHeight
            text: "Login"
        }
    }
}
