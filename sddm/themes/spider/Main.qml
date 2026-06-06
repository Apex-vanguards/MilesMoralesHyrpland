import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: "#050000"

    // ── Background image ──────────────────────────────────────
    Image {
        id: bg
        anchors.fill: parent
        source: config.background || "background.jpg"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    // Dark overlay
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.55
    }

    // Red vignette overlay
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Radial
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: "#88000000" }
        }
        opacity: 0.7
    }

    // ── Web line decorations ──────────────────────────────────
    Canvas {
        anchors.fill: parent
        opacity: 0.12
        onPaint: {
            var ctx = getContext("2d")
            ctx.strokeStyle = "#cc0000"
            ctx.lineWidth = 1
            // diagonal web lines
            for (var i = -height; i < width + height; i += 90) {
                ctx.beginPath()
                ctx.moveTo(i, 0)
                ctx.lineTo(i + height, height)
                ctx.stroke()
            }
            for (var j = -height; j < width + height; j += 90) {
                ctx.beginPath()
                ctx.moveTo(j + height, 0)
                ctx.lineTo(j, height)
                ctx.stroke()
            }
        }
    }

    // ── Corner accent lines ───────────────────────────────────
    // Top-left
    Rectangle { x: 0;          y: 40;  width: 120; height: 1; color: "#cc0000"; opacity: 0.8 }
    Rectangle { x: 0;          y: 42;  width: 60;  height: 1; color: "#ff2020"; opacity: 0.5 }
    Rectangle { x: 40;         y: 0;   width: 1;   height: 120; color: "#cc0000"; opacity: 0.8 }
    Rectangle { x: 42;         y: 0;   width: 1;   height: 60;  color: "#ff2020"; opacity: 0.5 }
    // Top-right
    Rectangle { x: root.width-120; y: 40;  width: 120; height: 1; color: "#cc0000"; opacity: 0.8 }
    Rectangle { x: root.width-60;  y: 42;  width: 60;  height: 1; color: "#ff2020"; opacity: 0.5 }
    Rectangle { x: root.width-41;  y: 0;   width: 1;   height: 120; color: "#cc0000"; opacity: 0.8 }
    Rectangle { x: root.width-43;  y: 0;   width: 1;   height: 60;  color: "#ff2020"; opacity: 0.5 }
    // Bottom-left
    Rectangle { x: 0;          y: root.height-41; width: 120; height: 1; color: "#cc0000"; opacity: 0.8 }
    Rectangle { x: 40;         y: root.height-121; width: 1; height: 120; color: "#cc0000"; opacity: 0.8 }
    // Bottom-right
    Rectangle { x: root.width-120; y: root.height-41; width: 120; height: 1; color: "#cc0000"; opacity: 0.8 }
    Rectangle { x: root.width-41;  y: root.height-121; width: 1; height: 120; color: "#cc0000"; opacity: 0.8 }

    // ── Clock — top center ────────────────────────────────────
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.08
        spacing: 6

        // "INITIALIZING..." label
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "[ SPIDER-OS ]"
            font.family: "JetBrains Mono"
            font.pixelSize: 13
            font.letterSpacing: 6
            color: "#660000"
        }

        // Big clock
        Text {
            id: clockText
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatTime(new Date(), "hh:mm")
            font.family: "Orbitron"
            font.pixelSize: 96
            font.bold: true
            font.letterSpacing: 8
            color: "#ff2020"

            // Glow effect via layered copies
            layer.enabled: true
            layer.effect: null

            // Red glow simulation with shadow
            style: Text.Outline
            styleColor: "#660000"
        }

        // Seconds
        Text {
            id: secondsText
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatTime(new Date(), "ss")
            font.family: "JetBrains Mono"
            font.pixelSize: 22
            color: "#cc0000"
            font.letterSpacing: 4
        }

        // Date
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDate(new Date(), "dddd  ·  dd MMM yyyy")
            font.family: "JetBrains Mono"
            font.pixelSize: 14
            color: "#880000"
            font.letterSpacing: 3
        }
    }

    // Clock timer
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            clockText.text = Qt.formatTime(new Date(), "hh:mm")
            secondsText.text = Qt.formatTime(new Date(), "ss")
        }
    }

    // ── Spider logo — center background ──────────────────────
    Image {
        id: spiderLogo
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -40
        source: "spider.png"
        width: 220
        height: 220
        fillMode: Image.PreserveAspectFit
        opacity: 0.08
    }

    // ── Login panel — center ──────────────────────────────────
    Rectangle {
        id: loginPanel
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 60
        width: 380
        height: 280
        color: "#000000"
        opacity: 0.0
        // transparent — children handle their own bg
    }

    Column {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 60
        width: 360
        spacing: 14

        // Spider icon small
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "🕷"
            font.pixelSize: 32
            color: "#cc0000"
        }

        // Username field
        Rectangle {
            width: parent.width
            height: 44
            color: "#0d0000"
            border.color: userField.activeFocus ? "#ff2020" : "#440000"
            border.width: 1
            radius: 4

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 14
                spacing: 10

                Text {
                    text: ""
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 16
                    color: "#cc0000"
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextInput {
                    id: userField
                    width: 280
                    text: userModel.lastUser
                    font.family: "JetBrains Mono"
                    font.pixelSize: 14
                    color: "#e8e8e8"
                    anchors.verticalCenter: parent.verticalCenter
                    KeyNavigation.tab: passField
                    Keys.onReturnPressed: passField.forceActiveFocus()
                }
            }
        }

        // Password field
        Rectangle {
            width: parent.width
            height: 44
            color: "#0d0000"
            border.color: passField.activeFocus ? "#ff2020" : "#440000"
            border.width: 1
            radius: 4

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 14
                spacing: 10

                Text {
                    text: ""
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 16
                    color: "#cc0000"
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextInput {
                    id: passField
                    width: 280
                    echoMode: TextInput.Password
                    passwordCharacter: "●"
                    font.family: "JetBrains Mono"
                    font.pixelSize: 14
                    color: "#e8e8e8"
                    placeholderText: "password"
                    placeholderTextColor: "#440000"
                    anchors.verticalCenter: parent.verticalCenter
                    KeyNavigation.tab: loginBtn
                    Keys.onReturnPressed: doLogin()
                }
            }
        }

        // Login button
        Rectangle {
            id: loginBtn
            width: parent.width
            height: 44
            color: loginMouse.containsMouse ? "#cc0000" : "#1a0000"
            border.color: "#cc0000"
            border.width: 1
            radius: 4
            focus: true

            Text {
                anchors.centerIn: parent
                text: "LOGIN  →"
                font.family: "JetBrains Mono"
                font.pixelSize: 14
                font.bold: true
                font.letterSpacing: 4
                color: loginMouse.containsMouse ? "#ffffff" : "#cc0000"
            }

            MouseArea {
                id: loginMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: doLogin()
            }

            Keys.onReturnPressed: doLogin()
        }

        // Session selector
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8

            Text {
                text: "Session:"
                font.family: "JetBrains Mono"
                font.pixelSize: 11
                color: "#440000"
                anchors.verticalCenter: parent.verticalCenter
            }

            ComboBox {
                id: sessionCombo
                width: 180
                height: 28
                model: sessionModel
                textRole: "name"
                currentIndex: sessionModel.lastIndex
                font.family: "JetBrains Mono"
                font.pixelSize: 11

                contentItem: Text {
                    text: sessionCombo.displayText
                    font: sessionCombo.font
                    color: "#cc0000"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 8
                }

                background: Rectangle {
                    color: "#0d0000"
                    border.color: "#440000"
                    border.width: 1
                    radius: 3
                }
            }
        }

        // Error message
        Text {
            id: errorMsg
            anchors.horizontalCenter: parent.horizontalCenter
            text: ""
            font.family: "JetBrains Mono"
            font.pixelSize: 12
            color: "#ff0000"
            visible: text !== ""
        }
    }

    // ── Bottom info bar ───────────────────────────────────────
    Row {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 40

        Text {
            text: "with great power comes great responsibility"
            font.family: "JetBrains Mono"
            font.pixelSize: 11
            font.letterSpacing: 2
            color: "#330000"
        }
    }

    // Hostname bottom-right
    Text {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        text: sddm.hostName
        font.family: "JetBrains Mono"
        font.pixelSize: 11
        color: "#440000"
    }

    // ── Login function ────────────────────────────────────────
    function doLogin() {
        errorMsg.text = ""
        sddm.login(userField.text, passField.text, sessionCombo.currentIndex)
    }

    Connections {
        target: sddm
        onLoginFailed: {
            errorMsg.text = "✗  wrong password"
            passField.text = ""
            passField.forceActiveFocus()
        }
    }

    // Focus on startup
    Component.onCompleted: {
        if (userField.text === "")
            userField.forceActiveFocus()
        else
            passField.forceActiveFocus()
    }
}
