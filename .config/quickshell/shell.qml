import Quickshell
import Quickshell.Io // for process
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import Quickshell.Widgets

ShellRoot {
    PanelWindow {
        id: bar
        // this will take entire line of on the top
        anchors {
            top: true
            // bottom: true
            left: true
            right: true
        }

        // set height of the bar
        implicitHeight: 10
        color: "#111"

        // FloatingWindow {
        //     Timer {
        //         // assign an id to the object, which can be
        //         // used to reference it
        //         id: timer
        //         property bool invert: false // a custom property
        //
        //         // change the value of invert every half second
        //         running: true
        //         repeat: true
        //         interval: 500 // ms
        //         onTriggered: timer.invert = !timer.invert
        //     }
        //
        //     // change the window's color when timer.invert changes
        //     color: timer.invert ? "purple" : "green"
        // }

        Row {
            Layout.fillHeight: true
            anchors.verticalCenter: parent.verticalCenter
            Rectangle {
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "hi mom"
                    color: "#ff0000"
                    font.pointSize: 4
                }
            }
        }

        Text {
            id: text
            anchors.centerIn: parent
            font.pixelSize: 6
            color: "#fff"

            Process {
                id: dateProc
                command: ["date"]
                // run command on start
                running: true

                stdout: StdioCollector {
                    onStreamFinished: text.text = this.text
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

    Scope {
        id: root

        // Bind the pipewire node so its volume will be tracked
        PwObjectTracker {
            objects: [Pipewire.defaultAudioSink]
        }

        Connections {
            target: Pipewire.defaultAudioSink?.audio

            function onVolumeChanged() {
                root.shouldShowOsd = true;
                hideTimer.restart();
            }
        }

        property bool shouldShowOsd: false

        Timer {
            id: hideTimer
            interval: 1000
            onTriggered: root.shouldShowOsd = false
        }

        // The OSD window will be created and destroyed based on shouldShowOsd.
        // PanelWindow.visible could be set instead of using a loader, but using
        // a loader will reduce the memory overhead when the window isn't open.
        LazyLoader {
            active: root.shouldShowOsd

            PanelWindow {
                // Since the panel's screen is unset, it will be picked by the compositor
                // when the window is created. Most compositors pick the current active monitor.

                anchors.bottom: true
                margins.bottom: 10
                exclusiveZone: 0

                implicitWidth: 150
                implicitHeight: 20
                color: "transparent"

                // An empty click mask prevents the window from blocking mouse events.
                mask: Region {}

                Rectangle {
                    anchors.fill: parent
                    radius: height / 2
                    color: "#90000000"

                    RowLayout {
                        anchors {
                            fill: parent
                            leftMargin: 10
                            rightMargin: 5
                        }

                        IconImage {
                            implicitSize: 10
                            source: Quickshell.iconPath("/usr/share/icons/Papirus/24x24/symbolic/status/audio-volume-low-symbolic.svg")
                        }

                        Rectangle {
                            Layout.fillWidth: true

                            implicitHeight: 3
                            radius: 20
                            color: "#50ffffff"

                            Rectangle {
                                anchors {
                                    left: parent.left
                                    top: parent.top
                                    bottom: parent.bottom
                                }

                                implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                                radius: parent.radius
                            }
                        }

                        IconImage {
                            implicitSize: 10
                            source: Quickshell.iconPath("/usr/share/icons/Papirus/24x24/symbolic/status/audio-volume-high-symbolic.svg")
                        }
                    }
                }
            }
        }
    }
}
