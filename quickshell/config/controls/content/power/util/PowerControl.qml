import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io

import "../../../../Sizes/"

Button {
    id: root

    required property string label
    required property string image
    property var command: []

    background: Rectangle {
        color: "transparent"
    }

    RowLayout {
        spacing: 5

        Image {
            Layout.preferredHeight: Sizes.squareIcon
            Layout.preferredWidth: Sizes.squareIcon
            source: root.image
            Layout.alignment: Qt.AlignVCenter
        }
        Text {
            text: root.label
            color: "white"
            font.pixelSize: 14
            Layout.alignment: Qt.AlignVCenter
        }
    }

    Process {
        id: process
        running: false
        command: root.command
    }

    onClicked: {
        process.running = true
    }
}
