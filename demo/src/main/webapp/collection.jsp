<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Bộ sưu tập theo mùa - Fashion Store</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

  <style>
    * {
      box-sizing: border-box;
    }

    body {
      background: white;
      max-width: 1920px;
      margin: 0;
      font-family: Arial, sans-serif;
    }

    /* =========================================
       1. STYLE CHO BREADCRUMB
       ========================================= */
    .container-breadcrumbs {
      margin-top: 110px;
      padding: 0 40px;
      margin-bottom: 20px;
      max-width: 1920px;
      margin-left: auto;
      margin-right: auto;
    }
    .breadcrumbs {
      display: flex;
      align-items: center;
      color: #666;
      font-size: 14px;
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
    }
    .breadcrumbs i,
    .breadcrumbs a {
      color: #333;
      text-decoration: none;
      transition: color 0.3s ease;
      margin-right: 5px;
    }
    .breadcrumbs a:hover {
      text-decoration: underline;
      text-underline-offset: 4px;
      color: #000;
    }
    .breadcrumbs span {
      color: #999;
      margin-left: 5px;
    }

    /* =========================================
       2. STYLE CHO CÁC KHỐI THEO MÙA
       ========================================= */
    .season-collection {
      width: 90%;
      margin: auto;
      padding: 20px 0;
    }
    .season-block {
      padding: 40px 20px;
      margin-bottom: 60px;
      border-radius: 18px;
    }
    .spring { background: linear-gradient(135deg, #ffe3ff55, #fff0d455); border: 1px solid #ffffff3b; }
    .summer { background: linear-gradient(135deg, #fff0ae44, #ffb75e55); border: 1px solid #ffffff3b; }
    .fall { background: linear-gradient(135deg, #d1913c66, #ffd19455); border: 1px solid #ffffff3b; }
    .winter { background: linear-gradient(135deg, #83a4d455, #b6fbff55); border: 1px solid #ffffff3b; }

    .season-title {
      text-align: center;
      font-size: 32px;
      margin-bottom: 30px;
      font-weight: 700;
      letter-spacing: 1px;
    }

    /* =========================================
       3. LƯỚI SẢN PHẨM & CARD SẢN PHẨM
       ========================================= */
    .product-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 25px;
    }

    .product-card {
      background: rgba(255, 255, 255, 0.5);
      padding: 15px;
      border-radius: 12px;
      text-align: center;
      display: block;
      text-decoration: none !important;
      color: inherit !important;
      border: none;
      box-shadow: 0 2px 10px rgba(0,0,0,0.03);
      transition: all 0.3s ease;
    }
    .product-card:hover {
      transform: translateY(-5px);
      background: #ffffff;
      box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    }
    .product-card img {
      width: 100%;
      height: auto;
      aspect-ratio: 4/5;
      object-fit: contain;
      background-color: #fff;
      border-radius: 8px;
      margin-bottom: 15px;
    }
    .product-card h3 {
      margin: 0 0 8px 0;
      font-size: 18px;
      font-weight: 600;
      color: #333;
      line-height: 1.4;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }
    .price {
      font-size: 15px;
      color: #ff4d6d;
      font-weight: 600;
      margin: 0;
    }
  </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container-breadcrumbs">
  <nav class="breadcrumbs">
    <i class="fa-solid fa-house"></i>
    <a href="${pageContext.request.contextPath}/home">Trang chủ</a> /
    <span>Bộ sưu tập theo mùa</span>
  </nav>
</div>

<section class="season-collection">

  <div class="season-block spring">
    <h2 class="season-title">SPRING COLLECTION</h2>
    <div class="product-grid">
      <a href="${pageContext.request.contextPath}/product-detail?id=58" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-hoa-pastel.jpg" alt="Túi Mini Hoa Hồng">
        <h3>Túi Mini Hoa Hồng</h3>
        <p class="price">380.000đ</p>
      </a>
      <a href="${pageContext.request.contextPath}/product-detail?id=60" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-kep-hong.webp" alt="Túi Kẹp Nách Trần Bông">
        <h3>Túi Kẹp Nách Trần Bông</h3>
        <p class="price">380.000đ</p>
      </a>
      <a href="${pageContext.request.contextPath}/product-detail?id=53" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-deo-cheo-pastel.jpg" alt="Túi Đeo Chéo Pastel">
        <h3>Túi Đeo Chéo Pastel</h3>
        <p class="price">320.000đ</p>
      </a>
    </div>
  </div>

  <div class="season-block summer">
    <h2 class="season-title">SUMMER COLLECTION</h2>
    <div class="product-grid">
      <a href="${pageContext.request.contextPath}/product-detail?id=55" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-di-bien.jpg" alt="Túi Đi Biển">
        <h3>Túi Đi Biển</h3>
        <p class="price">250.000đ</p>
      </a>
      <a href="${pageContext.request.contextPath}/product-detail?id=54" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-det-tay.jfif" alt="Túi Dệt Tay">
        <h3>Túi Dệt Tay</h3>
        <p class="price">550.000đ</p>
      </a>
      <a href="${pageContext.request.contextPath}/product-detail?id=62" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-nang-dong.webp" alt="Túi Cói Dáng Tròn">
        <h3>Túi Cói Dáng Tròn</h3>
        <p class="price">710.000đ</p>
      </a>
    </div>
  </div>

  <div class="season-block fall">
    <h2 class="season-title">FALL COLLECTION</h2>
    <div class="product-grid">
      <a href="${pageContext.request.contextPath}/product-detail?id=52" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-da-nau.jpg" alt="Túi Da Nâu">
        <h3>Túi Da Nâu</h3>
        <p class="price">650.000đ</p>
      </a>
      <a href="${pageContext.request.contextPath}/product-detail?id=65" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-xach-da-vintage.jpg" alt="Túi Tay Vintage">
        <h3>Túi Đeo Chéo Da Sáp</h3>
        <p class="price">650.000đ</p>
      </a>
      <a href="${pageContext.request.contextPath}/product-detail?id=61" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-3.webp" alt="Túi Đeo Chéo Thu">
        <h3>Túi Đeo Chéo Thu</h3>
        <p class="price">690.000đ</p>
      </a>
    </div>
  </div>

  <div class="season-block winter">
    <h2 class="season-title">WINTER COLLECTION</h2>
    <div class="product-grid">
      <a href="${pageContext.request.contextPath}/product-detail?id=61" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-long.webp" alt="Túi Lông Ấm">
        <h3>Túi Lông Ấm</h3>
        <p class="price">910.000đ</p>
      </a>
      <a href="${pageContext.request.contextPath}/product-detail?id=63" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-da-den.jpg" alt="Túi Da Đen">
        <h3>Túi Da Đen Sang Trọng</h3>
        <p class="price">1.050.000đ</p>
      </a>
      <a href="${pageContext.request.contextPath}/product-detail?id=64" class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-kep-dong.jpg" alt="Túi Kẹp Mùa Đông">
        <h3>Túi Kẹp Mùa Đông</h3>
        <p class="price">880.000đ</p>
      </a>
    </div>
  </div>

</section>

<jsp:include page="footer.jsp" />

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

</body>
</html>