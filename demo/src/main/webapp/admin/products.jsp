<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin-products</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">

</head>
<style>
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(2px);
    }

    .modal-content {
        background-color: #ffffff;
        margin: 5% auto;
        padding: 30px;
        border-radius: 10px;
        width: 100%;
        max-width: 500px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        position: relative;
        animation: slideDown 0.3s ease-out;
    }

    @keyframes slideDown {
        from { transform: translateY(-50px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }

    .close-btn {
        position: absolute;
        top: 15px;
        right: 20px;
        font-size: 28px;
        font-weight: bold;
        color: #aaa;
        cursor: pointer;
        transition: color 0.2s;
    }
    .close-btn:hover {
        color: #dc3545;
    }

    .modal-content h2 {
        margin-top: 0;
        margin-bottom: 20px;
        color: #007bff;
        text-align: center;
        font-size: 22px;
        text-transform: uppercase;
    }

    .form-group {
        margin-bottom: 20px;
    }
    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #333;
    }
    .form-group input,
    .form-group select {
        width: 100%;
        padding: 10px 12px;
        border: 1px solid #ced4da;
        border-radius: 6px;
        font-size: 14px;
        color: #495057;
        background-color: #fff;
        transition: border-color 0.2s, box-shadow 0.2s;
    }

    .form-group input:focus,
    .form-group select:focus {
        border-color: #80bdff;
        outline: 0;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }

    .modal-content .btn-primary {
        width: 100%;
        padding: 12px;
        font-size: 16px;
        margin-top: 10px;
        border-radius: 6px;
    }
</style>
<body>
<div id="admin-page">
    <jsp:include page="sidebar.jsp"/>
    <main id="main">
        <header id="admin-header">
            <h1>Dashboard</h1>
            <div class="admin-info">
                <span>Xin chào, Admin!</span>
                <i class="fa-slab fa-regular fa-user"></i>
            </div>
        </header>
        <div class="module-header">
            <h2>Danh sách Sản phẩm</h2>
            <button class="admin-btn btn-primary"><i class="fa-solid fa-plus"></i> Thêm Sản phẩm mới</button>
        </div>
        <div class="table-container">
            <table class="admin-table">
                <thead>
                <tr>
                    <th>Ảnh</th>
                    <th>Tên Sản phẩm</th>
                    <th>Mã SKU</th>
                    <th>Giá</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${productList}" var="p">
                    <tr>
                        <td>
                            <img src="${pageContext.request.contextPath}/${p.img}"
                                 alt="${p.name}" class="thumb"
                                 onerror="this.src='https://placehold.co/50x50?text=No+Img'">
                        </td>

                        <td>${p.name}</td>

                        <td>SP-${p.id}</td>

                        <td>
                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ"/>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${p.price > 0}">
                                    <span class="badge badge-success">Còn hàng</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-danger">Hết hàng</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <a href="${pageContext.request.contextPath}/admin/product-edit?id=${p.id}" class="btn-action">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </a>

                            <button class="btn-action" onclick="confirmDelete(${p.id})">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>
<div id="addProductModal" class="modal">
    <div class="modal-content">
        <span class="close-btn">&times;</span>
        <h2>Thêm Sản Phẩm Mới</h2>
        <form id="addProductForm">
            <div class="form-group">
                <label for="prodName">Tên sản phẩm</label>
                <input type="text" id="prodName" required placeholder="Nhập tên sản phẩm...">
            </div>
            <div class="form-group">
                <label for="prodSKU">Mã SKU</label>
                <input type="text" id="prodSKU" required placeholder="Ví dụ: SP001">
            </div>
            <div class="form-group">
                <label for="prodPrice">Giá (VNĐ)</label>
                <input type="number" id="prodPrice" required placeholder="Ví dụ: 100000">
            </div>
            <div class="form-group">
                <label for="prodImg">Link Ảnh (URL)</label>
                <input type="text" id="prodImg" placeholder="Dán link ảnh hoặc để trống">
            </div>
            <div class="form-group">
                <label for="prodStatus">Trạng thái</label>
                <select id="prodStatus">
                    <option value="success">Còn hàng</option>
                    <option value="danger">Hết hàng</option>
                </select>
            </div>
            <button type="submit" class="admin-btn btn-primary" style="width: 100%; margin-top: 10px;">Lưu Sản Phẩm</button>
        </form>
    </div>
</div>
</body>
<script>
        // 1. Khai báo các biến
        const modal = document.getElementById("addProductModal");
        const btnOpen = document.querySelector(".btn-primary");
        const btnClose = document.querySelector(".close-btn");
        const form = document.getElementById("addProductForm");
        const tableBody = document.querySelector(".admin-table tbody");

        // 2. Mở Modal khi nhấn nút Thêm
        btnOpen.addEventListener("click", function() {
        modal.style.display = "block";
    });

        // 3. Đóng Modal khi nhấn nút X
        btnClose.addEventListener("click", function() {
        modal.style.display = "none";
    });

        // 4. Đóng Modal khi click ra ngoài vùng content
        window.addEventListener("click", function(event) {
        if (event.target == modal) {
        modal.style.display = "none";
    }
    });

        // 5. Xử lý khi Submit Form
        form.addEventListener("submit", function(e) {
        e.preventDefault();

        // Lấy dữ liệu từ input
        const name = document.getElementById("prodName").value;
        const sku = document.getElementById("prodSKU").value;
        const price = document.getElementById("prodPrice").value;
        const imgUrl = document.getElementById("prodImg").value || 'https://via.placeholder.com/50'; // Ảnh mặc định nếu trống
        const statusValue = document.getElementById("prodStatus").value;

        // Xác định text và class cho trạng thái
        let statusText = statusValue === 'success' ? 'Còn hàng' : 'Hết hàng';
        let badgeClass = statusValue === 'success' ? 'badge-success' : 'badge-danger';

        // Định dạng giá tiền
        const formattedPrice = new Intl.NumberFormat('vi-VN').format(price) + ' VNĐ';

        // Tạo dòng HTML mới
        const newRow = `
            <tr>
                <td><img src="${imgUrl}" alt="${name}" class="thumb"></td>
                <td>${name}</td>
                <td>${sku}</td>
                <td>${formattedPrice}</td>
                <td><span class="badge ${badgeClass}">${statusText}</span></td>
                <td>
                    <button class="btn-action"><i class="fa-solid fa-pen-to-square"></i></button>
                    <button class="btn-action"><i class="fa-solid fa-trash"></i></button>
                </td>
            </tr>
        `;

        // Chèn vào đầu bảng
        tableBody.insertAdjacentHTML('afterbegin', newRow);

        // Reset form và đóng modal
        form.reset();
        modal.style.display = "none";
        alert("Thêm sản phẩm thành công!");
    });

        // Gắn sự kiện click vào thẻ tbody
        tableBody.addEventListener("click", function(event) {
            const targetBtn = event.target.closest(".btn-action");

            if (!targetBtn) return;

            if (targetBtn.querySelector(".fa-trash")) {

                const isConfirmed = confirm("Bạn có chắc chắn muốn xóa sản phẩm này không?");

                if (isConfirmed) {
                    const rowToDelete = targetBtn.closest("tr");
                    rowToDelete.remove();
                }
            }
        });
</script>
</html>