import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1


Rectangle {
    id:modelsRoot
    color:"#76a5af"
    width:dp(473)
    height: dp(679)
    visible: true

    property var makeName
    property var makeIMG
    property var dataModels

    ToolBarLayout{
        id:toolbarLayout
        color:"#76a5af"
        height: dp(60)
        width: parent.width
        border.color:"#000000"
        border.width: dp(2)
    }

    Rectangle {
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
                anchors.top:parent.top
                anchors.bottom: parent.bottom
                color: "transparent"

                Text{
                    text: makeName
                    anchors.centerIn: parent
                    font.pixelSize: dp(32)
                    fontSizeMode: Text.Fit
                    font.bold: true
                    color:"white"
                    anchors.verticalCenter: makeImg.verticalCenter

                }
            }
        }


Component.onCompleted: {
    console.log("dataModels: ]",JSON.stringify(dataModels));
    for(var i in dataModels.Model){
        modelsModel.append({modelsName: i, carsNumber: dataModels.Model[i].length});
        console.log("modelsName",i);
        console.log("carsNumber: ",dataModels.Model[i].length);
    }
}

        ListModel { id: modelsModel }
        ListView{
            model: modelsModel
            delegate: modelsDelagate
            anchors.top: makeImgName.bottom
            anchors.topMargin: dp(20)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: dp(10)
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: dp(1)
            clip: true
        }

        Component {
            id:modelsDelagate
            Rectangle {
                id: modelsNameRec
                width:dp(290)
                height: dp(92)
                color:"white"
                anchors.right: parent.right
                anchors.left: parent.left
                Text {
                    text: modelsName
                    font.pixelSize: dp(18)
                    minimumPixelSize: dp(14)
                    fontSizeMode: Text.Fit
                    anchors.left: parent.left
                    anchors.leftMargin: dp(10)
                    anchors.verticalCenter: parent.verticalCenter
                }
                Rectangle {
                    id:carsNum
                    width: dp(20)
                    height: dp(20)
                    radius: dp(10)
                    color: "red"
                    anchors.right: rightArrow.left
                    anchors.rightMargin: dp(10)
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        text: carsNumber
                        anchors.centerIn: parent
                        font.pixelSize: dp(14)
                        color: "white"
                    }
                }

                Image{
                    id:rightArrow
                    source: "/symbols/symbols/black-right-arrow.png"
                    width: dp(32)
                    height: dp(32)
                    anchors.right: parent.right
                    anchors.rightMargin: dp(5)
                    anchors.verticalCenter: parent.verticalCenter
                    mipmap: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push ({item:Qt.resolvedUrl("carsPage.qml"),
                                        properties: {
                                        modelProperty: dataModels.Model[modelsName],
                                        modelName: modelsName,
                                        makeName: makeName,
                                        makeIMG: makeIMG} })
                       // console.log("modelsName Length: ",modelsName.length);
                    }
                }
            }
        }
    }

    /*
    onDataModelsChanged: {
        console.log('DatModels:', JSON.stringify(dataModels))
    }*/
}

