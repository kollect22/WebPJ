<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm - Túi Alva</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>

<jsp:include page="../header.jsp" />

<nav class="breadcrumbs">
    <i class="fa-regular fa-house"></i>
    <a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a> /
    <a href="${pageContext.request.contextPath}/products-new.jsp">Hàng mới</a> /
    <span>Túi Alva</span>
</nav>

<div class="product-page-container">

    <div class="product-layout">

        <section class="product-images">
            <img src="${pageContext.request.contextPath}/img/products/tui-alva/anh1.webp" alt="Túi Alva - ảnh 1">
            <img src="${pageContext.request.contextPath}/img/products/tui-alva/anh2.webp" alt="Túi Alva - ảnh 2">
            <img src="${pageContext.request.contextPath}/img/products/tui-alva/anh3.webp" alt="Túi Alva - ảnh 3">
            <img src="${pageContext.request.contextPath}/img/products/tui-alva/anh4.webp" alt="Túi Alva - ảnh 4">
            <img src="${pageContext.request.contextPath}/img/products/tui-alva/anh5.webp" alt="Túi Alva - ảnh 5">
        </section>

        <div class="product-info-wrapper">
            <aside class="product-info">

                <div class="title-wrapper">
                    <h1>Túi xách phom chữ nhật Alva Quilted - Đen</h1>
                    <i class="fa-regular fa-heart"></i>
                </div>
                <div class="price">2.290.000VNĐ</div>

                <div class="option-selector">
                    <span>Kích thước</span>
                    <div class="options">
                        <button class="size-option active">S</button>
                    </div>
                </div>

                <div class="option-selector">
                    <span>Số lượng</span>
                    <div class="quantity-control">
                        <button class="quantity-btn" aria-label="Giảm"><i class="fas fa-minus"></i></button>
                        <input type="text" value="1" min="1" aria-label="Số lượng">
                        <button class="quantity-btn" aria-label="Tăng"><i class="fas fa-plus"></i></button>
                    </div>
                </div>

                <div class="action-buttons">
                    <button class="btn-buy">Mua ngay</button>
                    <button class="btn-add-to-cart">Thêm vào giỏ hàng</button>
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
                            <ul>
                                <li>Hãy đăng nhập để nhận ưu đãi của riêng bạn</li>
                            </ul>
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
                                <li>Trọng lượng: 435 g</li>
                                <li>Chiều dài tay cầm: 7 cm</li>
                                <li>Chiều dài dây đeo: 50-55.5 cm</li>
                                <li>Tổng chiều dài dây: 101-115 cm</li>
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
                                <li>Loại khóa cài: Khóa đẩy</li>
                                <li>Số lượng dây đeo: 1</li>
                                <li>Dây đeo có thể tháo rời: Có thể tháo rời</li>
                                <li>Dây đeo có thể điều chỉnh: Có thể điều chỉnh</li>
                                <li>Ngăn trong: 2 Ngăn bên trong, 3 Ngăn đựng thẻ, 2 Ngăn có khóa kéo</li>
                            </ul>
                        </div>
                    </div>

                    <div class="accordion-item">
                        <div class="accordion-header">
                            <span>Hướng dẫn bảo quản</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="accordion-content">
                            <h3>I. Sử dụng túi xách:</h3>
                            <ul>
                                <li>Tránh quá tải: Không đựng quá nhiều đồ để tránh làm méo phom.</li>
                                <li>Sử dụng lớp lót để giữ sạch bên trong.</li>
                            </ul>
                            <h3>II. Chăm sóc da:</h3>
                            <ul>
                                <li>Lau nhẹ bằng khăn mềm. Tránh tiếp xúc nước hoặc ánh nắng lâu.</li>
                                <li>Đóng khóa cẩn thận sau khi dùng.</li>
                            </ul>
                            <h3>III. Bảo quản:</h3>
                            <p><strong>Lưu trữ:</strong></p>
                            <ul>
                                <li>Bảo quản trong túi vải (dust bag) khi không sử dụng.</li>
                            </ul>
                            <p><strong>Vệ sinh:</strong></p>
                            <ul>
                                <li>Kiểm tra và làm sạch định kỳ để tránh vết bẩn bám lâu ngày.</li>
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