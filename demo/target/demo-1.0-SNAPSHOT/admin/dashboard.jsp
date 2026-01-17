<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <style>
        body {
            background-color: #f8f9fa;
        }
        .stats-card {
            transition: transform 0.2s;
        }
        .stats-card:hover {
            transform: translateY(-5px);
        }
        .icon-box {
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            font-size: 1.5rem;
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

            <div class="row g-4 mb-4">

                <div class="col-12 col-md-6 col-xl-3">
                    <div class="card border-0 shadow-sm stats-card">
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <h6 class="text-muted mb-2">Doanh thu hôm nay</h6>
                                    <h5 class="fw-bold text-success mb-0">10.000.000 đ</h5>
                                </div>
                                <div class="icon-box bg-success bg-opacity-10 text-success">
                                    <i class="fa-solid fa-chart-line"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-xl-3">
                    <div class="card border-0 shadow-sm stats-card">
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <h6 class="text-muted mb-2">Đơn hàng mới</h6>
                                    <h5 class="fw-bold text-primary mb-0">12 đơn</h5>
                                </div>
                                <div class="icon-box bg-primary bg-opacity-10 text-primary">
                                    <i class="fa-solid fa-cart-shopping"></i> </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-xl-3">
                    <div class="card border-0 shadow-sm stats-card">
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <h6 class="text-muted mb-2">Tổng lợi nhuận</h6>
                                    <h5 class="fw-bold text-warning mb-0">100.000.000 đ</h5>
                                </div>
                                <div class="icon-box bg-warning bg-opacity-10 text-warning">
                                    <i class="fa-solid fa-coins"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-xl-3">
                    <div class="card border-0 shadow-sm stats-card">
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <h6 class="text-muted mb-2">Sản phẩm kho</h6>
                                    <h5 class="fw-bold text-info mb-0">340 SP</h5>
                                </div>
                                <div class="icon-box bg-info bg-opacity-10 text-info">
                                    <i class="fa-solid fa-box-open"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3 border-0">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 fw-bold text-secondary">Đơn hàng gần đây</h5>
                        <a href="orders" class="btn btn-sm btn-outline-primary">Xem tất cả</a>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light text-secondary">
                            <tr>
                                <th class="ps-4">Mã đơn</th>
                                <th>Khách hàng</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="ps-4 fw-bold text-primary">#1001</td>
                                <td>Nguyễn Văn A</td>
                                <td>20/11/2025</td>
                                <td>350.000 VNĐ</td>
                                <td>
                                    <span class="badge bg-warning text-dark bg-opacity-75">Chờ xử lý</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="ps-4 fw-bold text-primary">#1002</td>
                                <td>Lê Thị B</td>
                                <td>19/11/2025</td>
                                <td>1.250.000 VNĐ</td>
                                <td>
                                    <span class="badge bg-info text-dark bg-opacity-75">Đã giao</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="ps-4 fw-bold text-primary">#1003</td>
                                <td>Trần Đình C</td>
                                <td>18/11/2025</td>
                                <td>800.000 VNĐ</td>
                                <td>
                                    <span class="badge bg-success">Hoàn thành</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <footer class="mt-5 text-center text-muted small pb-3">
                &copy; 2026 Admin Shop System.
            </footer>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>