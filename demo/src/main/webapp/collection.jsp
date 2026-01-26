<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Bộ sưu tập theo mùa - Fashion Store</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

  <style>
      *{
          box-sizing: border-box;
      }

      body{
          background: white;
          padding-top: 90px;
          margin: 0;
          font-family: Arial, sans-serif;
      }

      .season-collection {
          width: 90%;
          margin: auto;
          padding: 40px 0;
      }

      .season-block {
          padding: 40px 20px;
          margin-bottom: 60px;
          border-radius: 18px;
          color: white;
      }
      
      .spring {
          background: linear-gradient(135deg, #ffe3ff55, #fff0d455);
          border: 1px solid #ffffff3b;
      }
      .summer {
          background: linear-gradient(135deg, #fff0ae44, #ffb75e55);
          border: 1px solid #ffffff3b;
      }
      .fall {
          background: linear-gradient(135deg, #d1913c66, #ffd19455);
          border: 1px solid #ffffff3b;
      }
      .winter {
          background: linear-gradient(135deg, #83a4d455, #b6fbff55);
          border: 1px solid #ffffff3b;
      }

      .season-title {
          text-align: center;
          font-size: 32px;
          margin-bottom: 30px;
          font-weight: 700;
          letter-spacing: 1px;
      }

      /* Lưới sản phẩm */
      .product-grid {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          gap: 25px;
      }

      /* Card sản phẩm */
      .product-card {
          background: rgba(255,255,255,0.06);
          padding: 15px;
          border-radius: 12px;
          text-align: center;
          backdrop-filter: blur(4px);
          transition: 0.3s;
          border: 1px solid #ffffff22;
      }

      .product-card:hover {
          transform: translateY(-6px);
          box-shadow: 0 8px 20px rgba(0,0,0,0.4);
          border-color: #ffffff55;
      }

      .product-card img {
          width: 100%;
          height: 300px;
          object-fit: cover;
          border-radius: 12px;
      }

      .product-card h3 {
          margin: 10px 0 5px;
          font-size: 18px;
          font-weight: 600;
          color: white;
      }

      .price {
          font-size: 17px;
          color: #ff4d6d;
          font-weight: bold;
      }

  </style>
</head>
<body>

<jsp:include page="header.jsp" />

<section class="season-collection">

  <!-- SPRING -->
  <div class="season-block spring">
    <h2 class="season-title">SPRING COLLECTION</h2>

    <div class="product-grid">
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-hoa-pastel.jpg" alt="Túi Hoa Pastel">
        <h3>Túi Hoa Pastel</h3>
        <p class="price">650.000đ</p>
      </div>
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-kep-hong.webp" alt="Túi Kẹp Mùa Xuân">
        <h3>Túi Kẹp Mùa Xuân</h3>
        <p class="price">720.000đ</p>
      </div>
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-deo-cheo-pastel.jpg" alt="Túi Đeo Chéo">
        <h3>Túi Đeo Chéo Nhẹ</h3>
        <p class="price">490.000đ</p>
      </div>
    </div>
  </div>

  <!-- SUMMER -->
  <div class="season-block summer">
    <h2 class="season-title">SUMMER COLLECTION</h2>

    <div class="product-grid">
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-di-bien.jpg" alt="Túi Đi Biển">
        <h3>Túi Đi Biển</h3>
        <p class="price">580.000đ</p>
      </div>
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-det-tay.jfif" alt="Túi Dệt Tay">
        <h3>Túi Dệt Tay</h3>
        <p class="price">620.000đ</p>
      </div>
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-nang-dong.webp" alt="Túi Năng Động">
        <h3>Túi Năng Động</h3>
        <p class="price">710.000đ</p>
      </div>
    </div>
  </div>

  <!-- FALL -->
  <div class="season-block fall">
    <h2 class="season-title">FALL COLLECTION</h2>

    <div class="product-grid">
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-da-nau.jpg" alt="Túi Da Nâu">
        <h3>Túi Da Nâu</h3>
        <p class="price">840.000đ</p>
      </div>
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-xach-da-vintage.jpg" alt="Túi Tay Vintage">
        <h3>Túi Tay Vintage</h3>
        <p class="price">760.000đ</p>
      </div>
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-3.webp" alt="Túi Đeo Chéo Thu">
        <h3>Túi Đeo Chéo Thu</h3>
        <p class="price">690.000đ</p>
      </div>
    </div>
  </div>

  <!-- WINTER -->
  <div class="season-block winter">
    <h2 class="season-title">WINTER COLLECTION</h2>

    <div class="product-grid">
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-long.webp" alt="Túi Lông Ấm">
        <h3>Túi Lông Ấm</h3>
        <p class="price">910.000đ</p>
      </div>
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-da-den.jpg" alt="Túi Da Đen">
        <h3>Túi Da Đen Sang Trọng</h3>
        <p class="price">1.050.000đ</p>
      </div>
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/img/products/tui-kep-dong.jpg" alt="Túi Kẹp Mùa Đông">
        <h3>Túi Kẹp Mùa Đông</h3>
        <p class="price">880.000đ</p>
      </div>
    </div>
  </div>

</section>

<jsp:include page="footer.jsp" />


<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

</body>
</html>
