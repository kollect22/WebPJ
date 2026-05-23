<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


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
            <form action="${pageContext.request.contextPath}/list-product" method="GET" class="search-box">

                <button type="submit" style="background: none; border: none; cursor: pointer; padding: 0;">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>

                <input type="search" id="search" name="search" value="${param.search}" placeholder="Tìm kiếm" class="search-input" autocomplete="off">

                <div id="searchSuggestions" class="suggestions-box" style="display: none;">
                </div>

            </form>

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

        </div>
    </div>
</header>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const searchInput = document.getElementById('search');
        const suggestionsBox = document.getElementById('searchSuggestions');


        const mockProducts = [
            { id: 1, name: 'Túi Xách Channel Đen', price: '500.000 đ', img: 'img/banners/banner2.webp' },
            { id: 2, name: 'Túi Xách Dior Trắng', price: '750.000 đ', img: 'img/banners/banner3.jpg' },
            { id: 3, name: 'Balo Gucci Mini', price: '900.000 đ', img: 'img/banners/banner5.jpg' },
            { id: 4, name: 'Ví Da Nam Cầm Tay', price: '300.000 đ', img: 'img/banners/banner6.jpg' }
        ];


        searchInput.addEventListener('input', function() {
            const keyword = this.value.toLowerCase().trim();
            suggestionsBox.innerHTML = ''; // Xóa kết quả cũ

            if (keyword.length > 0) {

                const filtered = mockProducts.filter(item => item.name.toLowerCase().includes(keyword));

                if (filtered.length > 0) {

                    filtered.forEach(item => {

                        const html = `
                        <a href="product-detail?id=${item.id}" class="suggestion-item">
                            <img src="${window.contextPath || ''}/${item.img}" alt="${item.name}">
                            <div class="suggestion-item-info">
                                <h4>${item.name}</h4>
                                <p>${item.price}</p>
                            </div>
                        </a>
                    `;
                        suggestionsBox.insertAdjacentHTML('beforeend', html);
                    });
                    suggestionsBox.style.display = 'block';
                } else {
                    suggestionsBox.innerHTML = '<div style="padding: 15px; color: #777; font-size: 14px; text-align: center;">Không tìm thấy sản phẩm nào phù hợp.</div>';
                    suggestionsBox.style.display = 'block';
                }
            } else {
                // Ẩn khung nếu khách hàng xóa hết chữ
                suggestionsBox.style.display = 'none';
            }
        });


        document.addEventListener('click', function(e) {
            if (!searchInput.contains(e.target) && !suggestionsBox.contains(e.target)) {
                suggestionsBox.style.display = 'none'; // Ẩn khi bấm ra ngoài
            }
        });

        searchInput.addEventListener('focus', function() {
            if (this.value.trim().length > 0) {
                suggestionsBox.style.display = 'block';
            }
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmxc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>