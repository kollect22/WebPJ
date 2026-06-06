<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-light">

<div class="d-flex" id="wrapper">
    <jsp:include page="sidebar.jsp"/>

    <div id="page-content-wrapper" class="w-100">
        <div class="container-fluid px-4 mt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4>Chi tiết đơn hàng <span class="text-primary">#${order.orderIdCode}</span></h4>
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-arrow-left"></i> Quay lại
                </a>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-header bg-white fw-bold">Thông tin Khách hàng</div>
                        <div class="card-body">
                            <p><strong>Tên:</strong> ${order.fullName}</p>
                            <p><strong>SĐT:</strong> ${order.phone}</p>
                            <p><strong>Địa chỉ:</strong> ${order.address}</p>
                            <p><strong>Thanh toán:</strong> ${order.paymentMethod}</p>
                        </div>
                    </div>

                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white fw-bold">Cập nhật Trạng thái</div>
                        <div class="card-body">
                            <p>Trạng thái hiện tại:
                                <c:choose>
                                <c:when test="${order.status == 0}">
                                <span class="badge bg-warning text-dark">Chờ xử lý</span>
                                </c:when>
                                <c:when test="${order.status == 1}">
                                <span class="badge bg-success">Đã hoàn thành</span>
                                </c:when>
                                <c:otherwise>
                                <span class="badge bg-danger">Đã hủy</span>

                                <c:if test="${not empty order.cancelReason}">
                            <div class="alert alert-danger mt-2 py-2 px-3 small border-0" style="background-color: #ffe6e6;">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                <strong>Lý do khách hủy:</strong> ${order.cancelReason}
                            </div>
                            </c:if>

                            </c:otherwise>
                            </c:choose>
                            </p>
                            <form action="update-order-status" method="POST">
                                <input type="hidden" name="id" value="${order.id}">
                                <select name="status" class="form-select mb-3">
                                    <option value="0" ${order.status == 0 ? 'selected' : ''}>Chờ xử lý</option>
                                    <option value="1" ${order.status == 1 ? 'selected' : ''}>Đã hoàn thành</option>
                                    <option value="2" ${order.status == 2 ? 'selected' : ''}>Hủy đơn</option>
                                </select>
                                <button type="submit" class="btn btn-primary w-100">Lưu trạng thái</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="card shadow-sm border-0">
                        <div class="card-body">
                            <table class="table">
                                <thead class="table-light">
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>Số lượng</th>
                                    <th>Đơn giá</th>
                                    <th class="text-end">Thành tiền</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${orderDetails}" var="item">
                                    <tr>
                                        <td>${item.productName}</td>
                                        <td>${item.quantity}</td>
                                        <td><fmt:formatNumber value="${item.price}" pattern="#,###"/> đ</td>
                                        <td class="text-end fw-bold text-danger">
                                            <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/> đ
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <h4 class="text-end mt-4">Tổng: <span class="text-danger"><fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/> đ</span></h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>