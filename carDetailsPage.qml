import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Rectangle{
    //cihaz ekranina gore boyutlandırma icin gerekli kod
    function dp(value){
        return value *dpiScaleFactor
    }

    property var carClickOn

    //sonu
    id:root
    width: dp(473)
    height: dp(679)
    visible: true
    color:"#45818e"

    ToolBarLayout{
        id:toolbarLayout
        color:"#76a5af"
        height: dp(60)
        width: parent.width
        border.color:"#000000"
        border.width: dp(2)
    }
    Rectangle{
        anchors.top: toolbarLayout.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: parent.color
        Rectangle{
            id:imgViewRec
            width: parent.width
            height: dp(120)
            anchors.top: parent.top
            anchors.topMargin: dp(30)
            anchors.horizontalCenter: parent.horizontalCenter
            color:"transparent"

            Component.onCompleted: {
                console.log("carClickOn: ",JSON.stringify(carClickOn));
                console.log("Images: ",JSON.stringify(carClickOn.Images.length));

                for(var i = 0; i < carClickOn.Images.length; ++i){
                    listViewImgModel.append ({
                                            carImages: carClickOn.Images[i]
                                         })
                    console.log("Path: ",JSON.stringify(carClickOn.Images[i]));
                }
            }
            ListModel{ id:listViewImgModel }
            ListView{
                model: listViewImgModel
                delegate: listViewImgDel
                anchors.fill: parent
                orientation: ListView.Horizontal
                snapMode: ListView.SnapToItem
                clip: true
                spacing: dp(7)
            }
            Component{
                id:listViewImgDel
                Image{
                    source: carImages
                    width:dp(160)
                    height: dp(120)
                    mipmap: true
                }
            }
        }


        Rectangle{
            width: dp(365)
            height: dp(310)
            anchors.top: imgViewRec.bottom
            anchors.topMargin: dp(30)
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: "black"
            border.width: dp(1)
            color:"white"
            ColumnLayout{
                anchors.fill: parent
                anchors.left: parent.left
                anchors.leftMargin: dp(20)
                Text{ text: "Name       : " + carClickOn.Name; font.pixelSize: dp(14) }
                Text{text: "Miles       : " + carClickOn.Miles; font.pixelSize: dp(14) }
                Text{text: "Drive       : " + carClickOn.Drive; font.pixelSize: dp(14)}
                Text{text: "Trans       : " + carClickOn.Trans; font.pixelSize: dp(14)}
                Text{text: "MPG         : " + carClickOn.MPG; font.pixelSize: dp(14)}
                Text{text: "Exterior    : " + carClickOn.Exterior; font.pixelSize: dp(14)}
                Text{text: "Interior    : " + carClickOn.Interior; font.pixelSize: dp(14)}
                Text{text: "Trim        : " + carClickOn.Trim; font.pixelSize: dp(14)}
                Text{text: "Price       : " + carClickOn.Price; font.pixelSize: dp(14)}

            }

        }
    }
}
