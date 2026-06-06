// ============================================================
//  Miles Morales SDDM Theme  –  Main.qml  (v3 - no delegate)
// ============================================================

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: "#0D0D0D"

    // ── Fon şəkli ──────────────────────────────────────────
    Image {
        id: background
        anchors.fill: parent
        source: config.background !== undefined ? config.background : ""
        fillMode: Image.PreserveAspectCrop
        smooth: true
        asynchronous: true
        opacity: 0
        Behavior on opacity { NumberAnimation { duration: 800; easing.type: Easing.OutCubic } }
        onStatusChanged: { if (status === Image.Ready) opacity = 1 }
    }

    // ── Qaranlıq overlay ──────────────────────────────────
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.55
    }

    // ── Sol üst: MARVEL ───────────────────────────────────
    Text {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 32
        text: "MARVEL"
        font.family: "Arial Black"
        font.pixelSize: 13
        font.letterSpacing: 8
        font.bold: true
        color: "#E31D1C"
        opacity: 0.9
    }

    // ── Sağ üst: saat ─────────────────────────────────────
    Column {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 32
        spacing: 2

        Text {
            id: clockText
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatTime(new Date(), "hh:mm")
            font.pixelSize: 48
            font.bold: true
            color: "#FFFFFF"
            style: Text.Outline
            styleColor: "#E31D1C"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDate(new Date(), "dddd, dd MMMM yyyy")
            font.pixelSize: 13
            color: "#CCCCCC"
            font.letterSpacing: 1
        }

        Timer {
            interval: 1000
            repeat: true
            running: true
            onTriggered: clockText.text = Qt.formatTime(new Date(), "hh:mm")
        }
    }

    // ── Aşağı sol: host adı ───────────────────────────────
    Text {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 28
        text: sddm.hostName
        font.pixelSize: 12
        color: "#888888"
        font.letterSpacing: 2
    }

    // ── Aşağı sağ: session seçici (← Ad →) ───────────────
    Row {
        id: sessionRow
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 28
        spacing: 8

        property int sessionIdx: sessionModel.lastIndex

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "SESSION:"
            font.pixelSize: 10
            color: "#555555"
            font.letterSpacing: 2
        }

        Rectangle {
            width: 24; height: 24; radius: 4
            color: lMouse.containsMouse ? "#1A1A1A" : "transparent"
            border.color: "#333333"; border.width: 1
            anchors.verticalCenter: parent.verticalCenter
            Text { anchors.centerIn: parent; text: "‹"; color: "#888888"; font.pixelSize: 16 }
            MouseArea {
                id: lMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    sessionRow.sessionIdx = (sessionRow.sessionIdx - 1 + sessionModel.rowCount()) % sessionModel.rowCount()
                }
            }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: sessionModel.data(sessionModel.index(sessionRow.sessionIdx, 0), 257) || "Session"
            color: "#CCCCCC"
            font.pixelSize: 12
            width: 130
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            width: 24; height: 24; radius: 4
            color: rMouse.containsMouse ? "#1A1A1A" : "transparent"
            border.color: "#333333"; border.width: 1
            anchors.verticalCenter: parent.verticalCenter
            Text { anchors.centerIn: parent; text: "›"; color: "#888888"; font.pixelSize: 16 }
            MouseArea {
                id: rMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    sessionRow.sessionIdx = (sessionRow.sessionIdx + 1) % sessionModel.rowCount()
                }
            }
        }
    }

    // ══════════════════════════════════════════════════════
    //  MƏRKƏZİ GİRİŞ PANELİ
    // ══════════════════════════════════════════════════════
    Item {
        anchors.centerIn: parent
        width: 420
        height: loginCard.height + 80

        // ── Yuxarı M badge ──────────────────────────────
        Canvas {
            id: badge
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: loginCard.top
            anchors.bottomMargin: 24
            width: 64; height: 64
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.shadowColor = "#E31D1C"
                ctx.shadowBlur = 18
                var cx = 32, cy = 32, r = 28
                ctx.beginPath()
                for (var i = 0; i < 6; i++) {
                    var angle = (Math.PI / 3) * i - Math.PI / 6
                    var x = cx + r * Math.cos(angle)
                    var y = cy + r * Math.sin(angle)
                    if (i === 0) ctx.moveTo(x, y); else ctx.lineTo(x, y)
                }
                ctx.closePath()
                ctx.fillStyle = "#E31D1C"
                ctx.fill()
                ctx.strokeStyle = "#FF4444"
                ctx.lineWidth = 2
                ctx.stroke()
            }
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: loginCard.top
            anchors.bottomMargin: 28
            text: "M"
            font.pixelSize: 26; font.bold: true
            color: "#FFFFFF"
        }

        // ── Login kartı ──────────────────────────────────
        Rectangle {
            id: loginCard
            anchors.centerIn: parent
            width: 420
            height: cardCol.implicitHeight + 48
            color: "#0D0D0D"
            opacity: 0.93
            radius: 16
            border.color: "#E31D1C"
            border.width: 1.5

            // Sol kənar şəridi
            Rectangle {
                width: 4
                height: parent.height - 32
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: "#E31D1C"; radius: 2
            }

            // Bioluminescent nöqtə
            Rectangle {
                width: 8; height: 8; radius: 4
                anchors.top: parent.top; anchors.right: parent.right
                anchors.margins: 16
                color: "#8B5CF6"
                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { to: 0.2; duration: 900 }
                    NumberAnimation { to: 1.0; duration: 900 }
                }
            }

            Column {
                id: cardCol
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 24
                width: parent.width - 48
                spacing: 16

                // Başlıq
                Column {
                    width: parent.width; spacing: 4
                    Text {
                        text: "SPIDER-MAN"
                        font.pixelSize: 11; font.letterSpacing: 5
                        color: "#E31D1C"; font.bold: true
                    }
                    Text {
                        text: "Miles Morales"
                        font.pixelSize: 26; font.bold: true
                        color: "#FFFFFF"
                    }
                    Text {
                        text: "\"Anyone can wear the mask.\""
                        font.pixelSize: 11; color: "#666666"; font.italic: true
                    }
                }

                Rectangle { width: parent.width; height: 1; color: "#E31D1C"; opacity: 0.3 }

                // İstifadəçi adı
                Column {
                    width: parent.width; spacing: 6
                    Text { text: "USER"; font.pixelSize: 10; font.letterSpacing: 3; color: "#888888" }
                    Rectangle {
                        width: parent.width; height: 44
                        color: "#1A1A1A"; radius: 8
                        border.color: userField.activeFocus ? "#E31D1C" : "#333333"
                        border.width: userField.activeFocus ? 1.5 : 1
                        Behavior on border.color { ColorAnimation { duration: 200 } }
                        TextField {
                            id: userField
                            anchors.fill: parent; anchors.margins: 2
                            text: userModel.lastUser
                            placeholderText: "username"
                            color: "#FFFFFF"; placeholderTextColor: "#555555"
                            font.pixelSize: 14; leftPadding: 14
                            background: Item {}
                            KeyNavigation.tab: passField
                            Keys.onReturnPressed: passField.forceActiveFocus()
                        }
                    }
                }

                // Şifrə
                Column {
                    width: parent.width; spacing: 6
                    Text { text: "PASSWORD"; font.pixelSize: 10; font.letterSpacing: 3; color: "#888888" }
                    Rectangle {
                        width: parent.width; height: 44
                        color: "#1A1A1A"; radius: 8
                        border.color: passField.activeFocus ? "#E31D1C" : "#333333"
                        border.width: passField.activeFocus ? 1.5 : 1
                        Behavior on border.color { ColorAnimation { duration: 200 } }
                        TextField {
                            id: passField
                            anchors.fill: parent; anchors.margins: 2
                            echoMode: TextInput.Password
                            placeholderText: "••••••••"
                            color: "#FFFFFF"; placeholderTextColor: "#555555"
                            font.pixelSize: 14; leftPadding: 14
                            background: Item {}
                            Keys.onReturnPressed: doLogin()
                        }
                    }
                }

                // Xəta mesajı
                Text {
                    id: errorMsg
                    width: parent.width; text: ""
                    color: "#FF4444"; font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    visible: text !== ""; wrapMode: Text.WordWrap
                }

                // Login düyməsi
                Rectangle {
                    id: loginBtn
                    width: parent.width; height: 46; radius: 8
                    color: loginMouse.containsMouse ? "#FF2222" : "#E31D1C"
                    Behavior on color { ColorAnimation { duration: 150 } }
                    Text {
                        anchors.centerIn: parent
                        text: "ENTER THE SPIDER-VERSE"
                        font.pixelSize: 12; font.bold: true
                        font.letterSpacing: 2; color: "#FFFFFF"
                    }
                    MouseArea {
                        id: loginMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: doLogin()
                    }
                }

                // Power düymələri
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 24; bottomPadding: 4

                    Text {
                        text: "⏸  SLEEP"
                        visible: sddm.canSuspend
                        color: sleepM.containsMouse ? "#E31D1C" : "#555555"
                        font.pixelSize: 11; font.letterSpacing: 1
                        Behavior on color { ColorAnimation { duration: 150 } }
                        MouseArea { id: sleepM; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: sddm.suspend() }
                    }

                    Text {
                        text: "↺  REBOOT"
                        visible: sddm.canReboot
                        color: rebootM.containsMouse ? "#E31D1C" : "#555555"
                        font.pixelSize: 11; font.letterSpacing: 1
                        Behavior on color { ColorAnimation { duration: 150 } }
                        MouseArea { id: rebootM; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: sddm.reboot() }
                    }

                    Text {
                        text: "⏻  SHUTDOWN"
                        visible: sddm.canPowerOff
                        color: powerM.containsMouse ? "#E31D1C" : "#555555"
                        font.pixelSize: 11; font.letterSpacing: 1
                        Behavior on color { ColorAnimation { duration: 150 } }
                        MouseArea { id: powerM; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: sddm.powerOff() }
                    }
                }
            }
        }
    }

    // ── SDDM siqnalları ───────────────────────────────────
    Connections {
        target: sddm
        function onLoginFailed() {
            errorMsg.text = "Login failed. Check your credentials."
            passField.text = ""
            passField.forceActiveFocus()
            shakeAnim.start()
        }
    }

    SequentialAnimation {
        id: shakeAnim
        NumberAnimation { target: loginCard; property: "x"; to: loginCard.x - 10; duration: 50 }
        NumberAnimation { target: loginCard; property: "x"; to: loginCard.x + 10; duration: 50 }
        NumberAnimation { target: loginCard; property: "x"; to: loginCard.x - 6;  duration: 50 }
        NumberAnimation { target: loginCard; property: "x"; to: loginCard.x + 6;  duration: 50 }
        NumberAnimation { target: loginCard; property: "x"; to: loginCard.x;      duration: 50 }
    }

    function doLogin() {
        errorMsg.text = ""
        if (userField.text.trim() === "") {
            errorMsg.text = "Please enter your username."
            userField.forceActiveFocus()
            return
        }
        sddm.login(userField.text, passField.text, sessionRow.sessionIdx)
    }

    Component.onCompleted: {
        if (userField.text === "") userField.forceActiveFocus()
        else passField.forceActiveFocus()
    }
}
