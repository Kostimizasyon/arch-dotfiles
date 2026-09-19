import QtQuick
import QtQuick.Layouts
import Quickshell

import "../../../Colors/"
import "../../../Sizes/"
import "../util/"
import "./util/"

PopupButton {

    id: powerButton
    icon.source: "./icons/power.png"

    required property var rootWindow
    rootWindow: rootWindow

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        PowerControl {
            id: shutdown
            image: "./icons/power.png"
            text: "Shutdown"
            command: ["sh", "-c", "shutdown"]
            Layout.fillWidth: true
        }

        PowerControl {
            image: "./icons/reboot.png"
            text: "Reboot"
            command: ["sh", "-c", "reboot"]
            Layout.fillWidth: true
        }

        PowerControl {
            image: "./icons/logout.png"
            text: "Log Out"
            command: ["sh", "-c", "hyprctl dispatch exit"]
            Layout.fillWidth: true
        }

    }
}
