import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQml

import "qrc:/forms"
import "scripts/util.js" as Utils

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("ProjectViewer")
    Component.onCompleted: {
        setX((Screen.desktopAvailableWidth - width) / 2);
        setY((Screen.desktopAvailableHeight - height) / 2);
    }

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
        onSubmit: {
            const o = Utils.instantiateObject("qrc:/forms/ProjectViewForm.qml", window, { token: token });
            forms.replace(o);
        }
    }
}
