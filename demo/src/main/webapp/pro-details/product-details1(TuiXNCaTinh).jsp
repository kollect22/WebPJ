<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chi tiết sản phẩm - SBM395</title>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">

</head>
<body>

<jsp:include page="../header.jsp" />

<nav class="breadcrumbs">
  <i class="fa-solid fa-house"></i>
  <a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a> /
  <a href="#">Túi Xách</a> /
  <span>Túi Xách Vừa</span>
</nav>

<div class="product-page-container">
  <div class="product-layout">

    <section class="product-gallery">
      <div class="thumb-list">
        <img src="${pageContext.request.contextPath}/img/products/tui-xach-nau-ca-tinh/a1.jpg" onclick="changeImage(this)" class="active" alt="SBM395 - 1">
        <img src="${pageContext.request.contextPath}/img/products/tui-xach-nau-ca-tinh/a2.jpg" onclick="changeImage(this)" alt="SBM395 - 2">
        <img src="${pageContext.request.contextPath}/img/products/tui-xach-nau-ca-tinh/a3.jpg" onclick="changeImage(this)" alt="SBM395 - 3">
        <img src="${pageContext.request.contextPath}/img/products/tui-xach-nau-ca-tinh/a4.jpg" onclick="changeImage(this)" alt="SBM395 - 4">
      </div>

      <div class="main-image-container">
        <img id="mainImage" src="${pageContext.request.contextPath}/img/products/tui-xach-nau-ca-tinh/a1.jpg" alt="Ảnh chính">
      </div>
    </section>

    <div class="product-info-wrapper">
      <aside class="product-info">

        <div class="title-wrapper">
          <h1>Túi Xách Nữ Da Đeo Chéo & Xách Tay Đựng Laptop & Hồ Sơ SBM395</h1>
          <i class="fa-regular fa-heart"></i>
        </div>

        <div class="price">1.850.000VNĐ</div>

        <div class="option-selector">
          <span>Kích thước</span>
          <div class="options">
            <button class="size-option active">Free size</button>
          </div>
        </div>

        <div class="option-selector">
          <span>Số lượng</span>
          <div class="quantity-control">
            <button class="quantity-btn" type="button"><i class="fas fa-minus"></i></button>
            <input type="text" value="1" min="1">
            <button class="quantity-btn" type="button"><i class="fas fa-plus"></i></button>
          </div>
        </div>

        <div class="action-buttons-stack">
          <button class="btn-buy-now">MUA NGAY</button>
          <button class="btn-add-cart">THÊM VÀO GIỎ HÀNG</button>
        </div>

        <div class="other-colors">
          <span>Sản phẩm cùng loại khác màu</span>
          <div class="colors-container">
            <span style="font-size: 13px; color: #666;">(Hiện chưa có màu khác)</span>
          </div>
        </div>

        <div class="accordion-section">
          <div class="accordion-item">
            <div class="accordion-header">
              <span>Ưu đãi của bạn</span>
              <i class="fas fa-chevron-down"></i>
            </div>
            <div class="accordion-content">
              <ul><li>Hãy đăng nhập để nhận ưu đãi của riêng bạn</li></ul>
            </div>
          </div>

          <div class="accordion-item">
            <div class="accordion-header">
              <span>Kích thước sản phẩm</span>
              <i class="fas fa-chevron-down"></i>
            </div>
            <div class="accordion-content">
              <ul>
                <li>Size: Ngang 35cm x Cao 25cm x Dày 12cm</li>
                <li>Chức năng: Túi da đeo chéo, Túi da thật, Túi da đựng ipad, túi doanh nhân công sở, Túi Da Xách Tay Nữ, Túi Da Đựng Ipad, Túi da đựng laptop...</li>
              </ul>
            </div>
          </div>

          <div class="accordion-item">
            <div class="accordion-header">
              <span>Mô tả sản phẩm</span>
              <i class="fas fa-chevron-down"></i>
            </div>
            <div class="accordion-content">
              <ul>
                <li>Mã sản phẩm: SBM395</li>
                <li>Loại sản phẩm: Túi Xách Vừa</li>
                <li>Kích thước: Ngang 35cm x Cao 25cm x Dày 12cm</li>
                <li>Chất liệu: Da bò thật</li>
                <li>Chất liệu dây đeo: Da bò thật</li>
                <li>Kiểu khóa: Khóa kéo</li>
                <li>Số ngăn: 1 ngăn lớn</li>
                <li>Kích cỡ: Free size</li>
                <li>Phù hợp sử dụng: Đi làm, đi chơi</li>
              </ul>
            </div>
          </div>

          <div class="accordion-item">
            <div class="accordion-header">
              <span>Hướng dẫn bảo quản</span>
              <i class="fas fa-chevron-down"></i>
            </div>
            <div class="accordion-content">
              <h3>I. Vệ Sinh Cơ Bản</h3>
              <p><strong>Cách 1: Tẩy nhẹ</strong></p>
              <ul>
                <li>Sử dụng vải cotton trắng, chấm nhẹ một chút vào nước tẩy nhẹ.</li>
                <li>Lau qua vị trí cần vệ sinh.</li>
              </ul>
              <p><strong>Cách 2: Lau ẩm</strong></p>
              <ul>
                <li>Sử dụng vải cotton trắng, nhúng nước sạch, vắt khô và lau nhẹ.</li>
              </ul>
              <h3>II. Lưu Ý Quan Trọng</h3>
              <ul>
                <li>Không giặt túi bằng bột giặt, các chất tẩy mạnh.</li>
                <li>Chỉ sử dụng nước hoặc hóa chất vệ sinh chuyên dụng cho da thật.</li>
              </ul>
            </div>
          </div>
        </div>

      </aside>
    </div>
  </div>
</div>

<jsp:include page="../footer.jsp" />

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>



</body>
</html>