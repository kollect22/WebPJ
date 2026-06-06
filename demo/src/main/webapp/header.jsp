<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<style>
    .search-overlay-fullscreen {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background: rgba(255, 255, 255, 0.98);
        z-index: 100000;
        overflow-y: auto;
        animation: fadeInDown 0.3s ease-out;
    }

    @keyframes fadeInDown {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }


    .close-search-btn {
        position: absolute;
        top: 30px;
        right: 40px;
        background: none;
        border: none;
        font-size: 28px;
        color: #ccc;
        cursor: pointer;
        transition: 0.2s;
    }

    .close-search-btn:hover {
        color: #000;
        transform: rotate(90deg);
    }

    .search-overlay-container {
        max-width: 800px;
        margin: 80px auto 0;
        padding: 0 20px;
    }


    .mega-search-form {
        display: flex;
        align-items: center;
        border: 2px solid #000;
        padding: 5px 15px;
        background: #fff;
        border-radius: 4px;
    }

    .mega-search-form input {
        flex: 1;
        border: none;
        outline: none;
        font-size: 16px;
        padding: 10px 0;
        color: #333;
    }

    .mega-search-form input::placeholder {
        color: #bbb;
    }

    .mega-search-form button {
        background: none;
        border: none;
        font-size: 20px;
        cursor: pointer;
        color: #000;
    }

    .mega-search-content {
        margin-top: 40px;
        text-align: left;
    }

    .suggestions-grid {
        display: flex;
        flex-direction: column;
        gap: 10px;
        margin-top: 20px;
    }
    .suggestion-card {
        display: flex;
        align-items: center;
        justify-content: flex-start;
        gap: 15px;
        padding: 10px 15px;
        border-bottom: 1px solid #f0f0f0;
        text-decoration: none;
        color: #333;
        transition: background 0.2s ease;
        border-radius: 6px;
    }

    .suggestion-card:hover {
        background-color: #f9f9f9;
    }


    .suggestion-card img {
        width: 60px;
        height: 60px;
        object-fit: cover;
        border-radius: 4px;
        flex-shrink: 0;
    }


    .suggestion-card-info {
        text-align: left;
        flex: 1;
    }

    .suggestion-card-info h4 {
        font-size: 15px;
        font-weight: 500;
        margin: 0 0 5px 0;
        line-height: 1.4;
        color: #000;
    }

    .suggestion-card-info p {
        font-size: 14px;
        font-weight: bold;
        color: #d0021b;
        margin: 0;
    }
    .search-title {
        font-size: 14px;
        font-weight: bold;
        color: #888;
        margin-bottom: 20px;
        letter-spacing: 1px;
    }

    .trending-searches ul {
        list-style: none;
        padding: 0;
    }

    .trending-searches ul li {
        margin-bottom: 15px;
    }

    .trending-searches ul li a {
        text-decoration: none;
        color: #333;
        font-size: 15px;
        transition: 0.2s;
    }

    .trending-searches ul li a:hover {
        color: #d0021b;
        padding-left: 5px;
    }
</style>

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
<%--            <div class="search-box">--%>
<%--                <i class="fa-solid fa-magnifying-glass"></i>--%>
<%--                <input type="search" placeholder="Tìm kiếm" class="search-input">--%>
<%--            </div>--%>
<%--                <form action="${pageContext.request.contextPath}/list-product" method="GET" class="search-box">--%>

<%--                    <button type="submit" style="background: none; border: none; cursor: pointer; padding: 0;">--%>
<%--                        <i class="fa-solid fa-magnifying-glass"></i>--%>
<%--                    </button>--%>

<%--                    <input type="search" id="search" name="search" value="${param.search}" placeholder="Tìm kiếm" class="search-input" autocomplete="off">--%>

<%--                </form>--%>

                <button id="openSearchBtn"style="background: none; border: none; cursor: pointer; padding: 0; font-size: 18px; margin-right: 10px;">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>

                <a href="${pageContext.request.contextPath}${empty sessionScope.auth ? '/login.jsp' : '/user/profile.jsp'}"
                   class="user-account-btn d-flex align-items-center gap-2 text-decoration-none text-reset text-nowrap">

                    <i class="fa-solid fa-user"></i>

                    <span class="fw-bold">
                        ${empty sessionScope.auth ? 'Đăng nhập' :sessionScope.auth.fullName}
                    </span>
                </a>

                <a href="${pageContext.request.contextPath}/wishlist-add" class="wishlist-header">
                    <i class="fa-regular fa-heart"></i>
                    <span class="wishlist-count" id="wishlist-count">
                        ${wishlistSession != null ? wishlistSession.size() : 0}
                    </span>
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

                <div id="searchSuggestions" class="suggestions-fullwidth" style="display: none;">
                    <div class="suggestions-title">SẢN PHẨM GỢI Ý KHỚP VỚI TỪ KHÓA</div>
                    <div class="suggestions-grid">
                    </div>
                </div>

        </div>
    </div>

    <div id="searchOverlay" class="search-overlay-fullscreen" style="display: none;">
        <button id="closeSearchBtn" class="close-search-btn"><i class="fa-solid fa-xmark"></i></button>

        <div class="search-overlay-container">
            <form action="${pageContext.request.contextPath}/list-product" method="GET" class="mega-search-form">
                <input type="search" id="megaSearchInput" name="search" placeholder="Tìm kiếm sản phẩm...ull" autocomplete="off">
                <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>

            <div class="mega-search-content">
                <div id="trendingSearches" class="trending-searches">
                    <p class="search-title">TỪ KHÓA ĐƯỢC TÌM KIẾM NHỂU NHẤT</p>
                    <ul
                        id ="trendingKeywordsList">
                    </ul>
                </div>

                <div id="searchSuggestionsGrid" class="suggestions-grid" style="display: none; margin-top: 30px;">
                </div>
            </div>
        </div>
    </div>
</header>

<script>
    document.addEventListener("DOMContentLoaded", function() {

        const openBtn = document.getElementById('openSearchBtn');
        const closeBtn = document.getElementById('closeSearchBtn');
        const searchOverlay = document.getElementById('searchOverlay');
        const megaInput = document.getElementById('megaSearchInput');
        const gridContainer = document.getElementById('searchSuggestionsGrid');
        const trendingBox = document.getElementById('trendingSearches');

        if (openBtn) {
            openBtn.addEventListener('click', function(e) {
                e.preventDefault();
                searchOverlay.style.display = 'block';
                setTimeout(() => megaInput.focus(), 100);
                document.body.style.overflow = 'hidden';
            });
        }

        if (closeBtn) {
            closeBtn.addEventListener('click', function() {
                searchOverlay.style.display = 'none';
                document.body.style.overflow = 'auto';
            });
        }

        if (megaInput) {
            megaInput.addEventListener('input', function() {
                const keyword = this.value.trim();
                gridContainer.innerHTML = '';

                if (keyword.length > 0) {
                    trendingBox.style.display = 'none';
                    gridContainer.style.display = 'grid';


                    const url = (window.contextPath || '') + '/api/search?keyword=' + encodeURIComponent(keyword);

                    fetch(url)
                        .then(response => {
                            if (!response.ok) throw new Error('Lỗi kết nối hệ thống');
                            return response.json();
                        })
                        .then(products => {
                            if (products && products.length > 0) {
                                products.forEach(item => {
                                    const formattedPrice = new Intl.NumberFormat('vi-VN', {
                                        style: 'currency',
                                        currency: 'VND'
                                    }).format(item.price || 0);

                                    const html =
                                        '<a href="product-detail?id=' + item.id + '" class="suggestion-card">' +
                                        '<img src="' + (window.contextPath || '') + '/' + item.img + '" alt="' + item.name + '">' +
                                            '<div class="suggestion-card-info">' +
                                                '<h4>' + item.name + '</h4>' +
                                                '<p>' + formattedPrice + '</p>' +
                                            '</div>' +
                                        '</a>';

                                    gridContainer.insertAdjacentHTML('beforeend', html);
                                });
                            } else {
                                gridContainer.style.display = 'block';
                                gridContainer.innerHTML = '<div style="padding: 30px; color: #777; font-size: 16px; text-align: center;">Không tìm thấy kết quả nào phù hợp.</div>';
                            }
                        })
                        .catch(error => {
                            console.error("Lỗi Fetch AJAX:", error);
                        });
                } else {
                    gridContainer.style.display = 'none';
                    trendingBox.style.display = 'block';
                }
            });
        }
    });
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmxc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>