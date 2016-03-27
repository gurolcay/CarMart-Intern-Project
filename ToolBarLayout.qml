import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Rectangle{
    id: toolbarLay
    function textFunc (value){
        if(value == 1) { return "<b>Car Mart<\b>" }
        if(value == 2) { return "<b>Models<\b>" }
        if(value == 3) { return "<b>Model Details<\b>" }
        if(value == 4) { return "<b>Car Details<\b>" }
    }
    Text{
        id:toolbarTitle
        anchors.centerIn: parent
        font.pixelSize: dp(22)
        color:"#ffffff"
        text: textFunc(stackViewController.depth);
    }
    MouseArea{
        id: backButton
        visible: stackViewController.depth> 1 ? true : false
        width: dp(60)
        height: dp(60)
        anchors.left: parent.left
        onClicked:{
            stackViewController.pop();
        }
        Image {
            source:"/symbols/symbols/white-left-arrow.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: dp(10)
            mipmap: true
            width: dp(32)
            height: dp(32)
            fillMode: Image.PreserveAspectFit
        }
    }
}

