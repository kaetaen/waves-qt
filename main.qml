import QtQuick
import DelayAudioFeedback 1.0
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs 

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Waves")
    onClosing: {
        listeningButton.daf.stopPulseAudio()
    }
    Component.onCompleted: {
        const pulseaudioInstalled = listeningButton.daf.verifyPulseAudioInstallation()
        
        if (!pulseaudioInstalled) {
            errorDialog.visible = true
        }
    }

    Rectangle {
        id: mainscreen
        anchors.fill: parent
        color: "#282a36"

        Rectangle {
            id: listeningButton
            signal clicked
            width: 300
            height: 300
            color: "#50fa7b"
            radius: 200
            scale: 1.05
            border.color: "#ffffff"
            anchors.centerIn: parent

            property int duration: 250
            property alias text: listenBtnLabel.text
            property bool listeningEnabled: false
            property DelayAudioFeedback daf: DelayAudioFeedback {}

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    parent.listeningEnabled = !parent.listeningEnabled

                    if (parent.listeningEnabled == true) {
                        listenBtnLabel.text = "Stop"
                        parent.daf.setStatus("stopped")
                        parent.daf.startPulseAudio()

                        listeningButton.width = 280
                        listeningButton.height = 280
                        listeningButton.radius = 200

                    } else {
                        listenBtnLabel.text = "Start"
                        parent.daf.setStatus("started") 
                        parent.daf.stopPulseAudio()

                        listeningButton.width = 300
                        listeningButton.height = 300
                        listeningButton.radius = 200

                    }
                }

                Timer {
                   id: timer
                   interval: 1000
                   running: listeningButton.listeningEnabled
                   repeat: true
                   onTriggered: function (){
                       glow.visible = true
                       animation1.start()
                       animation2.start()
                   }
                }
            }
        //! [0]

            Rectangle {
                id: glow
                visible: false
                anchors.centerIn: parent

                width: 300
                height: 300
                color: "#bd93f9"
                radius: 150
                scale: 1.05
                border.color: "#ffffff"
            }

            Label {
                id: listenBtnLabel
                x: 300
                y: 300
                text: "Start"
                anchors.centerIn: parent
                color: "#f8f8f2"
                font.pixelSize: 28
                font.bold: true
            }

            PropertyAnimation {
                target: glow
                id: animation1
                loops: 1
                from: 1.05
                to: 1.2
                property: "scale"
            }

            ParallelAnimation {
                id: animation2
                SequentialAnimation {
                    PropertyAnimation {
                        target: glow
                        loops: 1
                        from: 0.2
                        to: 1.0
                        property: "opacity"
                    }
                    PropertyAnimation {
                        target: glow
                        loops: 1
                        from: 1.0
                        to: 0.0
                        property: "opacity"
                    }

                    PropertyAction {
                        target: glow
                        property: "visible"
                        value: false
                    }
                }

                SequentialAnimation {
                    PropertyAction {
                        target: glow
                        property: "border.width"
                        value: 20
                    }

                    PauseAnimation {
                        duration: 200
                    }

                    PropertyAnimation {
                        target: glow
                        loops: 1
                        from: 20
                        to: 10
                        property: "border.width"
                    }
                }
            }
        }
    }

    MessageDialog {
        visible: false
        id: errorDialog
        title: "PulseAudio not installed"
        text: "Please install PulseAudio for the program to function correctly"
        onAccepted: {
            Qt.quit()
        }
    }
}
