import QtQuick
import Quickshell
import Quickshell.Io
import "../util"
import "../../../Colors/"
import "../../../Sizes/"

PopupButton {
    id: root

    icon.source: image
    label : networkName

    property string image : "content/internet/icons/no-internet.png"
    property string networkName : "No Connection"

    required property var rootWindow  
    anchorWindow: rootWindow

    property bool isEthernet: false
    property bool isConnected: false

    function getIcon() {
	           let prefix = isEthernet ? "ethernet" :
	                   isConnected ? "wifi" : "no-internet"
		   return "content/internet/icons/" + prefix + ".png"
    }


    Timer {
	interval: 10000
	running: true
	repeat: true
	triggeredOnStart: true
	onTriggered: getNetStatus.running = true
    }

Process {
    id: getNetStatus
    property bool toBreak: false
    running: false
    command: ["nmcli", "-f", "TYPE,NAME", "connection", "show", "--active"]

    stdout: SplitParser {
        onRead: (line) => {
            let type = line.trim().toLowerCase()
            if (type.split(" ")[0] == "type") {
                getNetStatus.toBreak = true
                return
            }
            if (getNetStatus.toBreak) {
                let parts = line.trim().split(/\s{2,}/)
                let connType = parts[0]?.toLowerCase()
                let connName = parts[1]

                switch (connType) {
                    case "ethernet":
                        root.isEthernet = true
                        root.isConnected = true
                        break
                    case "wifi":
                        root.isEthernet = false
                        root.isConnected = true
                        break
                    default:
                        root.isEthernet = false
                        root.isConnected = false
                        break
                }
                root.networkName = connName || "NULL"
                root.image = root.getIcon()

                getNetStatus.toBreak = false
                getNetStatus.running = false
            }
        }
    }
}
	Process {
          id: getNetName
  	  running: false
  	  command: ["sh", "-c", "nmcli -t -f NAME connection show --active | head -1"]

	  stdout: SplitParser {
       		 onRead: (line) => {
         	   root.networkName = line.trim()
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
