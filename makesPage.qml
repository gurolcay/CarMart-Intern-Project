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
    color:"#45818e"

    property var jsonData: JSON.parse(getJson.readData()); // yerel dosyadan
    property var jsonData

    ToolBarLayout{
        id:toolbarLayout
        color:"#76a5af"
        height: dp(60)
        width: parent.width
        border.color:"#000000"
        border.width: dp(2)
    }

Component.onCompleted: {
    var xmlhttp = new XMLHttpRequest(); // internetten json çekmek icin
    xmlhttp.open("GET","http://gateofturkey.com/reklam/jsonfile.json");
    xmlhttp.onreadystatechange = function () {
        if(xmlhttp.readyState === XMLHttpRequest.DONE) {
            jsonData = JSON.parse(xmlhttp.responseText);
            for (var i in jsonData.Cars.Make){
                var k = 1,n = 0;
                for(var j in jsonData.Cars.Make[i].Model){
                    ++k;
                    n += jsonData.Cars.Make[i].Model[j].length;
                    //console.log("length,", jsonData.Cars.Make[i].Model[j].length );
                }
                makeModel.append({
                                    carMakeName: i ,
                                    makesImg: jsonData.Cars.Make[i].Source,
                                    modelsNumber: k,
                                    carsNumber: n
                                 });
                console.log("CarMakeName: ",JSON.stringify(i));
            }
        }
    }
    xmlhttp.send();
}

    ListModel { id:makeModel  }

    ListView {
        anchors.top: toolbarLayout.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: dp(5)
        model: makeModel
        spacing: dp(1)
        clip: true
        delegate: makeDelegate
    }

    Component {
        id: makeDelegate
        Rectangle {
            width: parent.width
            height: dp(92)

            ColumnLayout {
                anchors.centerIn: parent
                anchors.left: parent.left
                Text {
                    text: carMakeName
                    font.pixelSize: dp(18)
                }
                Text {
                    text:modelsNumber + " models"
                    font.pixelSize:  dp(14)
                }
            }
            Rectangle {
                width: dp(20)
                height: dp(20)
                radius: dp(10)
                color: "red"
                anchors.right: rightArrow.left
                anchors.rightMargin: dp(10)
                anchors.verticalCenter: parent.verticalCenter

                Text{
                    text: carsNumber
                    anchors.centerIn: parent
                    font.pixelSize: dp(14)
                    color:"white"
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    stackView.push({item:Qt.resolvedUrl("models.qml"),
                                       properties: {makeName:carMakeName ,
                                            makeIMG:makesImg,
                                            dataModels: jsonData.Cars.Make[carMakeName]
                                            }});
                }
            }
            Image {
                source: makesImg
                fillMode: Image.PreserveAspectFit
                width: dp(90)
                height: dp(90)
                mipmap: true
                anchors.left: parent.left
                anchors.leftMargin: dp(15)
                anchors.verticalCenter: parent.verticalCenter
            }
            Image {
                id:rightArrow
                width: dp(32)
                height: dp(32)
                anchors.right: parent.right
                anchors.rightMargin: dp(5)
                anchors.verticalCenter: parent.verticalCenter
                mipmap: true
                fillMode: Image.PreserveAspectFit
                source: "/symbols/symbols/black-right-arrow.png"
            }
        }
    }
}

