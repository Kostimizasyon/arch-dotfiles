import QtQuick
import QtQuick.Controls

import "../../../Colors/"
import "../../../Sizes/"

Button {

    id: button
    property bool isSelected : false
    required property string image 
    icon.source: image
    icon.height: Sizes.squareIcon
    icon.width: Sizes.squareIcon

    background: Rectangle {
	color: "transparent"
	border.color: button.isSelected ? Colors.highlightButtonColor : "transparent"
	border.width: 1
	radius: 8 
    }
    
}
