<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đăng nhập bằng SĐT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow">
                <div class="card-body p-4">
                    <h3 class="text-center mb-4">Đăng nhập OTP</h3>

                    <div id="step1">
                        <div class="mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" id="phoneNumber" class="form-control" placeholder="Ví dụ: 0987654321">
                        </div>
                        <div id="recaptcha-container"></div>

                        <button onclick="sendOTP()" class="btn btn-primary w-100 mt-2">Gửi mã xác thực</button>
                    </div>

                    <div id="step2" style="display: none;">
                        <div class="alert alert-success">Mã xác thực đã gửi đến SĐT của bạn!</div>
                        <div class="mb-3">
                            <label class="form-label">Nhập mã 6 số</label>
                            <input type="text" id="otpInput" class="form-control" placeholder="******">
                        </div>
                        <button onclick="verifyOTP()" class="btn btn-success w-100">Xác nhận</button>
                        <button onclick="location.reload()" class="btn btn-link w-100 mt-2">Gửi lại / Đổi SĐT</button>
                    </div>

                    <hr>
                    <div class="text-center">
                        <a href="login.jsp">Quay lại đăng nhập thường</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<form id="hiddenForm" action="login-phone" method="POST" style="display: none;">
    <input type="hidden" name="phone" id="hiddenPhone">
    <input type="hidden" name="idToken" id="hiddenToken">
</form>

<script type="module">
    import { initializeApp } from "https://www.gstatic.com/firebasejs/9.22.0/firebase-app.js";
    import { getAuth, RecaptchaVerifier, signInWithPhoneNumber }
        from "https://www.gstatic.com/firebasejs/9.22.0/firebase-auth.js";

    const firebaseConfig = {
        apiKey: "AIzaSyAmt5rE3Xk7WbvQsG4rxVNGBU4gJ_uMng0",
        authDomain: "webpj-73240.firebaseapp.com",
        projectId: "webpj-73240",
        storageBucket: "webpj-73240.firebasestorage.app",
        messagingSenderId: "1031518097189",
        appId: "1:1031518097189:web:6167baa849abf6161914cc",
        measurementId: "G-Q6PCC0WG8F"
    };

    const app = initializeApp(firebaseConfig);
    const auth = getAuth(app);

    auth.languageCode = 'vi';

    window.setupRecaptcha = () => {
        if (!window.recaptchaVerifier) {
            window.recaptchaVerifier = new RecaptchaVerifier(auth, 'recaptcha-container', {
                'size': 'invisible'
            });
        }
    };


    window.sendOTP = () => {
        setupRecaptcha();
        let phoneNumber = document.getElementById('phoneNumber').value;

        if (phoneNumber.startsWith('0')) {
            phoneNumber = '+84' + phoneNumber.substring(1);
        }

        const appVerifier = window.recaptchaVerifier;

        signInWithPhoneNumber(auth, phoneNumber, appVerifier)
            .then((confirmationResult) => {
                window.confirmationResult = confirmationResult;

                document.getElementById('step1').style.display = 'none';
                document.getElementById('step2').style.display = 'block';
            }).catch((error) => {
            console.log(error);
            alert("Lỗi gửi tin nhắn: " + error.message);
            if(window.recaptchaVerifier) window.recaptchaVerifier.clear();
        });
    };

    // HÀM XÁC THỰC OTP
    window.verifyOTP = () => {
        const code = document.getElementById('otpInput').value;

        window.confirmationResult.confirm(code).then((result) => {
            const user = result.user;

            document.getElementById('hiddenPhone').value = user.phoneNumber; // Dạng +84...

            user.getIdToken().then((token) => {
                document.getElementById('hiddenToken').value = token;
                document.getElementById('hiddenForm').submit();
            });

        }).catch((error) => {
            alert("Mã xác thực không đúng!");
        });
    };
</script>

</body>
</html>