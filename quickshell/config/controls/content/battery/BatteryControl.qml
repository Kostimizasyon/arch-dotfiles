import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

import "../../../Colors/"
import "../../../Sizes/"

Button {
    id: batteryControl

    property bool isCharging: false
    property string batteryPercent: "0"
    property color backgroundColor: "green"

    icon.height: Sizes.squareIcon
    icon.width: Sizes.squareIcon
    icon.source: getIcon()

    text: "%" + batteryPercent
    display: AbstractButton.TextBesideIcon

    background: Rectangle {
        color: backgroundColor
        height: 40
        radius: 12
    }

    function getIcon() {
        let pct = parseInt(batteryPercent)
        let prefix = isCharging ? "charge" : "battery"

        let level = pct >= 95 ? "full" :
                    pct >= 80 ? "90" :
                    pct >= 60 ? "70" :
                    pct >= 40 ? "50" :
                    pct >= 20 ? "30" :
                    pct >= 5  ? "10" :
                                "0"

        return "./icons/" + prefix + "-" + level + ".png"
    }

    onClicked: {
        getBatteryPercentage.running = true
        getChargingStatus.running = true
    }

    Process {
        id: acpiWatcher
        command: ["udevadm", "monitor", "--udev", "--subsystem-match=power_supply"]
        running: true

        stdout: SplitParser {
            onRead: (line) => {
                getBatteryPercentage.running = true
                getChargingStatus.running = true
            }
        }
    }

    Process {
        id: getChargingStatus
        running: true
        command: ["cat", "/sys/class/power_supply/BAT1/status"]

        stdout: SplitParser {
            onRead: (line) => {
                batteryControl.isCharging = line.trim() === "Full" || line.trim() == "Charging"
            }
        }
    }

    Process {
        id: getBatteryPercentage
        running: false
        command: ["cat", "/sys/class/power_supply/BAT1/capacity"]

        stdout: SplitParser {
            onRead: (line) => {
                batteryControl.batteryPercent = line.trim()
            }
        }
    }

    Timer {
        interval: 1000 * 30
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: getBatteryPercentage.running = true
    }
}
