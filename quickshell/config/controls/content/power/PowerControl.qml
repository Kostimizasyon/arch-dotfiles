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
    anchorWindow: rootWindow

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        PowerControl {
            image: "../icons/power.png"
            label: "Shutdown"
            command: ["shutdown 0"]
            Layout.fillWidth: true
        }

        PowerControl {
            image: "../icons/reboot.png"
            label: "Reboot"
            command: ["reboot"]
            Layout.fillWidth: true
        }

        PowerControl {
            image: "../icons/log-out.png"
            label: "Log Out"
            command: ["hyprctl dispatch exit"]
            Layout.fillWidth: true
        }

    }
}
