import QtQuick
import QtQuick.Controls

import "../../../Colors/"

Button {

    id: button
    property bool isSelected : false
    required property string image 
    icon.source: image

    background: Rectangle {
	color: "transparent"
	border.color: button.isSelected ? Colors.highlightButtonColor : "transparent"
	border.width: 2
	radius: 8 
    }
    
}
