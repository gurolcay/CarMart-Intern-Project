import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1


Rectangle {
    //cihaz ekranina gore boyutlandırma icin gerekli kod
    function dp(value){
        return value *dpiScaleFactor
    }

    //sonu
    id:root
    width: dp(473)
    height: dp(679)
    visible: true
    color:"#76a5af"

    property var makeName
    property var makeIMG
    property var modelProperty
    property var modelName

    ToolBarLayout{
        id:toolbarLayout
        color:"#76a5af"
        height: dp(60)
        width: parent.width
        border.color:"#000000"
        border.width: dp(2)
    }

    Rectangle{
        id:subRectangle
        anchors.top: toolbarLayout.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left     
        color:"#45818e"
        border.width: dp(1)
        border.color:"black"

        Rectangle{
            id: makeImgName
            height: dp(110)
            anchors.left:parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: dp(10)
            color: "transparent"

            Image {
                id:makeImg
                width: dp(100)
                height: dp(100)
                anchors.left: parent.left
                anchors.leftMargin: dp(20)
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                source:makeIMG
            }
            Rectangle{
                anchors.left: makeImg.right
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                color: "transparent"

                Text{
                    text: makeName + " " + modelName
                    elide: Text.ElideRight
                    anchors.centerIn: parent
                    font.pixelSize: dp(24)
                    fontSizeMode: Text.Fit
                    font.bold: true
                    color:"white"                    
                }
            }
        }

        Component.onCompleted: {
            console.log("Model Name: ",JSON.stringify(modelProperty));
            console.log("Make Name: ",makeName);
            console.log("Make IMG: ",makeIMG);

            //console.log("modelProperty: ",JSON.stringify(modelProperty));
            for(var i in modelProperty){
                lightCarInf.append({
                                    carName:modelProperty[i].Name,
                                    carMiles: modelProperty[i].Miles,
                                    carDrive: modelProperty[i].Drive,
                                    carIMGSource: modelProperty[i].Source,
                                    carIMGS: modelProperty[i].Images
                                   })
                console.log("carIMGSource: ",JSON.stringify(modelProperty[i].Source));
                console.log("Images: ",JSON.stringify(modelProperty[i].Images));
            }
        }

        ListModel { id: lightCarInf }

        ListView{
            model: lightCarInf
            delegate: lightCarInfDel
            anchors.top: makeImgName.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: dp(20)
            anchors.bottomMargin: dp(10)
            anchors.left: parent.left
            anchors.right: parent.right
            spacing:dp(1)
            clip: true
        }

        Component {
            id: lightCarInfDel

            Rectangle{
                id: carsLightInfRec
                width: dp(365)
                height: dp(92)
                color:"white"
                anchors.left: parent.left
                anchors.right: parent.right

                Image{
                    id: mainCarImg
                    anchors.verticalCenter: parent.verticalCenter
                    source: carIMGSource
                    anchors.left: parent.left
                    anchors.leftMargin: dp(10)
                    width: dp(93)
                    height: dp(77)
                    smooth: true
                    fillMode: Image.PreserveAspectFit

                }
                Rectangle{
                    id: infRec
                    width: dp(230)
                    height: dp(74)
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: dp(10)

                    ColumnLayout{
                       anchors.fill: parent
                       spacing: dp(1)
                       Text {
                           text:"Name: " + carName
                           elide: Text.ElideRight
                       }
                       Text { text:"Miles: " + carMiles }
                       Text { text:"Miles: " + carDrive }
                   }
                }
                Image{
                    id:rightArrow
                    width: dp(32)
                    height: dp(32)
                    source:"/symbols/symbols/black-right-arrow.png"
                    anchors.right: parent.right
                    anchors.rightMargin: dp(10)
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        stackView.push({item:Qt.resolvedUrl("carDetailsPage.qml"),
                                       properties: {
                                        carClickOn : modelProperty[index]
                                       }})

                    }
                }
            }
        }
    }
}
