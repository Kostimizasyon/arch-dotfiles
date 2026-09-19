import QtQuick
import QtQuick.Layouts

import "./content/audio/"
import "./content/internet/"
import "./content/brightness/"
import "./content/power/"
import "./content/battery/"
import "../Colors/"
RowLayout {
    id: root
    required property var rootWindow
    spacing: 10

    Rectangle {
        id: background
        required property var rootWindow

        Layout.fillHeight: true
        implicitWidth: row.implicitWidth + 20
        implicitHeight: row.implicitHeight + 10
        color: Colors.backgroundColor
        radius: 8

        RowLayout {
            id: row
            anchors.centerIn: parent
            spacing: 10

            InternetControl { rootWindow:  root.rootWindow}
            AudioControl { rootWindow:  root.rootWindow}
            BrightnessControl { rootWindow: root.rootWindow }
            BatteryControl {}
        }
    }

    Rectangle {
        id: powerBackground

        Layout.fillHeight: true
        implicitWidth: powerRow.implicitWidth + 20
        implicitHeight: powerRow.implicitHeight + 10
        color: Colors.backgroundColor
        radius: 8

        RowLayout {
            id: powerRow
            anchors.centerIn: parent

            PowerControl {
                rootWindow: root.rootWindow
            }
        }
    }
}
