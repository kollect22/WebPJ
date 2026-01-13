<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>



    <style>
        body {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

<div class="d-flex" id="wrapper">

    <jsp:include page="sidebar.jsp"/>

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

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="mb-0 text-secondary">Danh sách Đơn hàng</h3>
                <button class="btn btn-outline-success btn-sm"><i class="fa-solid fa-file-excel"></i> Xuất Excel</button>
            </div>

            <div class="card shadow border-0 rounded-3">
                <div class="card-body p-0">

                    <div class="table-responsive">
                        <table class="table table-hover table-striped align-middle mb-0" style="min-width: 900px;">
                            <thead class="bg-light text-secondary">
                            <tr>
                                <th class="py-3 ps-4">Mã Đơn</th>
                                <th class="py-3">Khách hàng</th>
                                <th class="py-3">Ngày đặt</th>
                                <th class="py-3">Tổng tiền</th>
                                <th class="py-3">Trạng thái</th>
                                <th class="py-3 text-center">Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="ps-4 fw-bold text-primary">#1004</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-sm me-2 bg-secondary-subtle rounded-circle d-flex justify-content-center align-items-center" style="width:30px;height:30px">
                                            <i class="fa-solid fa-user text-secondary" style="font-size: 12px"></i>
                                        </div>
                                        <span>Phạm Văn F</span>
                                    </div>
                                </td>
                                <td>19/11/2025</td>
                                <td class="fw-bold">680.000 VNĐ</td>
                                <td>
                                    <span class="badge bg-warning text-dark bg-opacity-75 px-3 py-2 rounded-pill">
                                        <i class="fa-solid fa-clock me-1"></i> Chờ xử lý
                                    </span>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary" title="Xem chi tiết">
                                        <i class="fa-solid fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-primary ms-1">
                                        <i class="fa-solid fa-check"></i> Xác nhận
                                    </button>
                                </td>
                            </tr>

                            <tr>
                                <td class="ps-4 fw-bold text-primary">#1003</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-sm me-2 bg-secondary-subtle rounded-circle d-flex justify-content-center align-items-center" style="width:30px;height:30px">
                                            <i class="fa-solid fa-user text-secondary" style="font-size: 12px"></i>
                                        </div>
                                        <span>Trần Đình C</span>
                                    </div>
                                </td>
                                <td>18/11/2025</td>
                                <td class="fw-bold">800.000 VNĐ</td>
                                <td>
                                    <span class="badge bg-success px-3 py-2 rounded-pill">
                                        <i class="fa-solid fa-check-circle me-1"></i> Đã hoàn thành
                                    </span>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary" title="Xem chi tiết">
                                        <i class="fa-solid fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div> </div>

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