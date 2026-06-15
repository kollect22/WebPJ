<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hàng mới - Fashion Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/list-product.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
</head>
<body>

<jsp:include page="header.jsp" />

<div id="toast-container"></div>

<div class="container-breadcrumbs">
    <nav class="breadcrumbs">
        <i class="fa-solid fa-house"></i>
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a> /
        <span>Hàng mới</span>
    </nav>
</div>

<section class="banner">
    <img src="${pageContext.request.contextPath}/img/banners/banner5.jpg" style="width: 100%; object-fit: cover; padding: 0 20px; box-sizing: border-box;" />
</section>

<div class="shop-container">
    <div class="toolbar-container">
        <button class="tool-item btn-filter" id="filter-toggle-btn">
            <i class="fa-solid fa-filter"></i> Bộ lọc
        </button>
        <div class="tool-item product-count" id="product-count-display">
            ${listNew != null ? listNew.size() : 0} sản phẩm
        </div>
        <div class="tool-item sort-wrapper" id="sortDropdownContainer">
            <button class="sort-label" id="sortToggle">
                <span id="current-sort-text">Mới nhất</span>
                <i class="fa-solid fa-chevron-down" style="margin-left: 8px;"></i>
            </button>
            <ul class="sort-menu" id="sortMenu">
                <li class="sort-item active" data-value="newest">Mới nhất</li>
                <li class="sort-item" data-value="oldest">Cũ nhất</li>
            </ul>
        </div>
    </div>

    <div class="product-cat-list" id="product-container">
        <c:forEach items="${listNew}" var="p">
            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" class="product-item">
                <div style="position: relative; overflow: hidden;">
                    <img src="${pageContext.request.contextPath}/${p.img}" alt="${p.name}" class="product-card-img"/>
                    <c:if test="${p.newProduct}"><span class="badge-new">NEW</span></c:if>
                    <span class="cart-icon" onclick="event.preventDefault(); addToCart(${p.id});">
                            <i class="fa-solid fa-cart-shopping"></i>
                    </span>
                </div>
                <div class="product-name">${p.name}</div>
                <div class="product-price">
                    <c:choose>
                        <c:when test="${p.salePrice > 0}">
                            <span class="old-price"><fmt:formatNumber value="${p.price}" type="currency"/></span>
                            <span class="sale-price-text"><fmt:formatNumber value="${p.salePrice}" type="currency"/></span>
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber value="${p.price}" type="currency"/>
                        </c:otherwise>
                    </c:choose>
                </div>
            </a>
        </c:forEach>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script>
    window.contextPath = '${pageContext.request.contextPath}';

    // Hàm thông báo 1 dòng (Toast) đã tinh chỉnh
    function showToast(message) {
        const container = document.getElementById('toast-container');
        const toast = document.createElement('div');
        toast.className = 'toast-msg';
        toast.innerHTML = `<i class="fa-solid fa-check"></i> <span>${message}</span>`;
        container.appendChild(toast);
        setTimeout(() => toast.remove(), 2500);
    }

    // Hàm thêm giỏ hàng dùng chung
    function addToCart(productId) {
        fetch(`${window.contextPath}/add-cart?id=${productId}&q=1&action=add`, { method: 'POST' })
            .then(res => res.json())
            .then(data => {
                const cartCountEl = document.getElementById('cart-count');
                if (cartCountEl) cartCountEl.innerText = data.totalQuantity;
                showToast("Đã thêm " + data.productName + " vào giỏ hàng!");
            })
            .catch(err => console.error("Lỗi:", err));
    }
</script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

</body>
</html>