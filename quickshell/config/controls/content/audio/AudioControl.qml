import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import Quickshell

import "../util"
import "../../../Colors/"
import "../../../Sizes/"

// Could use set-mute at some point
// setup a listener for the function row
// after mute changing of vlaeus is nojt consistent

PopupButton {
    id: root
    property url image : "icons/volume.png"
    property var volume : volumeText.text
    

    icon.source: "content/audio/" + image
    label: volume

    required property var rootWindow  
    anchorWindow: rootWindow

    function getIcon() {
                let prefix = muteButton.isMuted ? "icons/volume-off.png" :
                             volumeSlider.value == 0   ? "icons/volume-x.png" :
                             volumeSlider.value < 0.25 ? "icons/volume.png" :
                             volumeSlider.value < 0.60 ? "icons/volume-1.png" :
                                                         "icons/volume-2.png"
                return prefix 
    }

    RowLayout {

        anchors.centerIn: parent
        spacing: 10

        ColumnLayout {
            spacing: 3
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
                        getVolume.running = true
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
                                if (muteButton.isMuted) muteButton.isMuted = false
                                volumeSlider.updatingFromSystem = true
                                volumeSlider.value = parseFloat(match[1])
                                volumeSlider.updatingFromSystem = false
                                root.image = root.getIcon()
                            }
                        }
                    }
                }
            }
            
            // mute button
            Text {
                id: volumeText
                text: "%" + volumeSlider.value.toFixed(2)
                color: "white"
            }

            Button {
                id: muteButton
                property real preMuteVal: 0.5
                property bool isMuted: false


                icon.source: root.image
                icon.height: Sizes.squareIcon
                icon.width:  Sizes.squareIcon

                background: Rectangle {
                    color: "transparent"
                }

                onClicked: {
                    if (isMuted) {
                        setVolume.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", preMuteVal]
                        volumeText.text = volumeSlider.value.toFixed(2)
                        volumeSlider.value = preMuteVal
                        isMuted = false
                        root.image = root.getIcon()
                    } else {
                        preMuteVal = volumeSlider.value
                        setVolume.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", 0]
                        volumeText.text = "X"
                        isMuted = true
                        root.image = root.getIcon()
                    }
                }
            }

        }

        VDivider {}       

        Item { Layout.fillWidth: true }

        ColumnLayout {

            spacing: 10

            Item { Layout.fillHeight: true }

                Rectangle {
                    visible: appButton.isSelected
                    width: 100
                    height:50
                }

                Rectangle {
                    visible: deviceButton.isSelected
                    width: 100
                    height:50
                }

                HDivider {
                    passedWidth: 110
                }
            
            RowLayout {

                spacing: 5


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
                    image: "./icons/drivers.png"
                    isSelected: false
                    onClicked: {
                        deviceButton.isSelected = true
                        appButton.isSelected = false
                    }
                }


            }   

        }

    }

}
