import QtQuick
import QtQuick.Layouts
import "../../../Colors/"

Rectangle {
    
    property int v_margin: 6
    property int h_margin: 6
    property real barOpacity: 0.5
    property color barColor : "white"

    width: 1
    color: barColor
    opacity: barOpacity

    Layout.fillHeight: true
    Layout.topMargin: v_margin
    Layout.bottomMargin: v_margin
    Layout.leftMargin: h_margin
    Layout.rightMargin: h_margin
}
