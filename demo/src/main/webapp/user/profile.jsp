<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body>
<div class="d-flex" >
    <jsp:include page="/header.jsp"></jsp:include>
</div>
<div class="container">
    <nav aria-label="breadcrumb" class="bg-white p-3 rounded mb-4" style="margin-top: 100px">
        <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/index.jsp" class="text-decoration-none text-black">
                    <i class="fa-solid fa-house"></i> Trang chủ
                </a>
            </li>

            <li class="breadcrumb-item active">
                <a href="#" class="text-decoration-none text-black fw-bold">Thông tin</a>
            </li>

        </ol>
    </nav>
    <div class="row">

        <div class="col-lg-3 mb-4">
            <div class="list-group shadow-sm">
                <a href="${pageContext.request.contextPath}/user/profile.jsp" class="list-group-item list-group-item-action active text-white fw-bold" aria-current="true">
                    <i class="fa-regular fa-user me-2"></i> Thông tin tài khoản
                </a>

                <a href="${pageContext.request.contextPath}/user/orders.jsp" class="list-group-item list-group-item-action text-muted">
                    <i class="fa-solid fa-box me-2"></i> Đơn hàng của tôi
                </a>

                <a href="${pageContext.request.contextPath}/wishlist" class="list-group-item list-group-item-action text-muted">
                    <i class="fa-regular fa-heart me-2"></i> Sản phẩm yêu thích
                </a>

                <a href="${pageContext.request.contextPath}/user/change-password.jsp" class="list-group-item list-group-item-action text-muted">
                    <i class="fa-solid fa-lock me-2"></i> Đổi mật khẩu
                </a>

                <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action text-danger mt-2 border-top">
                    <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                </a>
            </div>
        </div>

        <div class="col-lg-9 col-md-8">
            <div class="bg-white p-4 rounded shadow-sm">
                <h4 class="mb-4">Hồ sơ của tôi</h4>
                <p>Khung trắng này là nơi bạn sẽ đặt Form điền Tên, Email, Số điện thoại...</p>
            </div>
        </div>

    </div>
</div>

<div class="d-flex">
    <jsp:include page="/footer.jsp"></jsp:include>
</div>
</body>
</html>
