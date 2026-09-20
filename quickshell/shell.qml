import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "./config/controls/"
import "./config/workspace/"
import "./config/clock/"
import "./config/Colors/"

PanelWindow {
    id: root

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 40

    color: "transparent"

    RowLayout {

        anchors.fill: parent
        anchors.leftMargin: 25
        anchors.rightMargin: 25
        anchors.topMargin: 10
        spacing: 10

        // left group
        Workspace {}

        // spacer pushes clock to center-ish
        Item { Layout.fillWidth: true }

       // right group
        ControlRow {
            rootWindow: root
        }
    }

        Clock {
            anchors.topMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
}
