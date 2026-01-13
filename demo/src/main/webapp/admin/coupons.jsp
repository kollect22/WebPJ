<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Mã Giảm Giá</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">

    <style>
        body { background-color: #f8f9fa; }
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
            <h3 class="mb-4 text-secondary">Quản lý Khuyến mãi</h3>

            <div class="row">

                <div class="col-md-4 mb-4">
                    <div class="card shadow border-0 rounded-3">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 text-primary fw-bold"><i class="fa-solid fa-plus-circle me-2"></i>Tạo Mã Mới</h5>
                        </div>
                        <div class="card-body">
                            <form id="create-coupon-form">
                                <div class="mb-3">
                                    <label for="coupon-code" class="form-label fw-bold">Mã Code</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa-solid fa-barcode"></i></span>
                                        <input type="text" class="form-control" id="coupon-code" placeholder="VD: SALE50" style="text-transform: uppercase;" required>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="coupon-type" class="form-label fw-bold">Loại giảm giá</label>
                                    <select class="form-select" id="coupon-type">
                                        <option value="percent">Giảm theo Phần trăm (%)</option>
                                        <option value="amount">Giảm theo Số tiền (VNĐ)</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label for="coupon-value" class="form-label fw-bold">Giá trị giảm</label>
                                    <input type="number" class="form-control" id="coupon-value" placeholder="Nhập số..." required>
                                </div>

                                <button type="submit" class="btn btn-primary w-100 fw-bold">
                                    <i class="fa-solid fa-save me-2"></i> Lưu Mã
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-md-8 mb-4">
                    <div class="card shadow border-0 rounded-3">
                        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                            <h5 class="mb-0 text-secondary fw-bold">Danh sách Mã hiện có</h5>
                            <span class="badge bg-primary rounded-pill">Total: 2</span>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover table-striped align-middle mb-0">
                                    <thead class="bg-light text-secondary">
                                    <tr>
                                        <th class="py-3 ps-4">Mã Code</th>
                                        <th class="py-3">Loại</th>
                                        <th class="py-3">Giá trị</th>
                                        <th class="py-3">Trạng thái</th>
                                        <th class="py-3 text-center">Hành động</th>
                                    </tr>
                                    </thead>
                                    <tbody id="coupon-table-body">
                                    <tr>
                                        <td class="ps-4 fw-bold text-primary">WINTER10</td>
                                        <td>Phần trăm</td>
                                        <td class="fw-bold">10%</td>
                                        <td><span class="badge bg-success bg-opacity-75">Hoạt động</span></td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-outline-primary me-1"><i class="fa-solid fa-pen-to-square"></i></button>
                                            <button class="btn btn-sm btn-outline-danger delete-btn"><i class="fa-solid fa-trash"></i></button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ps-4 fw-bold text-dark">FREESHIP</td>
                                        <td>Miễn phí vận chuyển</td>
                                        <td class="fw-bold">0 đ</td>
                                        <td><span class="badge bg-danger bg-opacity-75">Hết hạn</span></td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-outline-primary me-1"><i class="fa-solid fa-pen-to-square"></i></button>
                                            <button class="btn btn-sm btn-outline-danger delete-btn"><i class="fa-solid fa-trash"></i></button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div> </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.getElementById('create-coupon-form').addEventListener('submit', function(e) {
        e.preventDefault();

        const code = document.getElementById('coupon-code').value.toUpperCase();
        const type = document.getElementById('coupon-type').value;
        const valueInput = document.getElementById('coupon-value').value;

        let displayType = '';
        let displayValue = '';

        if (type === 'percent') {
            displayType = 'Phần trăm';
            displayValue = valueInput + '%';
        } else {
            displayType = 'Số tiền';
            displayValue = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(valueInput);
        }

        const newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td class="ps-4 fw-bold text-primary">${code}</td>
            <td>${displayType}</td>
            <td class="fw-bold">${displayValue}</td>
            <td><span class="badge bg-success bg-opacity-75">Hoạt động</span></td>
            <td class="text-center">
                <button class="btn btn-sm btn-outline-primary me-1"><i class="fa-solid fa-pen-to-square"></i></button>
                <button class="btn btn-sm btn-outline-danger delete-btn"><i class="fa-solid fa-trash"></i></button>
            </td>
        `;

        newRow.classList.add('table-success');

        const tableBody = document.getElementById('coupon-table-body');
        tableBody.prepend(newRow);

        setTimeout(() => newRow.classList.remove('table-success'), 1000);

        this.reset();
        document.getElementById('coupon-code').focus();
    });

    document.getElementById('coupon-table-body').addEventListener('click', function(e) {
        const btn = e.target.closest('.delete-btn');

        if (btn) {
            if(confirm('Bạn có chắc muốn xóa mã giảm giá này không?')) {
                const row = btn.closest('tr');
                row.remove();
            }
        }
    });
</script>

</body>
</html>