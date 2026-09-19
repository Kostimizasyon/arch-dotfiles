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
        implicitHeight: 200
        implicitWidth: 300

        anchor.window: button.anchorWindow
        anchor.rect.x: 0
        anchor.rect.y: button.height + 5   // just below the button, small gap

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
        }

        onVisibleChanged: if (visible) grab.active = true
    }
}
