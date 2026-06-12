<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đơn hàng của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        body { background-color: #f8f9fa; }
        .list-group-item.active { background-color: #0d6efd !important; border-color: #0d6efd !important; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<div class="d-flex">
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
                <a href="${pageContext.request.contextPath}/user/profile.jsp" class="list-group-item list-group-item-action text-muted">
                    <i class="fa-regular fa-user me-2"></i> Thông tin tài khoản
                </a>

                <a href="${pageContext.request.contextPath}/my-orders" class="list-group-item list-group-item-action active text-white fw-bold" aria-current="true">
                    <i class="fa-solid fa-box me-2"></i> Đơn hàng của tôi
                </a>

                <a href="${pageContext.request.contextPath}/wishlist-add" class="list-group-item list-group-item-action text-muted">
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
                <h4 class="mb-4 fw-bold text-black">Lịch sử đặt hàng</h4>

                <div class="table-responsive">
                    <table class="table align-middle table-hover">
                        <thead>
                            <tr class="table-light">
                                <th>Mã đơn hàng</th>
                                <th>Tổng thanh toán</th>
                                <th class="text-center">Phương thức</th>
                                <th class="text-center">Trạng thái</th>
                                <th class="text-end">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty orders}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-5">
                                            <i class="fa-regular fa-folder-open d-block fs-2 mb-2 text-secondary"></i>
                                            Bạn chưa có đơn hàng nào được đặt.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${orders}" var="o">
                                        <tr>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/order-detail?id=${o.orderIdCode}" class="fw-bold text-decoration-none text-primary">
                                                    #${o.orderIdCode}
                                                </a>
                                            </td>
                                            <td class="fw-bold text-danger">
                                                <fmt:formatNumber value="${o.totalPrice}" pattern="#,###"/>đ
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-light text-dark border px-2 py-1.5">${o.paymentMethod}</span>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${o.status == 0}">
                                                        <span class="badge bg-warning text-dark px-2 py-1.5 rounded-pill">Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 1}">
                                                        <span class="badge bg-success px-2 py-1.5 rounded-pill">Đã thanh toán</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary px-2 py-1.5 rounded-pill">Đã hủy</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end">
                                                <a href="${pageContext.request.contextPath}/order-detail?id=${o.orderIdCode}" class="btn btn-dark btn-sm rounded-pill px-3">
                                                    Xem chi tiết
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<div class="mt-auto w-100">
    <jsp:include page="/footer.jsp"></jsp:include>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>