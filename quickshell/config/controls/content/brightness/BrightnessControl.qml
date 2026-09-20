import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "../util/"
import "../../../Colors/"
import "../../../Sizes/"

PopupButton {
    id: root

    property var image : "content/brightness/icons/brightness-med.png"

    label: brightnessSlider.value.toFixed(2)
    icon.source: image

    required property var rootWindow  
    anchorWindow: rootWindow

    function getIcon() {
        let prefix =    brightnessSlider.value.toFixed(2) < 0.33 ? "low" :
                        brightnessSlider.value.toFixed(2) < 0.66 ? "med" :
                        "high"

        return "content/brightness/icons/brightness-" + prefix + ".png"
    }

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
                    setBrightness.command = ["brightnessctl", "set", value.toFixed(2).toString() * 100 + "%"]
                    setBrightness.running = true
                    root.image = root.getIcon()
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
                            root.image = root.getIcon()
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
