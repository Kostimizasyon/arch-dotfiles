import QtQuick
import QtQuick.Controls

import "../Colors/"
import "../Sizes/"

Rectangle {

    width: 120
    height: 30
    color: Colors.backgroundColor
    radius : Sizes.circularRadius

    Text {
        id: clock

        property bool showDate : false

        anchors.centerIn: parent
        text: Qt.formatDateTime(new Date(), "HH:mm:ss")
        color: Colors.foregroundColor

        Timer {
            id: defaultTimer
            interval: 1000
            running: true
            repeat: true
            onTriggered:   {
                   clock.text = Qt.formatDateTime(new Date(), "HH:mm:ss")
            }
        }
        
        Timer {
            id: dateTimer
            interval: 5000
            running: false
            onTriggered: {
                clock.text = Qt.formatDateTime(new Date(), "HH:mm:ss")
                clock.showDate = false
                defaultTimer.start()
            }
        }

    }

    MouseArea {
        anchors.fill:parent
        onClicked: {
            if (!clock.showDate) {
                    clock.showDate = true
                    clock.text = Qt.formatDateTime(new Date(), "dd/MM")
                    defaultTimer.stop()
                    dateTimer.start()
            }
            else {
                    clock.showDate = false
                    clock.text = Qt.formatDateTime(new Date(), "HH:mm:ss")
                    dateTimer.stop()
                    defaultTimer.start()
            }
        }
    }

}
