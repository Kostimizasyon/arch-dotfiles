import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "../util/"
import "../../../Colors/"
import "../../../Sizes/"

PopupButton {
    id: brightnessButton
    icon.source: "./icons/brightness-high.png"

    required property var rootWindow  
    anchorWindow: rootWindow

    ColumnLayout {
        spacing: 3
        anchors.centerIn: parent
        Slider {
            // lockguard
            property bool updatingFromSystem: false
            id: brightnessSlider
            orientation: Qt.Vertical
            from: 0
            to: 1
            value: 0.67
            onValueChanged : {
                if (!updatingFromSystem) {
                    setBrightness.command = ["brigthnessctl", "set", value.toFixed(2).toString() * 100 + "%"]
                    setBrightness.running = true
                }
            }

            // setting brightness
            Process {
                id: setBrightness
                running: false
            }

            // getting active brightness %
            Process {
                id: getBrightness
                command: ["brightnessctl"]
                running: true
                stdout: SplitParser {
                    onRead: (line) => {
                        let match = line.match(/Current brightness:\s*([\d.]+)/)
                        if (match) {
                            brightnessSlider.updatingFromSystem = true
                            brightnessSlider.value = parseFloat(match[1])
                            brightnessSlider.updatingFromSystem = false
                        }
                    }
                }
            }
        }

        Text {
            id: brightnessText
            text: brightnessSlider.value.toFixed(2)
            color: "white"
        }

    }

}
