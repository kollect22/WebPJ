<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm yêu thích - Fashion Store</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

    <style>
        /* CSS Riêng cho trang Wishlist */
        .wishlist-page {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            min-height: 400px; /* Để footer không bị nhảy lên giữa màn hình nếu trống */
        }

        h2 {
            margin-bottom: 30px;
            text-align: center;
            text-transform: uppercase;
            font-size: 24px;
        }

        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 25px;
        }

        /* Tận dụng lại class .product-item của style.css nhưng chỉnh sửa chút */
        .wishlist-item {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 5px;
            padding: 15px;
            text-align: center;
            position: relative;
            transition: box-shadow 0.3s;
        }

        .wishlist-item:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .wishlist-item img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 15px;
        }

        .wishlist-item h3 {
            font-size: 16px;
            margin: 10px 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .wishlist-item .price {
            font-weight: bold;
            color: #d0021b;
            margin-bottom: 15px;
            font-size: 15px;
        }

        .wishlist-actions {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        .wishlist-btn {
            padding: 10px;
            border: none;
            cursor: pointer;
            font-size: 13px;
            border-radius: 3px;
            font-weight: bold;
            transition: 0.2s;
        }

        .btn-add-cart {
            background: #000;
            color: #fff;
        }
        .btn-add-cart:hover {
            background-color: #333;
        }

        .btn-remove {
            background: #eee;
            color: #333;
        }
        .btn-remove:hover {
            background: #ddd;
        }

        /* Nút xóa nhanh góc trên */
        .remove-icon-corner {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 30px;
            height: 30px;
            background: rgba(255,255,255,0.8);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: #666;
            transition: 0.2s;
        }
        .remove-icon-corner:hover {
            color: red;
            background: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .empty-state {
            text-align: center;
            padding: 50px 0;
            display: none; /* Mặc định ẩn */
        }
        .empty-state i {
            font-size: 50px;
            color: #ccc;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<%-- 1. LOAD HEADER --%>
<jsp:include page="header.jsp" />

<div class="wishlist-page">
    <h2><i class="fa-solid fa-heart" style="color: #d0021b;"></i> Sản phẩm yêu thích</h2>

    <div id="wishlist-grid" class="wishlist-grid">
    </div>

    <%-- Thông báo khi trống --%>
    <div id="empty-msg" class="empty-state">
        <i class="fa-regular fa-heart"></i>
        <p>Bạn chưa có sản phẩm yêu thích nào.</p>
        <a href="${pageContext.request.contextPath}/home" style="color: blue; text-decoration: underline;">Quay lại mua sắm</a>
    </div>
</div>

<%-- 2. LOAD FOOTER --%>
<jsp:include page="footer.jsp" />

<%-- Khai báo contextPath --%>
<script>
    window.contextPath = '${pageContext.request.contextPath}';
</script>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

<script>
    /* ================================
       LOGIC HIỂN THỊ WISHLIST
    ================================ */

    // Hàm format tiền tệ VNĐ
    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
    }

    function renderWishlistPage() {
        // Lấy dữ liệu từ LocalStorage
        const wishlist = JSON.parse(localStorage.getItem("wishlist")) || [];
        const grid = document.getElementById("wishlist-grid");
        const empty = document.getElementById("empty-msg");

        grid.innerHTML = "";

        // Nếu trống thì hiện thông báo
        if (wishlist.length === 0) {
            empty.style.display = "block";
            grid.style.display = "none";
            return;
        }

        empty.style.display = "none";
        grid.style.display = "grid";

        // Duyệt qua từng sản phẩm và vẽ HTML
        wishlist.forEach(item => {
            // Lưu ý: item.img, item.name, item.price phải được lưu lúc bấm tim
            grid.innerHTML += `
            <div class="wishlist-item">
                <div class="remove-icon-corner" onclick="removeItemFromWishlist(${item.id})" title="Xóa">
                    <i class="fa-solid fa-xmark"></i>
                </div>

                <a href="detail?id=${item.id}">
                    <img src="${item.img}" alt="${item.name}">
                </a>

                <h3><a href="detail?id=${item.id}" style="text-decoration:none; color:inherit;">${item.name}</a></h3>

                <div class="price">${formatCurrency(item.price)}</div>

                <div class="wishlist-actions">
                    <button class="wishlist-btn btn-add-cart" onclick="addToCart(${item.id})">
                        <i class="fa-solid fa-cart-plus"></i> Thêm giỏ
                    </button>

                    <button class="wishlist-btn btn-remove" onclick="removeItemFromWishlist(${item.id})">
                        Xóa
                    </button>
                </div>
            </div>
            `;
        });
    }

    /* ================================
       XÓA KHỎI WISHLIST
    ================================ */
    function removeItemFromWishlist(id) {
        if(!confirm("Bạn có chắc muốn xóa sản phẩm này?")) return;

        let wishlist = JSON.parse(localStorage.getItem("wishlist")) || [];
        // Lọc bỏ sản phẩm có id trùng
        wishlist = wishlist.filter(item => item.id != id); // dùng != để so sánh cả chuỗi/số

        // Lưu lại
        localStorage.setItem("wishlist", JSON.stringify(wishlist));

        // Vẽ lại giao diện
        renderWishlistPage();

        // (Tùy chọn) Cập nhật số lượng trên menu nếu có hàm đó
        // updateWishlistCountHeader();
    }

    // Chạy khi trang load xong
    document.addEventListener("DOMContentLoaded", () => {
        renderWishlistPage();
    });
</script>

</body>
</html>