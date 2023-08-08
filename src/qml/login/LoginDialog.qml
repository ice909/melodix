import "../widgets"
import QtQuick 2.11
import QtQuick.Layouts 1.15
import org.deepin.dtk 1.0

Popup {
    id: root

    property string unikey
    property bool initing: true

    // 生成二维码key
    function generateQRCodeKey() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            unikey = JSON.parse(reply).data.unikey;
            generateQRCode();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/login/qr/key?timestamp=" + rootWindow.getTimestamp());
    }

    // 生成二维码
    function generateQRCode() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            qrCode.imgSrc = JSON.parse(reply).data.qrimg;
            initing = false;
            timer.start();
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/login/qr/create?key=" + unikey + "&qrimg=true&timestamp=" + rootWindow.getTimestamp());
    }

    // 二维码检测扫码状态
    function checkQRCodeStatus() {
        function onReply(reply) {
            network.onSendReplyFinished.disconnect(onReply);
            var status = JSON.parse(reply);
            if (status.code == 800)
                handleQRCodeExpired();
            else if (status.code == 801)
                console.log("二维码未被扫描，等待扫码");
            else if (status.code == 802)
                console.log("扫描成功，请在手机上确认登录");
            else if (status.code == 803)
                handleQRCodeScanned(status.cookie); // 登录成功
        }

        network.onSendReplyFinished.connect(onReply);
        network.makeRequest("/login/qr/check?key=" + unikey + "&timestamp=" + rootWindow.getTimestamp());
    }

    // 处理二维码被扫描后的逻辑
    function handleQRCodeScanned(cookie) {
        // 执行相应的操作，如登录成功后的跳转等
        console.log("登录成功");
        network.saveCookie(cookie);
        getAccountInfo();
        isLogin = true;
        timer.stop();
        root.close();
    }

    // 处理二维码失效后的逻辑
    function handleQRCodeExpired() {
        // 执行相应的操作，如提示二维码失效等
        console.log("二维码已过期,请重新获取");
        timer.stop();
    }

    width: 300
    height: 350
    visible: true
    x: (rootWindow.width - width) / 2
    y: (rootWindow.height - height) / 2 - 60
    modal: true
    Component.onCompleted: {
        console.log("登录窗口初始化完成");
        generateQRCodeKey();
    }
    onClosed: {
        console.log("登录窗口关闭");
        timer.stop();
    }

    Timer {
        id: timer

        interval: 2000 // 每2秒检测一次二维码状态
        running: false
        repeat: true
        onTriggered: checkQRCodeStatus()
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            id: topRect

            color: "transparent"
            width: parent.width
            height: 40

            Text {
                anchors.centerIn: parent
                text: "扫描二维码登录"
                font.bold: true
                font.pixelSize: DTK.fontManager.t4.pixelSize
            }

        }

        Rectangle {
            color: "transparent"
            width: parent.width
            height: parent.height - topRect.height - 10

            RoundedImage {
                id: qrCode

                width: parent.width - 50
                height: parent.height - 50
                anchors.centerIn: parent

                Rectangle {
                    id: loadAnimation

                    visible: initing
                    width: parent.width
                    height: parent.height
                    color: "transparent"

                    Loading {
                        anchors.centerIn: parent
                    }

                }

            }

        }

    }

    background: FloatingPanel {
        blurRadius: 20
    }

}
