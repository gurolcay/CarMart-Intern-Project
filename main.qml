import QtQuick 2.1
import QtQuick.Window 2.0

Window {
    visible: true
    width: 360
    height: 360

    property int intValue: 1



    Text {
        id: mainText
        text: qsTr("Tikla")
        font.pixelSize: 16
        anchors.centerIn: parent
        MouseArea{
            anchors.fill: parent
            onPressed: {
                var data = JSON.parse(bridge.readData());
                mainText.text = 'First Car: ' + data.Cars.Make.Acura.Model.ILX.Trim['2.4'][0].Name
                console.log('JSON: ', JSON.stringify(data));
            }
        }
    }



}


