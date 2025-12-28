<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Túi xách</title>
    <link rel="stylesheet" href="demo/src/main/webapp/WEB-INF/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"/>
    <style>
        body{
            font-family: Arial, sans-serif;
            color: white;
            background-color: #1A1A1A; /* Nền tối */
        }
        a {
            text-decoration: none;
            color: white;
        }

        li{
            list-style: none;
        }

        /* --- BREADCRUMBS --- */
        .breadcrumbs{
            color: #888;
            margin: 20px 40px 25px 40px;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        .breadcrumbs i{
            color: #f0f0f0;
        }
        .breadcrumbs a{
            text-decoration: none;
            color: #f0f0f0;
        }

        .breadcrumbs a:hover{
            text-decoration: underline;
        }

        .shop-container{
            padding:0 40px;
            margin-bottom: 50px;
        }

        /* --- FILTER BAR --- */
        .filter-bar{
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            margin-bottom: 20px;
            padding-bottom: 15px;
        }

        .filter-btn {
            background: none;
            height: 38px;
            border: 1px solid #555;
            border-radius: 30px;
            color: white;
            padding: 10px 20px;
            display: flex;
            align-items: center ;
            gap: 10px;
            cursor: pointer;
            transition: 0.3s;
        }

        .filter-btn:hover {
            background: #333;
            border-color: #fff;
        }

        #select-sort{
            background-color: #1A1A1A;
            height: 38px;
            border: 1px solid #555;
            color: white;
            padding: 0 20px;
            border-radius: 30px;
            outline: none;
            cursor: pointer;
            transition: 0.3s;
        }

        /* --- PRODUCT GRID --- */
        .product-cat-list{
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 cột */
            gap: 20px;
        }

        a.product-item {
            display: block;
            position: relative;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }

        .product-item img {
            width: 100%;
            height: 350px;
            object-fit: cover;
            border-radius: 15px;
            box-sizing: border-box;
            transition: transform 0.3s ease;
        }

        .product-item:hover img {
            transform: scale(1.03); /* Zoom nhẹ khi hover */
        }

        .product-name {
            font-size: 20px;
            margin-top: 15px;
            font-weight: 500;
            line-height: 1.4;

        }

        .product-price {
            margin-top: 8px;
            color: #ccc;
            font-size: 16px;
        }

        .cart-icon {
            position: absolute;
            top: 15px;
            right: 15px;
            font-size: 18px;
            color: white;
            background-color: #000;
            padding: 10px;
            border-radius: 50%;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 2;
        }

        .product-item:hover .cart-icon {
            opacity: 1;
        }

        .filter-sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 400px;
            max-width: 85%;
            height: 100%;
            background-color: #111;
            box-shadow: -5px 0 15px rgba(0,0,0,0.5);

            transform: translateX(-100%);
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 1002;
        }

        .filter-sidebar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 30px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .filter-sidebar-header h2 {
            margin: 0;
            font-size: 18px;
            text-transform: uppercase;
            font-weight: 600;
            color: #fff;
        }

        .filter-sidebar-header button {
            background: none;
            border: none;
            color: #888;
            font-size: 24px;
            cursor: pointer;
            transition: 0.3s;
        }
        .filter-sidebar-header button:hover {
            color: #fff;
            transform: rotate(90deg);
        }

        .filter-sidebar-body {
            padding: 10px 30px;
        }

        .categories-list {
            padding-left: 0;
            margin-top: 10px;
        }

        .categories-list li {
            margin-bottom: 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .categories-list a {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 0;
            color: #ccc;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        .categories-list a:hover {
            color: #fff;
            padding-left: 10px;
        }

        .categories-list a::after {
            content: "\f054";
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            font-size: 12px;
            color: #555;
            transition: color 0.3s;
        }
        .categories-list a:hover::after {
            color: #fff;
        }

        .filter-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 1001;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            backdrop-filter: blur(2px);
        }

        .filter-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        .filter-overlay.active .filter-sidebar {
            transform: translateX(0);
        }
    </style>
</head>
<body>
<div id="header"></div>
<section class="banner">
    <img src="../../../../img/banner%20hlw.jpg" />
    <div class="banner-text">
        <h2>Ưu đãi Haloween</h2>
        <a href="halloween-sales.html">Xem Ngay</a>
    </div>
</section>

<nav class="breadcrumbs">
    <i class="fa-regular fa-house"></i>
    <a href="demo/src/main/webapp/index.html">Trang chủ</a> / <a>Sản phẩm</a> / <span>Túi xách</span>
</nav>

<div class="shop-container">
    <div class="filter-bar">
        <button class="filter-btn" id="filter-toggle-btn">
            <i class="fa-solid fa-list"></i> Bộ lọc </button>

        <select id="select-sort">
            <option value="newest">Mới nhất</option>
            <option value="oldest">Cũ nhất</option>
            <option value="price-asc">Giá tăng dần</option>
            <option value="price-desc">Giá giảm dần</option>
        </select>
    </div>

    <div class="product-cat-list">

        <a href="../../../../pro-details/product-details1.html" class="product-item">
            <img src="../../../../img/túi%20xách%20nâu%20cá%20tính/a3.jpg" alt="Túi Nâu"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Xách Nâu Cá Tính SBM395</div>
            <div class="product-price">1.850.000VNĐ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/tui-enola/anh1.webp" alt="Túi Enola"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Enola Canvas Two-Tone</div>
            <div class="product-price">1.890.000VNĐ</div>
        </a>

        <a href="../../../../pro-details/product-details2.html" class="product-item">
            <img src="../../../../img/túi%20da/a1.jpeg" alt="Túi da dây xích"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi xách nữ dây xích H1355</div>
            <div class="product-price">500.000VNĐ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/túi%20da%20ca%20sấu/a1.jpeg" alt="Túi cá sấu"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi da cá sấu cao cấp TX57</div>
            <div class="product-price">5.500.000VNĐ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/túi%20da%20PU/a2.webp" alt="Túi da PU"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Xách Tay Nữ N10</div>
            <div class="product-price">1.750.000VNĐ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/tui-trice/anh1.webp" alt="Túi Trice"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi đeo vai Trice - Trắng</div>
            <div class="product-price">1.250.000đ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/tui-alva/xanh1.webp" alt="Túi Alva"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi xách Alva - Xanh Mint</div>
            <div class="product-price">1.450.000đ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/tui-mirabelle/hong1.webp" alt="Túi Mirabelle"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Mirabelle - Hồng Phấn</div>
            <div class="product-price">1.320.000đ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/tui-noane/xam1.webp" alt="Túi Noane"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Noane Phom Hộp - Xám</div>
            <div class="product-price">1.180.000đ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/túi%20clutch/2023-L6-CK2-70160131-01-1.webp" alt="Túi clutch"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Clutch Cầm Tay - Đen</div>
            <div class="product-price">1.850.000đ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/túi%20da/a2.jpeg" alt="Túi da"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Da Thời Trang - Be</div>
            <div class="product-price">1.450.000đ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/túi%20da%20thật/a1.jpg" alt="Túi da thật"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Da Thật Cao Cấp</div>
            <div class="product-price">1.350.000đ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/Túi%20đv%20adalyn/2025-L7-CK2-20782753-01-5.webp" alt="Túi Adalyn"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Đeo Vai Adalyn</div>
            <div class="product-price">1.590.000đ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/túi%20xách%20handmade/a1.jpg" alt="Túi Handmade"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Xách Handmade - Hồng</div>
            <div class="product-price">1.150.000đ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/tui-britton/den1.webp" alt="Túi Britton"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Britton Khóa Kim Loại</div>
            <div class="product-price">1.690.000đ</div>
        </a>

        <a href="../../../../pro-details/product-details19.html" class="product-item">
            <img src="../../../../img/túi%20hàng%20hiệu/a1.jpg" alt="Túi hàng hiệu"/>
            <div class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div class="product-name">Túi Xách Thời Trang Cao Cấp</div>
            <div class="product-price">850.000VNĐ</div>
        </a>

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
                <li><a href="products-category-all.jsp" >Tất cả sản phẩm</a></li>
                <li><a href="products-cat-handbag.html" >Túi xách</a></li>
                <li><a href="products-cat-accessory.jsp" >Phụ kiện</a></li>
            </ul>
        </div>
    </div>
</aside>

<div id="footer"></div>

<script src="../../../../script.js"></script>
</body>
</html>