<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:choose>
    <%-- ========================================================== --%>
    <%-- CHẾ ĐỘ 1: KHI BẤM NÚT "XEM THÊM" (CHỈ TRẢ VỀ CÁC THẺ SẢN PHẨM) --%>
    <%-- ========================================================== --%>
    <c:when test="${param.ajax == 'true'}">
        <c:forEach items="${list}" var="p">
            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" class="product-item">
                <c:choose>
                    <c:when test="${fn:startsWith(p.img, 'http')}">
                        <img src="${p.img}" alt="${p.name}" class="product-card-img" />
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/${p.img}" alt="${p.name}" class="product-card-img" />
                    </c:otherwise>
                </c:choose>

                <span class="cart-icon" onclick="event.preventDefault(); addToCart(${p.id});">
                    <i class="fa-solid fa-cart-shopping"></i>
                </span>

                <div class="color-options">
                    <c:if test="${not empty p.colors}">
                        <c:forEach items="${p.colors}" var="c">
                            <c:set var="bgColor" value="#ccc" />
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Đen')}"><c:set var="bgColor" value="#000000" /></c:if>
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Be') || fn:containsIgnoreCase(c.colorName, 'Kem')}"><c:set var="bgColor" value="#f0e6d2" /></c:if>
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Đỏ')}"><c:set var="bgColor" value="#d0021b" /></c:if>
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Bạc')}"><c:set var="bgColor" value="#c0c0c0" /></c:if>
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Xanh')}"><c:set var="bgColor" value="#aaddff" /></c:if>
                            <c:if test="${fn:containsIgnoreCase(c.colorName, 'Trắng')}"><c:set var="bgColor" value="#ffffff" /></c:if>
                            <span class="color-swatch"
                                  onclick="event.preventDefault(); changeCardImage(this)"
                                  data-src="${pageContext.request.contextPath}/${c.imgThumbnail}"
                                  data-link="product-detail?id=${c.productid}"
                                  title="${c.colorName}"
                                  style="background-color: ${bgColor};">
                            </span>
                        </c:forEach>
                    </c:if>
                </div>

                <div class="product-name">${p.name}</div>

                <div class="product-price">
                    <c:choose>
                        <c:when test="${p.salePrice > 0}">
                            <span class="sale-price-text"><fmt:formatNumber value="${p.salePrice}" pattern="#,###"/> đ</span>
                            <span class="old-price"><fmt:formatNumber value="${p.price}" pattern="#,###"/> đ</span>
                            <span class="discount-tag">-<fmt:formatNumber value="${(1 - p.salePrice/p.price) * 100}" maxFractionDigits="0"/>%</span>
                        </c:when>
                        <c:otherwise>
                            <span class="regular-price-text"><fmt:formatNumber value="${p.price}" pattern="#,###"/> đ</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="Special-deal">Hot</div>
            </a>
        </c:forEach>
    </c:when>

    <%-- ========================================================== --%>
    <%-- CHẾ ĐỘ 2: LOAD TRANG BÌNH THƯỜNG (FULL TRANG WEB)            --%>
    <%-- ========================================================== --%>
    <c:otherwise>
        <!DOCTYPE html>
        <html lang="vi">
        <head>
            <meta charset="UTF-8">
            <title>${pageTitle} - Fashion Store</title>

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
                        ${totalProducts != null ? totalProducts : 0} sản phẩm
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

            <div class="product-cat-list" id="product-container">
                <c:if test="${empty list}">
                    <p style="grid-column: 1/-1; text-align: center; padding: 50px;">
                        Không tìm thấy sản phẩm nào!
                    </p>
                </c:if>

                <c:forEach items="${list}" var="p">
                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" class="product-item">
                        <c:choose>
                            <c:when test="${fn:startsWith(p.img, 'http')}">
                                <img src="${p.img}" alt="${p.name}" class="product-card-img" />
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/${p.img}" alt="${p.name}" class="product-card-img" />
                            </c:otherwise>
                        </c:choose>
                        <span class="cart-icon" onclick="event.preventDefault(); addToCart(${p.id});">
                            <i class="fa-solid fa-cart-shopping"></i>
                        </span>
                        <div class="color-options">
                            <c:if test="${not empty p.colors}">
                                <c:forEach items="${p.colors}" var="c">
                                    <c:set var="bgColor" value="#ccc" />
                                    <c:if test="${fn:containsIgnoreCase(c.colorName, 'Đen')}"><c:set var="bgColor" value="#000000" /></c:if>
                                    <c:if test="${fn:containsIgnoreCase(c.colorName, 'Be') || fn:containsIgnoreCase(c.colorName, 'Kem')}"><c:set var="bgColor" value="#f0e6d2" /></c:if>
                                    <c:if test="${fn:containsIgnoreCase(c.colorName, 'Đỏ')}"><c:set var="bgColor" value="#d0021b" /></c:if>
                                    <c:if test="${fn:containsIgnoreCase(c.colorName, 'Bạc')}"><c:set var="bgColor" value="#c0c0c0" /></c:if>
                                    <c:if test="${fn:containsIgnoreCase(c.colorName, 'Xanh')}"><c:set var="bgColor" value="#aaddff" /></c:if>
                                    <c:if test="${fn:containsIgnoreCase(c.colorName, 'Trắng')}"><c:set var="bgColor" value="#ffffff" /></c:if>
                                    <span class="color-swatch"
                                          onclick="event.preventDefault(); changeCardImage(this)"
                                          data-src="${pageContext.request.contextPath}/${c.imgThumbnail}"
                                          data-link="product-detail?id=${c.productid}"
                                          title="${c.colorName}"
                                          style="background-color: ${bgColor};">
                                    </span>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="product-name">${p.name}</div>
                        <div class="product-price">
                            <c:choose>
                                <c:when test="${p.salePrice > 0}">
                                    <span class="sale-price-text"><fmt:formatNumber value="${p.salePrice}" pattern="#,###"/> đ</span>
                                    <span class="old-price"><fmt:formatNumber value="${p.price}" pattern="#,###"/> đ</span>
                                    <span class="discount-tag">-<fmt:formatNumber value="${(1 - p.salePrice/p.price) * 100}" maxFractionDigits="0"/>%</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="regular-price-text"><fmt:formatNumber value="${p.price}" pattern="#,###"/> đ</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="Special-deal">Hot</div>
                    </a>
                </c:forEach>
            </div>

            <div style="text-align: center; margin: 40px 0;">
                <button id="btn-load-more"
                        data-page="1"
                        data-search="${param.search}"
                        data-cid="${param.cid}"
                        data-totalpages="${totalPages}"
                        style="padding: 12px 30px; background-color: #000; color: #fff; font-weight: bold; cursor: pointer; border: none; transition: 0.3s;">
                    XEM THÊM SẢN PHẨM
                </button>
            </div>
        </div>

            <%-- Lưu ý: Khối <aside id="filter-overlay"> đã được chuyển sang header.jsp ở bước trước --%>

        <jsp:include page="footer.jsp" />

        <script>
            window.contextPath = '${pageContext.request.contextPath}';
        </script>

        <script>
            const btnLoadMore = document.getElementById("btn-load-more");
            const productContainer = document.getElementById("product-container");

            if (btnLoadMore) {
                let totalPages = parseInt(btnLoadMore.getAttribute("data-totalpages"));

                // Ẩn nút nếu chỉ có 1 trang
                if (isNaN(totalPages) || totalPages <= 1) {
                    btnLoadMore.style.display = "none";
                }

                btnLoadMore.addEventListener("click", function() {
                    let currentPage = parseInt(this.getAttribute("data-page"));
                    let nextPage = currentPage + 1;

                    let search = this.getAttribute("data-search") || "";
                    let cid = this.getAttribute("data-cid") || "";

                    this.innerHTML = "ĐANG TẢI...";

                    let url = "${pageContext.request.contextPath}/list-product?ajax=true&page=" + nextPage;
                    if (search) url += "&search=" + search;
                    if (cid) url += "&cid=" + cid;

                    fetch(url)
                        .then(response => response.text())
                        .then(html => {
                            // Chèn thêm sản phẩm mới vào cuối
                            productContainer.insertAdjacentHTML("beforeend", html);

                            this.setAttribute("data-page", nextPage);
                            this.innerHTML = "XEM THÊM SẢN PHẨM";

                            if (nextPage >= totalPages) {
                                this.style.display = "none";
                            }
                        })
                        .catch(err => {
                            console.error("Lỗi:", err);
                            this.innerHTML = "LỖI! THỬ LẠI SAU";
                        });
                });
            }
        </script>

        <script>
            function changeCardImage(element) {
                const productCard = element.closest('.product-item');

                if(!productCard) return;

                const newImgSrc = element.getAttribute('data-src');
                const newProductLink = element.getAttribute('data-link');

                const urlParams = new URLSearchParams(newProductLink.split('?')[1]);
                const newId = urlParams.get('id');

                const img = productCard.querySelector('.product-card-img');
                if (img && newImgSrc) {
                    img.style.opacity = 0.5;
                    setTimeout(() => {
                        img.src = newImgSrc;
                        img.style.opacity = 1;
                    }, 150);
                }

                const links = productCard.querySelectorAll('a[href^="product-detail"]');
                links.forEach(link => {
                    link.setAttribute('href', newProductLink);
                });

                const cartBtn = productCard.querySelector('.cart-icon');
                if (cartBtn && newId) {
                    cartBtn.setAttribute('onclick', 'addToCart(' + newId + ')');
                }
            }
        </script>

        <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

        </body>
        </html>
    </c:otherwise>
</c:choose>