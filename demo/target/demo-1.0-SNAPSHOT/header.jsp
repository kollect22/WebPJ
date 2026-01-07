<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

<header class="navbar">
    <div class="logo">
        <a href="${pageContext.request.contextPath}/index.jsp">
            Fashion Store
        </a>
    </div>

    <nav class="nav-center">
        <ul>
            <li><a href="${pageContext.request.contextPath}/product-new.jsp">Hàng mới</a></li>

            <li>
                <a href="${pageContext.request.contextPath}/products-category-all.jsp">Sản phẩm</a>
                <ul class="sub-menu">
                    <li><a href="${pageContext.request.contextPath}/products-cat-handbag.jsp">Túi xách</a></li>
                    <li><a href="${pageContext.request.contextPath}/products-cat-accessory.jsp">Phụ kiện</a></li>
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
                ${sessionScope.auth.username}
            </span>
        </a>

        <a href="${pageContext.request.contextPath}/wishlist.jsp" class="wishlist-header">
            <i class="fa-regular fa-heart"></i>
            <span class="wishlist-count">0</span>
        </a>

        <a href="${pageContext.request.contextPath}/cart.jsp">
            <i class="fa-solid fa-shopping-cart"></i> (${sessionScope.cart.totalQuantity}
        </a>
    </div>
</header>