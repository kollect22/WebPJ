<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập / Đăng ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .outer-box {
            background: #fff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            width: 450px;
            padding: 30px;
        }
        .tab-buttons {
            display: flex;
            border-bottom: 1px solid #ddd;
            margin-bottom: 25px;
        }
        .tab-buttons button {
            flex: 1;
            padding: 12px;
            font-size: 18px;
            border: none;
            background: none;
            cursor: pointer;
            font-weight: 500;
            color: #777;
        }
        .tab-buttons button.active {
            border-bottom: 3px solid #000;
            color: #000;
            font-weight: bold;
        }
        .form-control {
            padding: 12px;
            margin-bottom: 15px;
        }
        .btn-black {
            background: #000;
            color: #fff;
            padding: 12px;
            width: 100%;
            border: none;
            font-weight: bold;
            margin-top: 10px;
        }
        .btn-black:hover {
            background: #333;
            color: #fff;
        }
        .btn-social {
            position: relative;
            padding: 10px;
            border: none;
            color: white;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: 0.3s;
        }
        .btn-google {
            background-color: #db4437;
        }
        .btn-google:hover {
            background-color: #c53929;
        }

        .btn-facebook {
            background-color: #4267B2;
        }
        .btn-facebook:hover {
            background-color: #365899;
        }

        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 20px 0;
            color: #888;
            font-size: 14px;
        }
        .divider::before, .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #ddd;
        }
        .divider span {
            padding: 0 10px;
        }

        .link {
            color: #007bff;
            cursor: pointer;
            text-decoration: none;
        }
        .link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div id="header-placeholder"></div>

<div class="outer-box">
    <div class="tab-buttons">
        <button id="tabLogin" class="active" onclick="showForm('loginForm')">Đăng nhập</button>
        <button id="tabRegister" onclick="showForm('registerForm')">Đăng ký</button>
    </div>

    <div class="text-danger text-center mb-3 fw-bold">${error}</div>
    <div class="text-success text-center mb-3 fw-bold">${mess}</div>

    <div id="loginForm">
        <form action="login" method="POST">
            <input type="text" name="username" class="form-control" placeholder="Email hoặc SĐT" required>
            <input type="password" name="password" class="form-control" placeholder="Mật khẩu" required>

            <div class="text-end mb-3">
                <a href="forgot-password.jsp" class="link small">Quên mật khẩu?</a>
            </div>

            <button type="submit" class="btn btn-black rounded">ĐĂNG NHẬP</button>
        </form>

        <div class="divider"><span>hoặc đăng nhập bằng</span></div>

        <div class="d-grid gap-2">
            <button onclick="loginWithSocial('google')" class="btn btn-social btn-google rounded">
                <i class="fa-brands fa-google fa-lg me-2"></i> Google
            </button>
            <button onclick="loginWithSocial('facebook')" class="btn btn-social btn-facebook rounded">
                <i class="fa-brands fa-facebook-f fa-lg me-2"></i> Facebook
            </button>
        </div>

        <div class="text-center mt-3">
            Bạn chưa có tài khoản? <span class="link fw-bold" onclick="showForm('registerForm')">Đăng ký ngay</span>
        </div>
    </div>

    <div id="registerForm" style="display:none;">
        <form action="register" method="POST">
            <input type="text" name="fullName" class="form-control" placeholder="Họ và tên" required>
            <input type="text" name="username" class="form-control" placeholder="Email hoặc SĐT" required>
            <input type="password" name="password" class="form-control" placeholder="Mật khẩu" required>


            <button type="submit" class="btn btn-black rounded">ĐĂNG KÝ</button>
        </form>

        <div class="divider"><span>hoặc đăng ký nhanh</span></div>
        <div class="d-flex justify-content-center gap-3">
            <button onclick="loginWithSocial('google')" class="btn btn-outline-danger rounded-circle p-2" style="width: 45px; height: 45px;">
                <i class="fa-brands fa-google"></i>
            </button>
            <button onclick="loginWithSocial('facebook')" class="btn btn-outline-primary rounded-circle p-2" style="width: 45px; height: 45px;">
                <i class="fa-brands fa-facebook-f"></i>
            </button>
        </div>

        <div class="text-center mt-3">
            Đã có tài khoản? <span class="link fw-bold" onclick="showForm('loginForm')">Đăng nhập</span>
        </div>
    </div>
</div>
<form id="socialForm" action="login-social" method="POST" style="display: none;">
    <input type="hidden" name="token" id="socialToken">
</form>
<script>
    // Hàm chuyển đổi Tab
    function showForm(formId) {
        document.getElementById('loginForm').style.display = formId === 'loginForm' ? 'block' : 'none';
        document.getElementById('registerForm').style.display = formId === 'registerForm' ? 'block' : 'none';

        document.getElementById('tabLogin').className = formId === 'loginForm' ? 'active' : '';
        document.getElementById('tabRegister').className = formId === 'registerForm' ? 'active' : '';
    }
</script>

<script type="module">
    import { initializeApp } from "https://www.gstatic.com/firebasejs/9.22.0/firebase-app.js";
    import { getAuth, signInWithPopup, GoogleAuthProvider, FacebookAuthProvider }
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

    window.loginWithSocial = (type) => {
        let provider;
        if (type === 'google') provider = new GoogleAuthProvider();
        else if (type === 'facebook') provider = new FacebookAuthProvider();

        signInWithPopup(auth, provider)
            .then((result) => {
                const token = result.user.getIdToken();
                return token;
            })
            .then((token) => {
                console.log("Token nhận được: " + token);
                document.getElementById('socialToken').value = token;
                document.getElementById('socialForm').submit();;
            })
            .catch((error) => {
                console.error(error);
                alert("Lỗi đăng nhập: " + error.message);
            });
    };
</script>

</body>
</html>