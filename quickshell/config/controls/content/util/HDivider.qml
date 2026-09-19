import QtQuick
import QtQuick.Layouts
import "../../../Colors/"

Rectangle {
    
    property int v_margin: 6
    property int h_margin: 6
    property real barOpacity: 0.67
    property color barColor : Colors.borderColor

    height: 3
    width: 3

    color: barColor
    opacity: barOpacity

    Layout.fillHeight: true
    Layout.topMargin: v_margin
    Layout.bottomMargin: v_margin
    Layout.leftMargin: h_margin
    Layout.rightMargin: h_margin
}
