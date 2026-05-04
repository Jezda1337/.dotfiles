import Quickshell
import Quickshell.Io
import QtQuick

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 20

    Text {
        // adding id gives posibility to access "this" later in a file
        id: clock
        // anchors.centerIn: parent
        anchors.left: parent

        Process {
            id: dateProc
            command: ["date", "+%H:%M:%S %b %d, %Y"]
            running: true
            stdout: StdioCollector {
                onStreamFinished: clock.text = text
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: dateProc.running = true
        }
    }
}
