import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io

import "../../../Sizes/"

MouseArea {

	id: root

	required property string text
	required property string image
	property var command : []

	RowLayout {
	    anchors.fill: root.parent
	    spacing: 5

	    Image {
		height: Sizes.squareIcon
		width: Sizes.squareIcon
		source: root.image
		Layout.alignment: Qt.AlignVCenter
	    }
	    Text {
		text: root.text
		color: "grey"
		font.pixelSize: 14
		Layout.alignment: Qt.AlignVCenter
	    }
	}

	Process {
		id: process
		running: false
		command: root.command
	}

	onClicked: {
		process.running = true
	}
}
