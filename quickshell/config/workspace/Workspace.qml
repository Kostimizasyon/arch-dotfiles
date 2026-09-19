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

			model: Sizes.workspaceCount

			Text {
				rightPadding: 6
				leftPadding: 6

				property var hasItem: Hyprland.workspaces.values.find(w => w.id === index + 1)
				property bool isActive : Hyprland.focusedWorkspace?.id === (index + 1)

				text: index + 1
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
