<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Xác thực SĐT</title>
</head>
<body>
<h2>Đăng nhập bằng Số điện thoại</h2>

<div id="input-phone-step">
    <input type="text" id="phoneNumber" placeholder="+84912345678">
    <button onclick="sendOTP()">Gửi OTP</button>
</div>

<div id="verify-otp-step" style="display:none;">
    <input type="text" id="otpInput" placeholder="Nhập mã OTP 6 số">
    <button onclick="verifyOTP()">Xác nhận</button>
</div>

<div id="recaptcha-container"></div>

<script src="https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.10.1/firebase-auth.js"></script>

<script>
    const firebaseConfig = {
        apiKey: "AIzaVy...",
        authDomain: "project-id.firebaseapp.com",
        projectId: "project-id",
        storageBucket: "project-id.appspot.com",
        messagingSenderId: "...",
        appId: "..."
    };
    firebase.initializeApp(firebaseConfig);

    window.recaptchaVerifier = new firebase.auth.RecaptchaVerifier('recaptcha-container', {
        'size': 'invisible'
    });

    let confirmationResult;

    function sendOTP() {
        const phoneNumber = document.getElementById("phoneNumber").value;
        const appVerifier = window.recaptchaVerifier;

        firebase.auth().signInWithPhoneNumber(phoneNumber, appVerifier)
            .then((result) => {
                confirmationResult = result;
                alert("Đã gửi mã OTP!");
                document.getElementById("input-phone-step").style.display = "none";
                document.getElementById("verify-otp-step").style.display = "block";
            }).catch((error) => {
            console.error(error);
            alert("Lỗi gửi OTP: " + error.message);
        });
    }

    function verifyOTP() {
        const code = document.getElementById("otpInput").value;
        confirmationResult.confirm(code).then((result) => {
            const user = result.user;
            user.getIdToken().then((token) => {
                window.location.href = "login-phone?token=" + token;
            });
        }).catch((error) => {
            alert("Mã OTP sai!");
        });
    }
</script>
</body>
</html>