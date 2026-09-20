import QtQuick
import QtQuick.Layouts
import "../../../Colors/"

Rectangle {

    required property int passedWidth

    property int v_margin: 6
    property int h_margin: 6
    property real barOpacity: 0.67
    property color barColor : "white"

    height: 1
    width: passedWidth

    color: barColor
    opacity: barOpacity

    Layout.topMargin: v_margin
    Layout.bottomMargin: v_margin
    Layout.leftMargin: h_margin
    Layout.rightMargin: h_margin
}
