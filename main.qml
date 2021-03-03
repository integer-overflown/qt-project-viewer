import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQml

import "qrc:/forms"

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
            const componentFactory = Qt.createComponent("qrc:/forms/ProjectViewForm.qml");
            switch(componentFactory.status) {
            case Component.Ready:
                const object = componentFactory.createObject(window, { token: token });
                forms.replace(object);
                return;
            case Component.Error:
                console.log(componentFactory.errorString());
            }
        }
    }
}
