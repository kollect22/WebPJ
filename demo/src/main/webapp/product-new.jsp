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