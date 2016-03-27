import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    function dp(value){
        return value *dpiScaleFactor
    }
    property alias stackViewController: stackView

    id:root
    title: qsTr("SSH CARS")
    width: dp(473)
    height: dp(679)
    visible: true
    color:"#76a5af"

    StackView {
        id: stackView
        anchors.fill: parent
        focus: true
        initialItem: Qt.resolvedUrl("makesPage.qml")
    }
}
