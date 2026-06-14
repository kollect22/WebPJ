<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">


<header class="navbar fixed-top bg-white shadow-sm" style="z-index: 9999;">
    <div class="navbar-container ">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/home">
                Fashion Store
            </a>
        </div>

        <nav class="nav-center">
            <ul>
                <li><a href="${pageContext.request.contextPath}/product-new">Hàng mới</a></li>
                <li>
                    <a href="#" id="menu-san-pham-btn">Sản phẩm</a>
                </li>
                <li><a href="${pageContext.request.contextPath}/collection.jsp">Bộ sưu tập</a></li>
                <li><a href="${pageContext.request.contextPath}/introduce.jsp">Giới thiệu</a></li>
            </ul>
        </nav>

        <div class="nav-right">
            <button id="openSearchBtn" style="background: none; border: none; cursor: pointer; padding: 0; font-size: 18px; margin-right: 10px;">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>

            <a href="${pageContext.request.contextPath}${empty sessionScope.auth ? '/login.jsp' : '/user/profile.jsp'}"
               class="user-account-btn d-flex align-items-center gap-2 text-decoration-none text-reset text-nowrap">
                <i class="fa-solid fa-user"></i>
                <span class="fw-bold">
                    ${empty sessionScope.auth ? 'Đăng nhập' : sessionScope.auth.fullName}
                </span>
            </a>

            <a href="${pageContext.request.contextPath}/wishlist-add" class="wishlist-header">
                <i class="fa-regular fa-heart"></i>
                <span class="wishlist-count" id="wishlist-count">
                    ${wishlistSession != null ? wishlistSession.size() : 0}
                </span>
            </a>

            <div class="cart-wrapper">
                <a href="cart.jsp" style="color: black; font-size: 20px;">
                    <i class="fa-solid fa-cart-shopping"></i>
                </a>
                <span class="cart-count" id="cart-count">
                    ${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0}
                </span>
            </div>
        </div>
    </div>

    <div id="searchOverlay" class="search-overlay-fullscreen" style="display: none;">
        <button id="closeSearchBtn" class="close-search-btn"><i class="fa-solid fa-xmark"></i></button>

        <div class="search-overlay-container">
            <form action="${pageContext.request.contextPath}/list-product" method="GET" class="mega-search-form">
                <input type="search" id="megaSearchInput" name="search" placeholder="Tìm kiếm sản phẩm yêu thích của bạn..." autocomplete="off">
                <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>

            <div class="mega-search-content">
                <div id="trendingSearches" class="trending-searches">
                    <p class="search-title">TỪ KHÓA ĐƯỢC TÌM KIẾM NHIỀU NHẤT</p>
                    <ul id="trendingKeywordsList">
                        <li><a href="${pageContext.request.contextPath}/list-product?search=Túi nữ">Túi nữ</a></li>
                        <li><a href="${pageContext.request.contextPath}/list-product?search=Ví nữ">Ví nữ</a></li>
                        <li><a href="${pageContext.request.contextPath}/list-product?search=Giày">Phụ kiện</a></li>
                        <li><a href="${pageContext.request.contextPath}/list-product?search=Dép bệt">Túi da</a></li>
                        <li><a href="${pageContext.request.contextPath}/list-product?search=Túi đeo chéo">Túi đeo chéo</a></li>
                    </ul>
                </div>
                <div id="searchSuggestionsGrid" class="suggestions-grid" style="display: none; margin-top: 30px;">
                </div>
            </div>
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
                        <a href="${pageContext.request.contextPath}/list-product">Tất cả sản phẩm</a>
                    </li>
                    <li class="${activeCid == 1 ? 'active' : ''}">
                        <a href="${pageContext.request.contextPath}/list-product?cid=1">Túi xách</a>
                    </li>
                    <li class="${activeCid == 3 ? 'active' : ''}">
                        <a href="${pageContext.request.contextPath}/list-product?cid=3">Túi đeo vai</a>
                    </li>
                    <li class="${activeCid == 4 ? 'active' : ''}">
                        <a href="${pageContext.request.contextPath}/list-product?cid=4">Túi xách tay</a>
                    </li>
                    <li class="${activeCid == 5 ? 'active' : ''}">
                        <a href="${pageContext.request.contextPath}/list-product?cid=5">Túi đeo chéo</a>
                    </li>
                    <li class="${activeCid == 6 ? 'active' : ''}">
                        <a href="${pageContext.request.contextPath}/list-product?cid=6">Túi tote</a>
                    </li>
                    <li class="${activeCid == 7 ? 'active' : ''}">
                        <a href="${pageContext.request.contextPath}/list-product?cid=7">Ví</a>
                    </li>
                    <li class="${activeCid == 2 ? 'active' : ''}">
                        <a href="${pageContext.request.contextPath}/list-product?cid=2">Phụ kiện</a>
                    </li>
                </ul>
            </div>
        </div>
    </aside>

</header>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
