<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle} - Fashion Store</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

    <style>
        /* --- 1. GLOBAL STYLES --- */
        body {
            font-family: Arial, sans-serif;
            color: black;
            background-color: white;
            margin: 0;
        }

        a {
            text-decoration: none;
            color: inherit;
            transition: color 0.3s ease;
        }

        li {
            list-style: none;
        }


        .container-breadcrumbs {
            margin-top: 110px;
            padding: 0 20px;
            margin-bottom: 20px;
        }

        .breadcrumbs {
            color: #666;
            font-size: 14px;
            margin: 0;
            padding: 0;
            border-bottom: none;
        }

        .breadcrumbs i,
        .breadcrumbs a {
            color: #333;
            text-decoration: none;
        }

        .breadcrumbs a:hover {
            text-decoration: underline;
            color: #000;
        }

        .breadcrumbs span {
            color: #999;
        }

        /* --- SHOP CONTAINER --- */
        .shop-container {
            padding: 0 0;
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
            top:94px;
            z-index: 999;
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
            height: 30px;
            background-color: #e5e5e5;
        }

        .btn-filter:hover {
            color: #000;
        }

        .product-count {
            color: #666;
            cursor: default;
        }

        /* --- SORT MENU --- */
        .sort-wrapper { position: relative; z-index: 2000; cursor: pointer; user-select: none; }
        .sort-label{ cursor: pointer; user-select: none; padding: 0 20px; } /* Đã chỉnh lại padding cho gọn */
        .sort-menu {
            position: absolute; top: 105%; right: 0; width: 250px; /* Gọn hơn */
            background-color: white; box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            padding: 8px 0; display: none; z-index: 2000; border: 1px solid #eee; list-style: none;
        }
        .sort-menu.show { display: block; animation: fadeIn 0.2s ease; }
        .sort-item {
            padding: 10px 20px; display: flex; justify-content: space-between;
            align-items: center; color: #333; font-size: 14px; transition: 0.2s;
        }
        .sort-item:hover { background-color: #f5f5f5; color: #000; }
        .check-icon { opacity: 0; color: #333; font-size: 12px; }
        .sort-item.active .check-icon { opacity: 1; }


        .product-cat-list {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 5px;
            padding: 10px 20px;
        }

        a.product-item {
            display: block;
            position: relative;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            color: inherit;
            padding-bottom: 25px;
            border: 1px solid transparent;
            box-sizing: border-box;
            transition: all 0.3s ease;
            background: #fff;
        }

        a.product-item:hover {
            border-color: black;
        }

        .product-item img {
            width: 100%;
            height: 380px; /* Chiều cao ảnh */
            object-fit: cover;
            margin-bottom: 10px;
        }

        .cart-icon {
            position: absolute; top: 15px; right: 15px; font-size: 18px;
            color: white; background-color: #000; padding: 10px; border-radius: 50%;
            opacity: 0; transition: all 0.3s ease; z-index: 2;
        }
        .product-item:hover .cart-icon { opacity: 1; transform: translateY(5px); }
        .cart-icon:hover { background-color: #d0021b; }


        .color-options {
            display: flex;
            gap: 8px;
            justify-content: center;
            margin: 15px 0 10px;
            width: 100%;
            padding: 0 10px;
            box-sizing: border-box;
        }
        .color-swatch {
            width: 18px;
            height: 18px;
            border-radius: 50%;
            border: 1px solid #e0e0e0;
            cursor: pointer;
            transition: all 0.2s;
        }
        .color-swatch:hover {
            transform: scale(1.1);
            border-color: #999;
        }

        .product-name {
            margin: 5px 0 10px;
            text-align: center;
            padding: 0 10px;
            width:100%;
            box-sizing: border-box;
        }
        .product-name a{
            color: #333;
            font-size: 16px;
            font-weight: 500;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            height: 40px; /* Chiều cao cố định 2 dòng */
        }


        .product-price {
            margin-bottom: 15px;
            font-size: 15px;
            color: #333;
            text-align: center;
            display: flex; /* Dùng flex để căn giữa các giá */
            justify-content: center;
            align-items: center;
            gap: 8px;
        }

        .product-price .sale-price-text {
            color: #d0021b; /* Màu đỏ */
            font-weight: bold;
            font-size: 16px;
        }

        /* Giá gốc khi bị gạch */
        .product-price .old-price {
            text-decoration: line-through;
            color: #999; /* Màu xám nhạt */
            font-size: 14px;
            font-weight: normal;
        }

        .product-price .regular-price-text {
            font-weight: bold;
            color: #000;
            font-size: 16px;
        }

        .discount-tag {
            background-color: #d0021b;
            color: white;
            font-size: 11px;
            font-weight: bold;
            padding: 2px 5px;
            border-radius: 3px;
            display: inline-block;
        }


        .Special-deal {
            color: #d0021b;
            font-weight: bold;
            font-size: 13px;
            text-transform: uppercase; /* Chữ in hoa */
            border: 1px solid #d0021b;
            padding: 3px 12px;
            /* Để căn giữa trong thẻ cha có text-align: center */
            display: inline-block;
            margin-top: 5px;
        }


        /* --- SIDEBAR FILTER (Giữ nguyên) --- */
        .filter-sidebar {
            position: fixed; top: 0; left: 0; width: 350px; max-width: 85%; height: 100%;
            background-color: white; box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1);
            transform: translateX(-100%); transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1); z-index: 1002;
        }
        .filter-sidebar-header {
            display: flex; justify-content: space-between; align-items: center;
            padding: 25px 30px; border-bottom: 1px solid black;
        }
        .filter-sidebar-header h2 {
            margin: 0; font-size: 18px; text-transform: uppercase; font-weight: 600; color: black;
        }
        .filter-sidebar-header button {
            background: none; border: none; color: black; font-size: 24px; cursor: pointer; transition: 0.3s;
        }
        .filter-sidebar-header button:hover { color: black; transform: rotate(90deg); }
        .filter-sidebar-body { padding: 10px 30px; }
        .categories-list { padding-left: 0; margin-top: 10px; }
        .categories-list li { margin-bottom: 0; border-bottom: 1px solid rgba(255, 255, 255, 0); }
        .categories-list a {
            display: flex; justify-content: space-between; align-items: center;
            padding: 18px 0; color: black; font-size: 15px; transition: all 0.3s ease;
        }
        .categories-list a:hover { color: grey; padding-left: 10px; }
        .categories-list a::after {
            content: "\f054"; font-family: "Font Awesome 5 Free"; font-weight: 900;
            font-size: 12px; color: black; transition: color 0.3s;
        }
        .categories-list a:hover::after { color: grey; }
        .filter-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.7); z-index: 1001; opacity: 0;
            visibility: hidden; transition: all 0.3s ease; backdrop-filter: blur(2px);
        }
        .filter-overlay.active { opacity: 1; visibility: visible; }
        .filter-overlay.active .filter-sidebar { transform: none; }
    </style>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="container-breadcrumbs">
    <nav class="breadcrumbs">
        <i class="fa-solid fa-house"></i>
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a> /
        <span>${pageTitle}</span>
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

        <div class="tool-item product-count" id ="product-count-display">
            ${productList != null ? productList.size() : 0} sản phẩm
        </div>

        <div class="tool-item sort-wrapper" id="sortDropdownContainer">
            <div class="sort-label" id="sortToggle">
                <span id="current-sort-text">Sắp xếp</span>
                <i class="fa-solid fa-chevron-down" style="font-size: 12px; margin-left: 8px;"></i>
            </div>

            <ul class="sort-menu" id="sortMenu">
                <li class="sort-item active" data-value="newest">Mới nhất <i class="fa-solid fa-check check-icon"></i></li>
                <li class="sort-item" data-value="oldest">Cũ nhất <i class="fa-solid fa-check check-icon"></i></li>
                <li class="sort-item" data-value="price-asc">Giá tăng dần <i class="fa-solid fa-check check-icon"></i></li>
                <li class="sort-item" data-value="price-desc">Giá giảm dần <i class="fa-solid fa-check check-icon"></i></li>
            </ul>

            <input type="hidden" id="sort-value" value="newest">
        </div>
    </div>

    <div class="product-cat-list">

        <c:if test="${empty list}">
            <p style="grid-column: 1/-1; text-align: center; padding: 50px;">
                Không tìm thấy sản phẩm nào!
            </p>
        </c:if>

        <c:forEach items="${list}" var="p">

            <%-- Bỏ thẻ div bọc ngoài thừa để grid hoạt động đúng --%>
            <a href="detail?id=${p.id}" class="product-item">

                    <%-- Ảnh sản phẩm --%>
                <c:choose>
                    <c:when test="${fn:startsWith(p.img, 'http')}">
                        <img src="${p.img}" alt="${p.name}" class="product-card-img" />
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/${p.img}"
                             alt="${p.name}"
                             class="product-card-img" />
                    </c:otherwise>
                </c:choose>

                    <%-- Nút thêm giỏ hàng (Chặn sự kiện click lan ra thẻ a ngoài cùng) --%>
                <span class="cart-icon" onclick="event.preventDefault(); addToCart(${p.id});">
                    <i class="fa-solid fa-cart-shopping"></i>
                </span>

                    <%-- Các chấm màu --%>
                <div class="color-options">
                    <c:if test="${not empty p.colors}">
                        <c:forEach items="${p.colors}" var="c">
                            <c:set var="bgColor" value="#ccc" />
                            <%-- (Logic chọn màu giữ nguyên) --%>
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Đen')}"><c:set var="bgColor" value="#000000" /></c:if>
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Be') || fn:containsIgnoreCase(c.colorName, 'Kem')}"><c:set var="bgColor" value="#f0e6d2" /></c:if>
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Đỏ')}"><c:set var="bgColor" value="#d0021b" /></c:if>
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Bạc')}"><c:set var="bgColor" value="#c0c0c0" /></c:if>
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Xanh')}"><c:set var="bgColor" value="#aaddff" /></c:if>
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Trắng')}"><c:set var="bgColor" value="#ffffff" /></c:if>

                            <%-- Chặn sự kiện click để không nhảy trang khi bấm vào màu --%>
                            <span class="color-swatch"
                                  onclick="event.preventDefault(); changeCardImage(this)"
                                  data-src="${pageContext.request.contextPath}/${c.imgThumbnail}"
                                  title="${c.colorName}"
                                  style="background-color: ${bgColor};">
                            </span>
                        </c:forEach>
                    </c:if>
                </div>

                    <%-- Tên sản phẩm --%>
                <div class="product-name">
                        ${p.name}
                </div>

                    <%-- Giá tiền --%>
                <div class="product-price">
                    <c:choose>
                        <%-- TRƯỜNG HỢP CÓ GIẢM GIÁ (salePrice > 0) --%>
                        <c:when test="${p.salePrice > 0}">
                            <%-- Giá mới màu đỏ --%>
                            <span class="sale-price-text">
                                <fmt:formatNumber value="${p.salePrice}" pattern="#,###"/> đ
                            </span>
                            <%-- Giá cũ gạch ngang --%>
                            <span class="old-price">
                                <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                            </span>
                            <%-- Tag phần trăm giảm giá (Nền đỏ chữ trắng) --%>
                            <span class="discount-tag">
                                -<fmt:formatNumber value="${(1 - p.salePrice/p.price) * 100}" maxFractionDigits="0"/>%
                            </span>
                        </c:when>

                        <%-- TRƯỜNG HỢP KHÔNG GIẢM GIÁ --%>
                        <c:otherwise>
                            <span class="regular-price-text">
                                <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                    <%-- Nhãn Hot (Nếu có logic check hot thì bọc c:if vào đây) --%>
                <div class="Special-deal">Hot</div>

            </a> <%-- Kết thúc thẻ a.product-item --%>

        </c:forEach>
    </div>
</div>

<%-- (Phần Sidebar và Footer giữ nguyên) --%>
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
                <li class="${empty activeCid ? 'active' : ''}">
                    <a href="/FashionStore/list-product">Tất cả sản phẩm</a>
                </li>
                <li class="${activeCid == 1 ? 'active' : ''}">
                    <a href="list-product?cid=1">Túi xách</a>
                </li>
                <li class="${activeCid == 2 ? 'active' : ''}">
                    <a href="list-product?cid=2">Phụ kiện</a>
                </li>
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