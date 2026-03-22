<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

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

<%--<section class="banner">--%>
<%--    <img src="${pageContext.request.contextPath}/img/banners/banner-hlw.jpg"/>--%>
<%--    <div class="banner-text">--%>
<%--        <h2>Ưu đãi Halloween</h2>--%>
<%--        <a href="${pageContext.request.contextPath}/halloween-sales.jsp">Xem Ngay</a>--%>
<%--    </div>--%>
<%--</section>--%>

<section class="banner-slider">
    <div class = "slider-track">
        <div class = "slide">
            <img src="${pageContext.request.contextPath}/img/banners/banner5.jpg" alt="Banner 1">
        </div>

        <div class = "slide">
            <img src="${pageContext.request.contextPath}/img/banners/banner6.jpg" alt="Banner 1">
        </div>

        <div class = "slide">
            <img src="${pageContext.request.contextPath}/img/banners/banner10.jpeg" alt="Banner 1">
        </div>
    </div>
</section>

<section class="category-split">
    <div class="cat-box">
        <a href="${pageContext.request.contextPath}/list-product?cid=1"> <img src="${pageContext.request.contextPath}/img/banners/banner2.webp" alt="Túi xách">
            <div class="cat-content">
                <h3>Túi xách</h3>
                <span class="shop-now">Mua Ngay</span>
            </div>
        </a>
    </div>

    <div class="cat-box">
        <a href="${pageContext.request.contextPath}/list-product?cid=2"> <img src="${pageContext.request.contextPath}/img/banners/banner3.jpg" alt="Phụ kiện">
            <div class="cat-content">
                <h3>Phụ kiện</h3>
                <span class="shop-now">Mua Ngay</span>
            </div>
        </a>
    </div>
</section>

<section class="products">
    <h2>Ưu đãi mỗi ngày</h2>
    <button class="scroll-left"><i class="fa-solid fa-angle-left"></i></button>

    <div class="product-list">

        <c:forEach items="${list}" var="p" begin="0" end="7">
            <div class="product-item">
<%--                <img src="${pageContext.request.contextPath}/${p.img}" alt="${p.name}"/>--%>

                <a href="detail?id=${p.id}" class="product-link">
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
                </a>

                <a href="javascript:void(0)"
                   class="cart-icon"
                   onclick="addToCart(${p.id})">
                    <i class="fa-solid fa-cart-shopping"></i>
                </a>

                <div class="color-options">
                    <c:if test="${not empty p.colors}">
                        <c:forEach items="${p.colors}" var="c">

                            <c:set var="bgColor" value="#ccc" /> <c:if test="${c.colorName == 'Màu Đen' || c.colorName == 'Đen'}">
                            <c:set var="bgColor" value="#000000" />
                        </c:if>
                            <c:if test="${c.colorName == 'Màu Be' || c.colorName == 'Kem'}">
                                <c:set var="bgColor" value="#f0e6d2" />
                            </c:if>
                            <c:if test="${c.colorName == 'Màu Đỏ' || c.colorName == 'Đỏ'}">
                                <c:set var="bgColor" value="#d0021b" />
                            </c:if>
                            <c:if test="${c.colorName == 'Màu Bạc' || c.colorName == 'Bạc'}">
                                <c:set var="bgColor" value="#c0c0c0" />
                            </c:if>
                            <c:if test="${c.colorName == 'Màu Xanh' || c.colorName == 'Xanh'}">
                                <c:set var="bgColor" value="#aaddff" />
                            </c:if>

                            <span class="color-swatch"
                                  onclick="changeCardImage(this)"
                                  data-src="${pageContext.request.contextPath}/${c.imgThumbnail}"
                                  data-link="detail?id=${c.productid}"
                                  title="${c.colorName}"
                                  style="background-color: ${bgColor};">
                        </span>

                        </c:forEach>
                    </c:if>
                </div>

                <div class="product-name">
                    <a href="detail?id=${p.id}" title="${p.name}">
                            ${p.name}
                    </a>
                </div>

                <div class="product-price">
                    <c:choose>
                        <%-- TRƯỜNG HỢP CÓ GIẢM GIÁ (salePrice > 0) --%>
                        <c:when test="${p.salePrice > 0}">
                            <span class="new-price" style="color: #d0021b; font-weight: bold;">
                                <fmt:formatNumber value="${p.salePrice}" type="currency" currencySymbol="đ"/>
                            </span>
                                            <span class="old-price" style="text-decoration: line-through; color: #999; font-size: 0.9em; margin-left: 5px;">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                            </span>

                                            <span class="discount-tag" style="background: #d0021b; color: white; padding: 2px 4px; border-radius: 3px; font-size: 0.7em;">
                                -<fmt:formatNumber value="${(1 - p.salePrice/p.price) * 100}" maxFractionDigits="0"/>%
                            </span>
                        </c:when>

                        <%-- TRƯỜNG HỢP KHÔNG GIẢM GIÁ --%>
                        <c:otherwise>
                            <span class="new-price" style="font-weight: bold;">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                            </span>
                        </c:otherwise>
                    </c:choose>
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

        <c:forEach items="${list}" var="p" begin="8" end="15">
            <div class="product-item">

                <a href="detail?id=${p.id}" class="product-link">
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
                </a>

                <a href="javascript:void(0)"
                   class="cart-icon"
                   onclick="addToCart(${p.id})">
                    <i class="fa-solid fa-cart-shopping"></i>
                </a>

                <div class="color-options">
                    <c:if test="${not empty p.colors}">
                        <c:forEach items="${p.colors}" var="c">

                            <c:set var="bgColor" value="#ccc" /> <c:if test="${c.colorName == 'Màu Đen' || c.colorName == 'Đen'}">
                            <c:set var="bgColor" value="#000000" />
                        </c:if>
                            <c:if test="${c.colorName == 'Màu Be' || c.colorName == 'Kem'}">
                                <c:set var="bgColor" value="#f0e6d2" />
                            </c:if>
                            <c:if test="${c.colorName == 'Màu Đỏ' || c.colorName == 'Đỏ'}">
                                <c:set var="bgColor" value="#d0021b" />
                            </c:if>
                            <c:if test="${c.colorName == 'Màu Bạc' || c.colorName == 'Bạc'}">
                                <c:set var="bgColor" value="#c0c0c0" />
                            </c:if>
                            <c:if test="${c.colorName == 'Màu Xanh' || c.colorName == 'Xanh'}">
                                <c:set var="bgColor" value="#aaddff" />
                            </c:if>

                            <span class="color-swatch"
                                  onclick="changeCardImage(this)"
                                  data-src="${pageContext.request.contextPath}/${c.imgThumbnail}"
                                  data-link="detail?id=${c.productid}"
                                  title="${c.colorName}"
                                  style="background-color: ${bgColor};">
                        </span>

                        </c:forEach>
                    </c:if>
                </div>

                <div class="product-name">
                    <a href="detail?id=${p.id}" title="${p.name}">
                            ${p.name}
                    </a>
                </div>

                <div class="product-price">
                    <c:choose>
                        <%-- TRƯỜNG HỢP CÓ GIẢM GIÁ (salePrice > 0) --%>
                        <c:when test="${p.salePrice > 0}">
                            <span class="new-price" style="color: #d0021b; font-weight: bold;">
                                <fmt:formatNumber value="${p.salePrice}" type="currency" currencySymbol="đ"/>
                            </span>
                            <span class="old-price" style="text-decoration: line-through; color: #999; font-size: 0.9em; margin-left: 5px;">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                            </span>

                            <span class="discount-tag" style="background: #d0021b; color: white; padding: 2px 4px; border-radius: 3px; font-size: 0.7em;">
                                -<fmt:formatNumber value="${(1 - p.salePrice/p.price) * 100}" maxFractionDigits="0"/>%
                            </span>
                        </c:when>

                        <%-- TRƯỜNG HỢP KHÔNG GIẢM GIÁ --%>
                        <c:otherwise>
                            <span class="new-price" style="font-weight: bold;">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="Special-deal">Hot</div>
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

<%
    String status = (String) session.getAttribute("checkout_status");
    if ("success".equals(status)) {
%>
<script>
    alert("🎉 Chúc mừng! Bạn đã thanh toán thành công.");
</script>
<%
        session.removeAttribute("checkout_status");
    }
%>
<script>
    window.contextPath = '${pageContext.request.contextPath}';
</script>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>


</body>
</html>