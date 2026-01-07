<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"/>
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

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-deo-vai/anh1.jpg" alt="Túi đeo vai màu be"/>
            <a href="add-cart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi đeo vai nhấn khóa - Be</div>
            <div class="product-price">
                <span class="new-price">1.135.250đ</span>
                <span class="old-price">1.195.000đ</span>
            </div>
            <div class="Special-deal">Giảm 5%</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-TOT0211/anh1.jpg" alt="Túi xách màu nâu"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi xách đai khoá - Nâu</div>
            <div class="product-price">
                <span class="new-price">1.154.250đ</span>
                <span class="old-price">1.215.000đ</span>
            </div>
            <div class="Special-deal">Giảm 5%</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-TOT0206/anh1.jpg" alt="Túi mini đỏ"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi xách tay mini tối giản - Đỏ</div>
            <div class="product-price">
                <span class="new-price">1.030.750đ</span>
                <span class="old-price">1.085.000đ</span>
            </div>
            <div class="Special-deal">Giảm 5%</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-SHO0303/anh1.jpg" alt="Túi mini đỏ"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi đeo vai hình thang - Hồng</div>
            <div class="product-price">
                <span class="new-price">1.425.000đ</span>
                <span class="old-price">1.500.000đ</span>
            </div>
            <div class="Special-deal">Giảm 5%</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-SHO0298/anh1.jpg" alt="Túi Hobo xanh lá"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi Hobo phối xích - Xanh lá</div>
            <div class="product-price">
                <span class="new-price">1.059.250đ</span>
                <span class="old-price">1.115.000đ</span>
            </div>
            <div class="Special-deal">Giảm 5%</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-deo-cheo/anh1.jpg" alt="Túi đeo chéo kem"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi đeo chéo nắp gập - Kem</div>
            <div class="product-price">
                <span class="new-price">973.750đ</span>
                <span class="old-price">1.025.000đ</span>
            </div>
            <div class="Special-deal">Giảm 5%</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-quai-doi/a1.jpg" alt="Túi xách Olive"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi xách quai đôi - Olive</div>
            <div class="product-price">
                <span class="new-price">1.211.250đ</span>
                <span class="old-price">1.275.000đ</span>
            </div>
            <div class="Special-deal">Giảm 5%</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-day-rut/anh1.jpg" alt="Túi dây rút đen"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi đeo vai dây rút - Đen</div>
            <div class="product-price">
                <span class="new-price">1.591.250đ</span>
                <span class="old-price">1.675.000đ</span>
            </div>
            <div class="Special-deal">Giảm 5%</div>
        </div>
    </div>
    <button class="scroll-right"><i class="fa-solid fa-angle-right"></i></button>
</section>

<section class="products">
    <h2>Hàng mới về</h2>
    <button class="scroll-left"><i class="fa-solid fa-angle-left"></i></button>
    <div class="product-list">

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-trice/anh1.webp" alt="Túi Trice"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi đeo vai Trice - Trắng</div>
            <div class="product-price">1.250.000đ</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-alva/xanh1.webp" alt="Túi Alva"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi xách Alva - Xanh</div>
            <div class="product-price">1.450.000đ</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-mirabelle/hong1.webp" alt="Túi Mirabelle"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi Mirabelle - Hồng Phấn</div>
            <div class="product-price">1.320.000đ</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-noane/xam1.webp" alt="Túi Noane"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi Noane Phom Hộp - Xám</div>
            <div class="product-price">1.180.000đ</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-mirabelle/nau1.webp" alt="Túi Mirabelle Nâu"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi Mirabelle - Nâu Tây</div>
            <div class="product-price">1.320.000đ</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-double-handle/DEN1.webp"
                 alt="Túi Double Handle"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi xách Double Handle - Đen</div>
            <div class="product-price">1.550.000đ</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-day-rut/anh1.jpg" alt="Túi Bucket"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi Bucket Dây Rút - Be</div>
            <div class="product-price">980.000đ</div>
        </div>

        <div class="product-item">
            <img src="${pageContext.request.contextPath}/img/products/tui-britton/den1.webp" alt="Túi Britton"/>
            <a href="AddCart?id=${p.id}&q=1" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <div class="product-name">Túi Britton Khóa Kim Loại</div>
            <div class="product-price">1.690.000đ</div>
        </div>

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