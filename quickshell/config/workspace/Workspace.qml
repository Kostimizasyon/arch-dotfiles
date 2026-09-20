import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Hyprland

import "../Colors/"
import "../Sizes/"

Rectangle {

	width: row.implicitWidth
	height: 30
	color: Colors.backgroundColor
	radius: Sizes.circularRadius

	RowLayout {

		id: row
	
		anchors.fill: parent

		Repeater {
			id: wsRepeater
			model: Sizes.wsWindowSize

			property int focusedId: Hyprland.focusedWorkspace?.id ?? 1

			property int activeIndex : {
			    let half = Math.floor(Sizes.wsWindowSize / 2)
			    let start = focusedId - half
			    // clamp so window doesn't go out of bounds
			    let maxStart = Sizes.totalWorkspaces - Sizes.wsWindowSize + 1
			    return Math.max(1, Math.min(start, maxStart))
			}

			Text {
				rightPadding: 6
				leftPadding: 6

				property var hasItem: Hyprland.workspaces.values.find(w => w.id ===  wsRepeater.activeIndex + index)
				property bool isActive : Hyprland.focusedWorkspace?.id === ( wsRepeater.activeIndex+ index)

				text: wsRepeater.activeIndex + index

				color: isActive ? Colors.activeColor : (hasItem ?  Colors.fullColor : Colors.emptyColor)

				font {pixelSize: 24 ; bold: isActive}

				MouseArea {
					anchors.fill: parent

					onClicked:Hyprland.dispatch("workspace " + (index + 1))

				}
			}
		}
}

}
