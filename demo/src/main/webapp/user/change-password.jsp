<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Đổi mật khẩu - Fashion Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<div class="d-flex" >
    <jsp:include page="/header.jsp"></jsp:include>
</div>

<div class="container">
    <%-- Breadcrumbs --%>
    <nav aria-label="breadcrumb" class="bg-white p-3 rounded mb-4" style="margin-top: 100px">
        <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/index.jsp" class="text-decoration-none text-black">
                    <i class="fa-solid fa-house"></i> Trang chủ
                </a>
            </li>
            <li class="breadcrumb-item active">
                <a href="#" class="text-decoration-none text-black fw-bold">Đổi mật khẩu</a>
            </li>
        </ol>
    </nav>

    <div class="row">
        <%-- Cột bên trái: Menu điều hướng --%>
        <div class="col-lg-3 mb-4">
            <div class="list-group shadow-sm">
                <a href="${pageContext.request.contextPath}/user/profile.jsp" class="list-group-item list-group-item-action text-muted">
                    <i class="fa-regular fa-user me-2"></i> Thông tin tài khoản
                </a>

                <a href="${pageContext.request.contextPath}/user/orders.jsp" class="list-group-item list-group-item-action text-muted">
                    <i class="fa-solid fa-box me-2"></i> Đơn hàng của tôi
                </a>

                <a href="${pageContext.request.contextPath}/wishlist" class="list-group-item list-group-item-action text-muted">
                    <i class="fa-regular fa-heart me-2"></i> Sản phẩm yêu thích
                </a>

                <%-- Đổi class active sang mục này --%>
                <a href="${pageContext.request.contextPath}/user/change-password.jsp" class="list-group-item list-group-item-action active text-white fw-bold" aria-current="true">
                    <i class="fa-solid fa-lock me-2"></i> Đổi mật khẩu
                </a>

                <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action text-danger mt-2 border-top">
                    <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                </a>
            </div>
        </div>

        <%-- Cột bên phải: Form đổi mật khẩu --%>
        <div class="col-lg-9 col-md-8">
            <div class="bg-white p-4 rounded shadow-sm">
                <h4 class="mb-4 fw-bold text-black">Đổi mật khẩu</h4>

                <%-- Vùng hiển thị thông báo lỗi hoặc thành công từ Controller --%>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger fw-bold"><i class="fa-solid fa-circle-exclamation me-2"></i>${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success fw-bold"><i class="fa-solid fa-circle-check me-2"></i>${success}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/user/change-password" method="POST">

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="oldPassword" class="form-label fw-bold">Mật khẩu hiện tại <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="oldPassword" name="oldPassword" placeholder="Nhập mật khẩu cũ" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="newPassword" class="form-label fw-bold">Mật khẩu mới <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)" required minlength="6">
                        </div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-12">
                            <label for="confirmPassword" class="form-label fw-bold">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
                        </div>
                    </div>

                    <hr class="mb-4">

                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-dark px-4 py-2 fw-bold">Cập nhật mật khẩu</button>
                    </div>

                </form>
            </div>
        </div>

    </div>
</div>

<div class="mt-auto w-100">
    <jsp:include page="/footer.jsp"></jsp:include>
</div>

</body>
</html>