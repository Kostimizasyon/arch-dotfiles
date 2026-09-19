import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import Quickshell

import "../util"
import "../../../Colors/"
import "../../../Sizes/"

// Could use set-mute at some point

PopupButton {
    id: audioButton
    icon.source: "./icons/volume.png"

    required property var rootWindow  
    anchorWindow: rootWindow

    RowLayout {

        anchors.centerIn: parent
        spacing: 10

        ColumnLayout {
            spacing: 3
            anchors.centerIn: parent
            // vertical volume slider
            Slider {
                // lockguard
                property bool updatingFromSystem: false

                id: volumeSlider
                orientation: Qt.Vertical
                from: 0
                to: 1
                value: 0.67

                onValueChanged : {
                    if (!updatingFromSystem) {
                        setVolume.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", value.toFixed(2)]
                        setVolume.running = true
                    }
                }

                // setting sound
                Process {
                    id: setVolume
                    running: false
                }

                // getting active sound %
                Process {
                    id: getVolume
                    command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
                    running: true
                    stdout: SplitParser {
                        onRead: (line) => {
                            let match = line.match(/Volume:\s*([\d.]+)/)
                            if (match) {
                                volumeSlider.updatingFromSystem = true
                                volumeSlider.value = parseFloat(match[1])
                                volumeSlider.updatingFromSystem = false
                            }
                        }
                    }
                }
            }
            
            // mute button
            Text {
                id: volumeText
                text: volumeSlider.value.toFixed(2)
                color: "white"
            }

            Button {
                id: muteButton
                property real preMuteVal: 0.5
                property bool muted: false


                icon.source: muted ? "./icons/volume-x.png" :
                             volumeSlider.value == 0   ? "./icons/volume-off.png" :
                             volumeSlider.value < 0.33 ? "./icons/volume.png" :
                             volumeSlider.value < 0.66 ? "./icons/volume-1.png" :
                                                         "./icons/volume-2.png"
                icon.height: Sizes.squareIcon
                icon.width: Sizes.squareIcon

                background: Rectangle {
                    color: "transparent"
                }

                onClicked: {
                    if (muted) {
                        setVolume.commands = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", preMuteVal]
                        volumeText.text = preMuteVal
                        muted = false
                    } else {
                        preMuteVal = volumeSlider.value
                        setVolume.commands = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", 0]
                        setVolume.running = true
                        volumeText.text = "X"
                        muted = true
                    }
                }
            }

        }

        VDivider {}       

        Item { Layout.fillWidth: true }

        ColumnLayout {

            spacing: 10

            HDivider {}

            Item { Layout.fillHeight: true }
            
            RowLayout {

                spacing: 5

                Rectangle {
                    visible: appButton.isSelected
                    width: 100
                    height:50
                }

                HighlightButton{
                    id: appButton
                    image: "./icons/apps.png"
                    isSelected : true
                    onClicked: {
                        appButton.isSelected = true
                        deviceButton.isSelected = false
                    }
                }

                HighlightButton{
                    id: deviceButton
                    image: "./icons/devices.png"

                    onClicked: {
                        deviceButton.isSelected = true
                        appButton.isSelected = false
                    }
                }


            }   

        }

    }

}
