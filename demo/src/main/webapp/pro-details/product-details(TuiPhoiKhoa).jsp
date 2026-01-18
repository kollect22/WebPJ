<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">


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
                <img src="${pageContext.request.contextPath}/img/products/tui-alva/anh1.webp" onclick="changeImage(this)" class="active" alt="Thumb 1">
                <img src="${pageContext.request.contextPath}/img/products/tui-alva/anh2.webp" onclick="changeImage(this)" alt="Thumb 2">
                <img src="${pageContext.request.contextPath}/img/products/tui-alva/anh3.webp" onclick="changeImage(this)" alt="Thumb 3">
                <img src="${pageContext.request.contextPath}/img/products/tui-alva/anh4.webp" onclick="changeImage(this)" alt="Thumb 4">
                <img src="${pageContext.request.contextPath}/img/products/tui-alva/anh5.webp" onclick="changeImage(this)" alt="Thumb 5">
            </div>

            <div class="main-image-container">
                <img id="mainImage" src="${pageContext.request.contextPath}/img/products/tui-alva/anh1.webp" alt="Ảnh chính">
            </div>
        </section>


        <div class="product-info-wrapper">
            <aside class="product-info">
                <div class="title-wrapper">
                    <h1>Túi xách tay nhấn đường cong phối khóa kim loại - TOT 0202 - Màu be</h1>
                    <i class="fa-regular fa-heart"></i>
                </div>

                <div class="price">1.205.000VNĐ</div>

                <div class="option-selector">
                    <span>Kích thước</span>
                    <div class="options">
                        <button class="size-option active">M</button>
                    </div>
                </div>

                <div class="option-selector">
                    <span>Số lượng</span> <div class="quantity-control">
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
                        <a href="#" class="color-swatch">
                            <img src="${pageContext.request.contextPath}/img/products/tui-alva/kem1.webp" alt="Màu kem">
                        </a>
                        <a href="#" class="color-swatch">
                            <img src="${pageContext.request.contextPath}/img/products/tui-alva/bac1.webp" alt="Màu bạc">
                        </a>
                        <a href="#" class="color-swatch">
                            <img src="${pageContext.request.contextPath}/img/products/tui-alva/xanh1.webp" alt="Màu xanh">
                        </a>
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
                                <li>Chiều rộng: 20.5 cm</li>
                                <li>Chiều sâu: 8 cm</li>
                                <li>Chiều cao: 13 cm</li>
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
                                <li>Mã sản phẩm: CK2-50701578_BLACK_S-VN</li>
                                <li>Chất liệu: Da cừu Nappa nhân tạo</li>
                            </ul>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <span>Hướng dẫn bảo quản</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="accordion-content">
                            <ul><li>Tránh tiếp xúc nước, lau bằng khăn mềm.</li></ul>
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