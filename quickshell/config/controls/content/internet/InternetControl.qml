import QtQuick
import Quickshell
import Quickshell.Io
import "../util"
import "../../../Colors/"
import "../../../Sizes/"

PopupButton {
    id: internetButton
    icon.source: "./icons/no-internet.png"

    required property var rootWindow  
    anchorWindow: rootWindow

    property bool isEthernet: false
    property bool isConnected: false

    Timer {
	interval: 10000
	running: true
	repeat: true
	triggeredOnStart: true
	onTriggered: getNetStatus.running = true
    }

    Process {
	    id: getNetStatus
	    running: false

	    command: ["nmcli", "-f", "TYPE", "connection", "show", "--active"]
	    stdout: SplitParser {
		    onRead: (line) => {
			let type = line.trim().toLowerCase()
			switch (type) {
				case "ethernet":
					internetButton.isEthernet = true
					internetButton.isConnected = true
					break
				case "wifi":
					internetButton.isEthernet = false
					internetButton.isConnected = true
					break
				default:
					internetButton.isEthernet = false
					internetButton.isConnected = false
					break

			}
		    }

	    }
    }


	Column {

		Rectangle {
			id: ip
			property bool isVisible : false
			property string ipAdress : "***/===/+/||"
			property string hiddenIp: "***/===/+/||"

			Text {
				text: ip.isVisible ? ip. ipAdress: ip.hiddenIp
				MouseArea {

					hoverEnabled: true
					anchors.fill: parent

					onClicked: {
						fetchIp.running = true
						ip.sVisible = !ip.isVisible
					}

				}
			}

			Process {
			    id: fetchIp
			    command: ["ip", "route", "show"]
			    running: false
			    stdout: SplitParser {
				    onRead: (line) => {
					    let match = line.match(/src (\d+\.\d+\.\d+\.\d+)/)
					    if (match) {
						ip.ipAdress = match
					    }
			 	    }
				}
			}

		}

    }
    
}
