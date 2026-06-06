<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .card { border: none; box-shadow: 0 2px 15px rgba(0,0,0,0.05); border-radius: 12px; }
        .table th { background-color: #f8f9fa; border-bottom: 2px solid #dee2e6; }
    </style>
</head>
<body>

<%-- <jsp:include page="header.jsp"/> --%>

<div class="container py-5">
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/my-orders" class="text-decoration-none text-secondary">
            <i class="fa-solid fa-arrow-left me-2"></i>Quay lại danh sách đơn hàng
        </a>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold mb-0">Chi tiết đơn hàng: <span class="text-primary">#${order.orderIdCode}</span></h3>
        <c:choose>
            <c:when test="${order.status == 0}">
                <span class="badge bg-warning text-dark fs-6 px-3 py-2 rounded-pill">Đang chờ xử lý</span>
            </c:when>
            <c:when test="${order.status == 1}">
                <span class="badge bg-success fs-6 px-3 py-2 rounded-pill">Đã thanh toán</span>
            </c:when>
            <c:otherwise>
                <span class="badge bg-secondary fs-6 px-3 py-2 rounded-pill">Đã hủy</span>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="row g-4">
        <div class="col-lg-4">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title fw-bold border-bottom pb-3 mb-3">
                        <i class="fa-solid fa-location-dot me-2 text-danger"></i>Thông tin nhận hàng
                    </h5>
                    <p class="mb-2"><strong>Người nhận:</strong> ${order.fullName}</p>
                    <p class="mb-2"><strong>Điện thoại:</strong> ${order.phone}</p>
                    <p class="mb-2"><strong>Địa chỉ:</strong> ${order.address}</p>
                    <p class="mb-0"><strong>Phương thức:</strong>
                        <span class="fw-bold text-primary">${order.paymentMethod}</span>
                    </p>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title fw-bold border-bottom pb-3 mb-3">
                        <i class="fa-solid fa-box-open me-2 text-success"></i>Sản phẩm đã đặt
                    </h5>

                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th class="text-center">Đơn giá</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-end">Thành tiền</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${orderDetails}" var="item">
                                <tr>
                                    <td>
                                        <div class="fw-bold">${item.productName}</div>
                                    </td>
                                    <td class="text-center">
                                        <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                    </td>
                                    <td class="text-center">${item.quantity}</td>
                                    <td class="text-end fw-bold text-danger">
                                        <fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-end mt-4 pt-3 border-top">
                        <div class="text-end" style="width: 300px;">
                            <div class="d-flex justify-content-between mb-2 fs-5">
                                <span class="fw-bold">Tổng thanh toán:</span>
                                <span class="fw-bold text-danger">
                                    <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </span>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>