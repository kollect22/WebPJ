<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background:#f5f5f5;
            margin:0;
            padding:0;
            display: flex;
            min-height: 100vh;
            flex-direction: column;
            padding-top: 80px;
        }
        .main-content{
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .outer-box {
            background: #fff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            padding: 20px 30px 35px;
            width: 420px;
        }
        .form-container {
            max-width:420px;
            margin:60px auto;
            padding:20px;
        }
        .tab {
            display:flex;
            justify-content:center;
            margin-bottom:30px;
            border-bottom:1px solid #ddd;
        }
        .tab button {
            flex:1;
            padding:12px;
            font-size:18px;
            border:0;
            background:none;
            cursor:pointer;
        }
        .tab button.active {
            border-bottom:2px solid #000;
            font-weight:bold;
        }
        .input-box {
            margin-bottom:12px;
        }
        .input-box input {
            width:320px;
            padding:12px;
            border:1px solid #ccc;
            border-radius:4px;
            font-size:15px;
        }
        .link {
            font-size:14px;
            color:#007bff;
            cursor:pointer;
            display:inline-block;
            margin-bottom:10px;
        }
        .btn-block {
            width:100%;
            padding:12px;
            background:#000;
            color:#fff;
            border:0;
            border-radius:4px;
            font-size:16px;
            cursor:pointer;
            margin-top:8px;
        }
        .center-text {
            text-align:center;
            margin-top:15px;
            font-size:14px;
        }
        .error-msg {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
<div id="header-placeholder"></div>
<div class="main-content">
    <div class="outer-box">
        <div class="form-container">
            <div class="tab">
                <button id="tabLogin" class="active" onclick="showForm('loginForm')">Đăng nhập</button>
                <button id="tabRegister" onclick="showForm('registerForm')">Đăng ký</button>
            </div>

            <div class="error-msg">${error}</div>

            <form id="loginForm" action="login" method="POST">
                <div class="input-box">
                    <input type="text" name="username" placeholder="Email" value="">
                </div>
                <div class="input-box">
                    <input type="password" name="password" placeholder="Mật khẩu" required>
                </div>

                <a class="link">Bạn quên mật khẩu?</a>
                <button type="submit" class="btn-block">Đăng nhập</button>

                <div class="center-text">
                    Bạn chưa có tài khoản?
                    <span class="link" onclick="showForm('registerForm')">Đăng ký ngay</span>
                </div>
            </form>

            <form id="registerForm" action="register-servlet" method="POST" style="display:none;">
                <div class="input-box">
                    <input type="text" name="fullName" placeholder="Họ tên" required>
                </div>
                <div class="input-box">
                    <input type="text" name="email" placeholder="Email hoặc SĐT" required>
                </div>
                <div class="input-box">
                    <input type="password" name="password" placeholder="Mật khẩu" required>
                </div>

                <button type="submit" class="btn-block">Đăng ký</button>

                <div class="center-text">
                    Đã có tài khoản?
                    <span class="link" onclick="showForm('loginForm')">Đăng nhập</span>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Chỉ giữ lại logic chuyển đổi giao diện (UI)
    function showForm(form) {
        document.getElementById('loginForm').style.display = form === 'loginForm' ? 'block' : 'none';
        document.getElementById('registerForm').style.display = form === 'registerForm' ? 'block' : 'none';
        document.getElementById('tabLogin').classList.toggle('active', form === 'loginForm');
        document.getElementById('tabRegister').classList.toggle('active', form === 'registerForm');
    }
</script>
</body>
</html>