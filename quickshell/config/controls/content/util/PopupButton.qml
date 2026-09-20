import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls

import "../../../Colors/"
import "../../../Sizes/"

Button {
    id: button
    property bool displayPopup: false
    property string label: ""   // optional text
    property color backgroundColor: Colors.backgroundColor

    property int passedHeight: 300
    property int passedWidth : 300

    icon.height: Sizes.squareIcon
    icon.width: Sizes.squareIcon

    text: label
    display: label === "" ? AbstractButton.IconOnly : AbstractButton.TextBesideIcon

    onClicked: {
        displayPopup = !displayPopup
    }

    default property alias content: contentArea.data
    required property var anchorWindow

    background: Rectangle {
        color: backgroundColor
        height: 40
        radius:  12   
    }

    PopupWindow {
        id: root
        implicitHeight: passedHeight
        implicitWidth: passedWidth

        anchor.window: button.anchorWindow
        anchor.rect.x: button.x
        anchor.rect.y: button.y + 5

        visible: button.displayPopup

        Item {
            anchors.fill: parent
            focus: true

            Keys.onEscapePressed: root.visible = false
        }

        HyprlandFocusGrab {
            id: grab
            windows: [root]
            onActiveChanged: if (!active) root.visible = false
        }

        Rectangle {
            id: contentArea
            anchors.fill: parent
            color: Colors.backgroundColor
            radius: 6
        }

        onVisibleChanged: if (visible) grab.active = true
    }
}
