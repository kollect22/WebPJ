<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đơn hàng của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<jsp:include page="/header.jsp" />

<div class="container">
    <nav aria-label="breadcrumb" class="bg-white p-3 rounded shadow-sm mb-4" style="margin-top: 100px">
        <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/index.jsp" class="text-decoration-none text-black">
                    <i class="fa-solid fa-house"></i> Trang chủ
                </a>
            </li>
            <li class="breadcrumb-item active">
                <a href="#" class="text-decoration-none text-black fw-bold">Đơn hàng của tôi</a>
            </li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-lg-3 mb-4">
            <div class="list-group shadow-sm">
                <a href="${pageContext.request.contextPath}/user/profile.jsp" class="list-group-item list-group-item-action text-muted">
                    <i class="fa-regular fa-user me-2"></i> Thông tin tài khoản
                </a>

                <a href="${pageContext.request.contextPath}/my-orders" class="list-group-item list-group-item-action active text-white fw-bold bg-primary border-primary">
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
                <h4 class="mb-4 fw-bold text-black border-bottom pb-3">Lịch sử đơn hàng</h4>

                <c:choose>
                    <c:when test="${empty orders}">
                        <div class="text-center py-5">
                            <i class="fa-solid fa-box-open fa-4x text-light mb-3"></i>
                            <p class="text-muted fs-5">Bạn chưa có đơn hàng nào.</p>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-dark px-4 py-2 fw-bold">Tiếp tục mua sắm</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th class="py-3">Mã đơn</th>
                                        <th class="py-3">Ngày đặt</th>
                                        <th class="py-3 text-center">Trạng thái</th>
                                        <th class="py-3">Thanh toán</th>
                                        <th class="py-3 text-end">Tổng tiền</th>
                                        <th class="py-3 text-center">Chi tiết</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${orders}" var="o">
                                    <tr>
                                        <td class="fw-bold text-primary">#${o.orderIdCode}</td>
                                        <td class="text-muted small">${o.createdAt}</td>

                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${o.status == 0}">
                                                    <span class="badge bg-warning text-dark">Chờ xử lý</span>
                                                </c:when>
                                                <c:when test="${o.status == 1}">
                                                    <span class="badge bg-success">Đã thanh toán</span>
                                                </c:when>
                                                <c:when test="${o.status == 2}">
                                                    <span class="badge bg-danger">Đã hủy</span>
                                                </c:when>
                                            </c:choose>
                                        </td>

                                        <td><span class="text-muted small">${o.paymentMethod}</span></td>
                                        <td class="text-end fw-bold text-danger">
                                            <fmt:formatNumber value="${o.totalPrice}" pattern="#,###"/> đ
                                        </td>

                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/order-detail?id=${o.orderIdCode}"
                                               class="btn btn-sm btn-outline-dark" title="Xem chi tiết">
                                                <i class="fa-solid fa-eye"></i>
                                            </a>

                                            <c:if test="${o.status == 0}">
                                                <button type="button" class="btn btn-sm btn-outline-danger ms-1"
                                                        data-bs-toggle="modal" data-bs-target="#cancelModal_${o.id}" title="Hủy đơn hàng">
                                                    <i class="fa-solid fa-ban"></i>
                                                </button>
                                            </c:if>
                                        </td>
                                    </tr>

                                    <c:if test="${o.status == 0}">
                                        <div class="modal fade" id="cancelModal_${o.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content text-start">
                                                    <form action="${pageContext.request.contextPath}/cancel-order" method="POST">
                                                        <div class="modal-header bg-danger text-white">
                                                            <h5 class="modal-title"><i class="fa-solid fa-triangle-exclamation me-2"></i>Xác nhận hủy đơn</h5>
                                                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <input type="hidden" name="orderId" value="${o.id}">
                                                            <p>Bạn có chắc chắn muốn hủy đơn hàng <strong class="text-danger">#${o.orderIdCode}</strong> không?</p>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Lý do hủy đơn (Bắt buộc):</label>
                                                                <textarea class="form-control" name="cancelReason" rows="3" placeholder="Vui lòng cho chúng tôi biết lý do..." required></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                            <button type="submit" class="btn btn-danger">Xác nhận hủy</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<div class="mt-auto w-100">
    <jsp:include page="/footer.jsp" />
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>