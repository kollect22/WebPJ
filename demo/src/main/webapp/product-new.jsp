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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

    <style>
        body {
            font-family: Arial, sans-serif;
            color: black;
            background-color: white;
        }

        a {
            text-decoration: none;
            color: inherit;
            transition: color 0.3s ease;
        }

        li {
            list-style: none;
        }

        .breadcrumbs {
            color: grey;
            margin: 20px 40px 25px 40px;
            border-bottom: 1px solid black;
            padding-bottom: 10px;
        }

        .breadcrumbs i,
        .breadcrumbs a {
            color: black;
            text-decoration: none;
        }

        .breadcrumbs a:hover {
            text-decoration: underline;
        }

        .shop-container {
            padding: 0 40px;
            margin-bottom: 50px;
        }

        .toolbar-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            border-top: 1px solid #e5e5e5;
            border-bottom: 1px solid #e5e5e5;
            padding: 15px 0;
            margin-bottom: 30px;
            background-color: #fff;
            position: sticky;
            top: 94px;
            z-index: 999;
            box-shadow: 0 5px 10px rgba(0,0,0,0.05);
        }

        .tool-item {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #333;
            background: none;
            border: none;
            cursor: pointer;
            position: relative;
            font-family: Arial, sans-serif;
        }

        .tool-item:not(:last-child)::after {
            content: "";
            position: absolute;
            right: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 1px;
            height: 20px;
            background-color: #e5e5e5;
        }

        .btn-filter {
            font-weight: 500;
            transition: color 0.3s;
        }

        .btn-filter:hover {
            color: #000;
        }

        .product-count {
            color: #666;
            cursor: default;
        }

        /* --- 3. SORT DROPDOWN --- */
        .sort-wrapper {
            position: relative;
            z-index: 2000;
            cursor: pointer;
            user-select: none;
        }

        .sort-label {
            cursor: pointer;
            user-select: none;
            padding-right: 170px;
            padding-left: 170px;
        }

        .sort-menu {
            position: absolute;
            top: 105%;
            right: 0;
            width: 400px;
            background-color: white;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            padding: 8px 0;
            display: none;
            z-index: 2000;
            border: 1px solid #eee;
            list-style: none;
        }

        .sort-menu.show {
            display: block;
            animation: fadeIn 0.2s ease;
        }

        .sort-item {
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #333;
            font-size: 14px;
            transition: 0.2s;
        }

        .sort-item:hover {
            background-color: #f5f5f5;
            color: #000;
        }

        .check-icon {
            opacity: 0;
            color: #333;
            font-size: 12px;
        }

        .sort-item.active .check-icon {
            opacity: 1;
        }

        .product-cat-list {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 5px;
        }

        a.product-item {
            display: block;
            position: relative;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            color: inherit;
            padding-bottom: 20px;
            border: 1px solid transparent;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        a.product-item:hover {
            border: 1px solid #000;
            border-radius: 0 !important;
            background-color: #fff;
        }

        .product-item img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 0;
            background-color: #f9f9f9;
            box-sizing: border-box;
            transition: transform 0.3s ease;
            margin-bottom: 5px;
        }

        .product-item:hover img {
            transform: none;
        }

        .product-name {
            font-size: 16px;
            margin-top: 15px;
            margin-bottom: 10px;
            font-weight: 500;
            line-height: 1.4;
        }

        .product-price {
            margin-top: 8px;
            color: #333131;
            font-size: 14px;
        }

        .cart-icon {
            position: absolute;
            top: 15px;
            right: 15px;
            font-size: 18px;
            color: white;
            background-color: #000;
            padding: 10px;
            border-radius: 50%;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 2;
        }

        .product-item:hover .cart-icon {
            opacity: 1;
        }

        .filter-sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 400px;
            max-width: 85%;
            height: 100%;
            background-color: white;
            box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1);
            transform: translateX(-100%);
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 1002;
        }

        .filter-sidebar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 30px;
            border-bottom: 1px solid black;
        }

        .filter-sidebar-header h2 {
            margin: 0;
            font-size: 18px;
            text-transform: uppercase;
            font-weight: 600;
            color: black;
        }

        .filter-sidebar-header button {
            background: none;
            border: none;
            color: black;
            font-size: 24px;
            cursor: pointer;
            transition: 0.3s;
        }

        .filter-sidebar-header button:hover {
            color: black;
            transform: rotate(90deg);
        }

        .filter-sidebar-body {
            padding: 10px 30px;
        }

        .categories-list {
            padding-left: 0;
            margin-top: 10px;
        }

        .categories-list li {
            margin-bottom: 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0);
        }

        .categories-list a {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 0;
            color: black;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        .categories-list a:hover {
            color: grey;
            padding-left: 10px;
        }

        .categories-list a::after {
            content: "\f054";
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            font-size: 12px;
            color: black;
            transition: color 0.3s;
        }

        .categories-list a:hover::after {
            color: grey;
        }

        .filter-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 1001;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            backdrop-filter: blur(2px);
        }

        .filter-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        .filter-overlay.active .filter-sidebar {
            transform: none;
        }

        .badge-new {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: #ff0000;
            color: white;
            padding: 4px 8px;
            font-size: 12px;
            font-weight: bold;
            z-index: 10;
            border-radius: 2px;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<section class="banner">
    <img src="${pageContext.request.contextPath}/img/banners/banner-hlw.jpg" alt="Banner Halloween"/>
    <div class="banner-text">
        <h2>Ưu đãi Halloween</h2>
        <a href="${pageContext.request.contextPath}/halloween-sales.jsp">Xem Ngay</a>
    </div>
</section>

<nav class="breadcrumbs">
    <i class="fa-regular fa-house"></i>
    <a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a> / <span>Hàng mới</span>
</nav>

<div class="shop-container">

    <div class="toolbar-container">
        <button class="tool-item btn-filter" id="filter-toggle-btn">
            <i class="fa-solid fa-filter"></i> Bộ lọc
        </button>

        <div class="tool-item product-count" id ="product-count-display">
            ${listNew != null ? listNew.size() : 0} sản phẩm
        </div>

        <div class="tool-item sort-wrapper" id="sortDropdownContainer">
            <div class="sort-label" id="sortToggle">
                <i class="fa-solid fa-arrow-down-short-wide"></i>
                <span id="current-sort-text">Mới nhất</span>
            </div>
            <ul class="sort-menu" id="sortMenu">
                <li class="sort-item active">Mới nhất <i class="fa-solid fa-check check-icon"></i></li>
                <li class="sort-item">Cũ nhất <i class="fa-solid fa-check check-icon"></i></li>
            </ul>
        </div>
    </div>

    <div class="product-cat-list">
        <c:forEach items="${listNew}" var="p">
            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" class="product-item">

                <div style="position: relative; overflow: hidden;">
                    <img src="${pageContext.request.contextPath}/${p.img}" alt="${p.name}"/>

                    <c:if test="${p.newProduct}">
                        <span class="badge-new">NEW</span>
                    </c:if>

                    <div class="cart-icon"><i class="fa-solid fa-cart-shopping"></i></div>
                </div>

                <div class="product-name">${p.name}</div>

                <div class="product-price">
                    <c:choose>
                        <c:when test="${p.salePrice > 0}">
                             <span style="text-decoration: line-through; color: #999; font-size: 13px;">
                                <fmt:formatNumber value="${p.price}" type="currency"/>
                             </span>
                            <span style="color: red; font-weight: bold; margin-left: 5px;">
                                <fmt:formatNumber value="${p.salePrice}" type="currency"/>
                             </span>
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber value="${p.price}" type="currency"/>
                        </c:otherwise>
                    </c:choose>
                </div>
            </a>
        </c:forEach>

        <c:if test="${empty listNew}">
            <div style="grid-column: 1/-1; text-align: center; padding: 50px;">
                <p>Hiện chưa có sản phẩm mới nào được cập nhật.</p>
            </div>
        </c:if>
    </div>
</div>

<aside class="filter-overlay" id="filter-overlay">
    <div class="filter-sidebar">
        <div class="filter-sidebar-header">
            <h2>Danh Mục</h2>
            <button id="filter-close-btn">
                <i class="fas fa-times"></i>
            </button>
        </div>

        <div class="filter-sidebar-body">
            <ul class="categories-list">
                <li><a href="${pageContext.request.contextPath}/list-product.jsp">Tất cả sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/products-cat-handbag.jsp">Túi xách</a></li>
                <li><a href="${pageContext.request.contextPath}/products-cat-accessory.jsp">Phụ kiện</a></li>
            </ul>
        </div>
    </div>
</aside>

<jsp:include page="footer.jsp" />

<script>
    window.contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

</body>
</html>