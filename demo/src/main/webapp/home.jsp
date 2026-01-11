<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
</head>
<body>

<jsp:include page="header.jsp" />

<section class="banner">
    <img src="${pageContext.request.contextPath}/img/banners/banner-hlw.jpg"/>
    <div class="banner-text">
        <h2>Ưu đãi Halloween</h2>
        <a href="${pageContext.request.contextPath}/halloween-sales.jsp">Xem Ngay</a>
    </div>
</section>

<section class="products">
    <h2>Ưu đãi mỗi ngày</h2>
    <button class="scroll-left"><i class="fa-solid fa-angle-left"></i></button>
    <div class="product-list">

        <c:forEach items="${productList}" var="p" begin="0" end="7">
            <div class="product-item">
                <img src="${pageContext.request.contextPath}/${p.img}" alt="${p.name}"/>

                <a href="add-cart?id=${p.id}&q=1" class="cart-icon">
                    <i class="fa-solid fa-cart-shopping"></i>
                </a>

<%--                <div class="color-options">--%>
<%--                    <c:forEach items="${p.colors}" var="colorCode">--%>
<%--                        <span class="color-swatch" style="background-color: ${colorCode};"></span>--%>
<%--                    </c:forEach>--%>
<%--                </div>--%>

                <div class="product-name">
                    <a href="detail?id=${p.id}" style="text-decoration: none; color: black;">
                            ${p.name}
                    </a>
                </div>

                <div class="product-price">
                    <span class="new-price">
                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                    </span>
                </div>

                <div class="Special-deal">Hot</div>
            </div>
        </c:forEach>
    </div>
    <button class="scroll-right"><i class="fa-solid fa-angle-right"></i></button>
</section>

<section class="products">
    <h2>Hàng mới về</h2>
    <button class="scroll-left"><i class="fa-solid fa-angle-left"></i></button>
    <div class="product-list">

        <c:forEach items="${productList}" var="p" begin="8" end="15">
            <div class="product-item">
                <img src="${pageContext.request.contextPath}/${p.img}" alt="${p.name}"/>
                <a href="add-cart?id=${p.id}&q=1" class="cart-icon">
                    <i class="fa-solid fa-cart-shopping"></i>
                </a>
                <div class="product-name">
                    <a href="detail?id=${p.id}" style="text-decoration: none; color: black;">
                            ${p.name}
                    </a>
                </div>
                <div class="product-price">
                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                </div>
            </div>
        </c:forEach>

    </div>
    <button class="scroll-right"><i class="fa-solid fa-angle-right"></i></button>
</section>

<section class="collection">
    <h2 class="collection-title">Bộ sưu tập</h2>
    <div class="collection-box">
        <a href="${pageContext.request.contextPath}/collection.jsp" class="item">
            <img src="${pageContext.request.contextPath}/img/banners/4-season.jpg"/>
            <h3 class="item-title">BST SEASON</h3>
            <p class="item-link">Xem bộ sưu tập ></p>
        </a>
    </div>
</section>

<div class="scroll-button">
    <button id="scrollTopBtn" title="Go to top">
        <i class="fa-solid fa-arrow-up"></i>
    </button>
</div>

<jsp:include page="footer.jsp" />

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>