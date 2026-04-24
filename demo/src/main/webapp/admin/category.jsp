<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-light">
<div class="d-flex">

    <jsp:include page="sidebar.jsp"/>

    <div class="container-fluid px-4 mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="text-secondary"><i class="fa-solid fa-layer-group me-2"></i>Danh mục sản phẩm</h3>
            <button class="btn btn-primary">
                <i class="fa-solid fa-plus me-1"></i> Thêm danh mục
            </button>
        </div>

        <div class="card shadow border-0 rounded-3">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light">
                    <tr>
                        <th class="ps-4" style="width: 15%">Mã Danh Mục</th>
                        <th style="width: 65%">Tên danh mục</th>
                        <th class="text-center" style="width: 20%">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${categoryList}" var="c">
                        <tr>
                            <td class="ps-4 text-muted fw-bold">#${c.id}</td>
                            <td class="fw-bold text-primary">${c.name}</td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-info" title="Sửa"><i class="fa-solid fa-pen"></i></button>
                                <button class="btn btn-sm btn-outline-danger ms-1" title="Xóa"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>