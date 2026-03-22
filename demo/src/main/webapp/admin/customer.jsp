<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Khách hàng</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <style>
        body {
            background-color: #f8f9fa;
        }
        .avatar-initial {
            width: 35px;
            height: 35px;
            background-color: #e9ecef;
            color: #495057;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="d-flex" id="wrapper">

    <div class="border-end bg-white" id="sidebar-wrapper" style="min-height: 100vh;">
        <jsp:include page="sidebar.jsp"/>
    </div>

    <div id="page-content-wrapper" class="w-100">

        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm px-4 py-3">
            <div class="container-fluid">
                <h4 class="mb-0 text-primary fw-bold">Dashboard</h4>
                <div class="ms-auto d-flex align-items-center">
                    <span class="me-3 text-secondary">Xin chào, <strong>Admin!</strong></span>
                    <div class="rounded-circle bg-light d-flex justify-content-center align-items-center" style="width: 40px; height: 40px;">
                        <i class="fa-regular fa-user text-primary"></i>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container-fluid px-4 mt-4">

            <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
                <h3 class="mb-0 text-secondary">Danh sách Khách hàng</h3>

                <div class="input-group" style="width: 300px;">
                    <span class="input-group-text bg-white border-end-0">
                        <i class="fa-solid fa-magnifying-glass text-muted"></i>
                    </span>
                    <input type="text" class="form-control border-start-0 ps-0" placeholder="Tìm theo Tên hoặc Email...">
                    <button class="btn btn-primary" type="button">Tìm</button>
                </div>
            </div>

            <div class="card shadow border-0 rounded-3">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped align-middle mb-0">
                            <thead class="bg-light text-secondary">
                            <tr>
                                <th class="py-3 ps-4">ID</th>
                                <th class="py-3">Họ tên</th>
                                <th class="py-3">Email</th>
                                <th class="py-3">SĐT</th>
                                <th class="py-3 text-center">Đơn hàng</th>
                                <th class="py-3 text-center">Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${userList}" var="u">
                                <tr>
                                    <td class="ps-4 fw-bold text-muted">#${u.id}</td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-initial me-2 text-uppercase">
                                                    ${fn:substring(u.fullName, 0, 1)}
                                            </div>
                                            <span class="fw-bold text-dark">${u.fullName}</span>
                                        </div>
                                    </td>
                                    <td>${u.email}</td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty u.phone}">${u.phone}</c:when>
                                            <c:otherwise><span class="text-muted fst-italic">Chưa cập nhật</span></c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="text-center">
                                        <span class="badge bg-info text-dark bg-opacity-25 border border-info px-3">0 đơn</span>
                                    </td>

                                    <td class="text-center">
                                        <button class="btn btn-sm btn-outline-primary me-1" title="Xem chi tiết">
                                            <i class="fa-solid fa-eye"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" title="Khóa tài khoản"
                                                onclick="return confirm('Bạn có chắc muốn khóa khách hàng này?');">
                                            <i class="fa-solid fa-lock"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty userList}">
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">
                                        <i class="fa-solid fa-box-open fs-3 mb-2 d-block"></i>
                                        Không tìm thấy khách hàng nào!
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="card-footer bg-white py-3">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-end mb-0">
                            <li class="page-item disabled"><a class="page-link" href="#">Trước</a></li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">Sau</a></li>
                        </ul>
                    </nav>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>