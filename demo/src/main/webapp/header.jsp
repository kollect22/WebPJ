<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

<header class="navbar">
    <div class="logo">
        <a href="${pageContext.request.contextPath}/home">
            Fashion Store
        </a>
    </div>

    <nav class="nav-center">
        <ul>
            <li><a href="${pageContext.request.contextPath}/product-new.jsp">Hàng mới</a></li>

            <li>
                <a href="${pageContext.request.contextPath}/list-product">Sản phẩm</a>
                <ul class="sub-menu">
                    <li><a href="${pageContext.request.contextPath}/list-product?cid=1">Túi xách</a></li>
                    <li><a href="${pageContext.request.contextPath}/list-product?cid=2">Phụ kiện</a></li>
                </ul>
            </li>

            <li><a href="${pageContext.request.contextPath}/collection.jsp">Bộ sưu tập</a></li>
            <li><a href="${pageContext.request.contextPath}/introduce.jsp">Giới thiệu</a></li>
        </ul>
    </nav>

    <div class="nav-right">
        <div class="search-box">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="search" placeholder="Tìm kiếm" class="search-input">
        </div>

        <a href="${empty sessionScope.auth ? pageContext.request.contextPath.concat('/login.jsp') : '#'}"
           class="d-flex align-items-center gap-2 text-decoration-none text-reset">

            <i class="fa-solid fa-user"></i>

            <span class="fw-bold">
                ${sessionScope.auth.fullName}
            </span>
        </a>

        <a href="${pageContext.request.contextPath}/wishlist" class="wishlist-header">
            <i class="fa-regular fa-heart"></i>
            <span class="wishlist-count">0</span>
        </a>


<%--        <a href="${pageContext.request.contextPath}/cart.jsp" class="cart-header">--%>
<%--            <i class="fa-solid fa-shopping-cart"></i>--%>
<%--            <span class="cart-count">--%>
<%--                ${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0}--%>
<%--            </span>--%>
<%--        </a>--%>

        <div class="cart-wrapper">

            <a href="cart.jsp" style="color: black; font-size: 20px;">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>

            <span class="cart-count" id="cart-count">
                ${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0}
            </span>

        </div>

    </div>
</header>