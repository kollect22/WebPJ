<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} | Chi tiết sản phẩm</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

</head>
<body>

<jsp:include page="header.jsp" />

<nav class="breadcrumbs">
    <i class="fa-solid fa-house"></i>
    <a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a> /
    <a href="#">Túi Xách</a> /
    <span>${product.name}</span>
</nav>

<div class="product-page-container">
    <div class="product-layout">

        <section class="product-gallery">
            <div class="thumb-list">
                <c:forEach var="img" items="${product.galleryImages}" varStatus="status">

                    <img src="${pageContext.request.contextPath}/${img}"
                         onclick="changeGalleryImage(this)"
                         class="${status.first ? 'active' : ''}"
                         alt="Thumb ${status.count}">

                </c:forEach>
            </div>

            <div class="main-image-container">
                    <c:if test="${not empty product.galleryImages}">
                    <img id="mainImage"
                         src="${pageContext.request.contextPath}/${product.galleryImages[0]}"
                         alt="${product.name}">
                    </c:if>
            </div>
        </section>


        <div class="product-info-wrapper">
            <aside class="product-info">
                <div class="title-wrapper">
                    <h1>${product.name}</h1>
                    <i class="${wishlistSession != null && wishlistSession.contains(product.id) ? 'fa-solid' : 'fa-regular'} fa-heart"
                           id="wishlist-icon-${product.id}"
                           style="cursor: pointer; font-size: 24px; color: ${wishlistSession != null && wishlistSession.contains(product.id) ? '#d0021b' : ''};"
                           onclick="toggleWishlist('${product.id}')"></i>
                </div>

                <div class="price">
                    <c:choose>
                        <c:when test="${product.salePrice > 0}">

                            <span class="sale-price" style="color: #d0021b; font-weight: bold; font-size: 24px; margin-right: 10px;">
                                <fmt:formatNumber value="${product.salePrice}" type="number" maxFractionDigits="0"/> VNĐ
                            </span>

                            <span class="original-price" style="text-decoration: line-through; color: #888; font-size: 16px;">
                                <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/> VNĐ
                            </span>

                            <span class="discount-percent" style="background: #d0021b; color: white; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 10px; vertical-align: middle;">
                                -<fmt:formatNumber value="${(1 - product.salePrice/product.price) * 100}" maxFractionDigits="0"/>%
                            </span>

                        </c:when>

                        <c:otherwise>
                            <span class="regular-price" style="font-weight: bold; font-size: 24px; color: #000;">
                                <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/> VNĐ
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="option-selector">
                    <span>Kích thước</span>
                    <div class="options">
                        <button class="size-option active">M</button>
                    </div>
                </div>

                <div class="option-selector">
                    <span>Số lượng</span>
                    <div class="quantity-control">
                        <button class="quantity-btn" type="button" onclick="decreaseQty()"><i class="fas fa-minus"></i></button>
                        <input type="text" id="qtyInput" value="1" min="1">
                        <button class="quantity-btn" type="button" onclick="increaseQty()"><i class="fas fa-plus"></i></button>
                    </div>
                </div>

                <form action="add-cart" method="POST">
                    <input type="hidden" name="id" value="${product.id}">
                    <input type="hidden" name="q" id="hiddenQty" value="1">

                    <div class="action-buttons-stack">
                        <button class="btn-buy-now" type="submit" name="action" value="buy">
                                    MUA NGAY
                        </button>

                        <button class="btn-add-cart" type="button" onclick="addToCart(${product.id})">
                                    THÊM VÀO GIỎ HÀNG
                        </button>
                    </div>
                </form>

                <div class="other-colors">
                    <span>Sản phẩm cùng loại khác màu</span>
                    <div class="colors-container">
                        <c:forEach var="related" items="${product.colors}">
                            <a href="product-detail?id=${related.productid}" class="related-thumb" title="${related.colorName}">
                                <img src="${pageContext.request.contextPath}/${related.imgThumbnail}" alt="${related.colorName}">
                            </a>
                        </c:forEach>
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
                                <li>Chiều rộng: ${product.width} cm</li>
                                <li>Chiều sâu: ${product.depth} cm</li>
                                <li>Chiều cao: ${product.height} cm</li>
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
                                <li>Mã sản phẩm: ${product.sku}</li>
                                <li>Chất liệu: ${product.material}</li>
                                <br>
                                <div>${product.description}</div>
                            </ul>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <span>Hướng dẫn bảo quản</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="accordion-content">
                            <h3>I. Vệ Sinh Cơ Bản (Chất liệu thông thường)</h3>
                            <p><strong>Cách 1: Tẩy nhẹ</strong></p>
                            <ul>
                                <li>Sử dụng vải cotton trắng, chấm nhẹ một chút vào nước tẩy nhẹ (hóa chất vệ sinh chuyên dụng).</li>
                                <li>Sau đó lau qua vị trí cần vệ sinh.</li>
                            </ul>
                            <p><strong>Cách 2: Lau ẩm</strong></p>
                            <ul>
                                <li>Sử dụng vải cotton trắng, nhúng vào nước sạch và vắt khô.</li>
                                <li>Sau đó nhẹ nhàng lau qua vị trí cần vệ sinh trên sản phẩm.</li>
                            </ul>

                            <h3>II. Vệ Sinh Theo Chất liệu Đặc Biệt</h3>
                            <p><strong>Đối với chất liệu Microfiber:</strong></p>
                            <p>Có thể sử dụng bàn chải lông mềm và chải nhẹ lên bề mặt sản phẩm để vệ sinh.</p>
                            <p><strong>Đối với chất liệu PC và PVC:</strong></p>
                            <p>Trường hợp sản phẩm bị dính keo, có thể dùng cao su sống để chùi sau khi đã chấm nhẹ nước tẩy nhẹ lên vị trí dính keo.</p>

                            <h3>III. Lưu Ý Quan Trọng</h3>
                            <ul>
                                <li>Không áp dụng các phương pháp trên cho chất liệu lông (*).</li>
                                <li>Không giặt túi bằng bột giặt, các chất tẩy mạnh.</li>
                                <li>Chỉ sử dụng nước hoặc các hóa chất vệ sinh chuyên dụng.</li>
                                <li>Đối với sản phẩm được làm từ chất liệu đặc biệt sẽ có cách thức vệ sinh riêng biệt, bạn vui lòng liên hệ tổng đài CSKH 1900 6909 (Nhấn phím 1) để được hướng dẫn cụ thể.</li>
                            </ul>
                        </div>
                    </div>
                </div>

            </aside>
        </div>
    </div>


    <div class="product-reviews">
        <h2>Đánh giá từ khách hàng</h2>

        <c:choose>
            <c:when test="${not empty sessionScope.auth}">
                <div class="review-form-container" style="background: #f9f9f9; padding: 20px 0; border-radius: 8px; margin-bottom: 20px;">
                    <form action="${pageContext.request.contextPath}/submit-review" method="POST">
                        <input type="hidden" name="productId" value="${product.id}">
                        <input type="hidden" name="rating" id="rating-value" value="5">

                        <div style="margin-bottom: 15px;">
                            <label style="font-weight: bold; margin-right: 10px;">Chất lượng sản phẩm:</label>
                            <span id="star-rating" style="color: #ccc; font-size: 20px; cursor: pointer;">
                            <i class="fa-solid fa-star star-btn active" data-value="1" style="color: #f1c40f;"></i>
                            <i class="fa-solid fa-star star-btn active" data-value="2" style="color: #f1c40f;"></i>
                            <i class="fa-solid fa-star star-btn active" data-value="3" style="color: #f1c40f;"></i>
                            <i class="fa-solid fa-star star-btn active" data-value="4" style="color: #f1c40f;"></i>
                            <i class="fa-solid fa-star star-btn active" data-value="5" style="color: #f1c40f;"></i>
                        </span>
                        </div>

                        <textarea name="comment" rows="4" style="width: 100%; padding: 10px 10px; border: 1px solid #ccc; border-radius: 4px; resize: vertical;" placeholder="Hãy chia sẻ cảm nhận của bạn về sản phẩm này nhé..." required></textarea>

                        <button type="submit" style="margin-top: 10px; padding: 15px; background: #000; color: #fff; border: none; cursor: pointer; font-weight: bold;">GỬI ĐÁNH GIÁ</button>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <div style="background: #fdf2f2; padding: 15px; border-left: 4px solid #d0021b; margin-bottom: 30px;">
                    Vui lòng <a href="${pageContext.request.contextPath}/login.jsp" style="color: #d0021b; font-weight: bold; text-decoration: underline;">Đăng nhập</a> để để lại đánh giá của bạn.
                </div>
            </c:otherwise>
        </c:choose>

        <div class="review-list">
            <c:if test="${empty reviews}">
                <p style="color: #666; font-style: italic;">Chưa có đánh giá nào. Hãy là người đầu tiên đánh giá sản phẩm này!</p>
            </c:if>

            <c:forEach items="${reviews}" var="r">
                <div class="review-item" style="border-bottom: 1px dashed #eee; padding: 15px 0;">
                    <div class="review-header" style="display: flex; justify-content: space-between; margin-bottom: 5px;">
                        <strong style="font-size: 15px;">${r.userName}</strong>
                        <span style="color: #999; font-size: 12px;">${r.createdAt}</span>
                    </div>

                    <div class="review-stars" style="color: #f1c40f; font-size: 13px; margin-bottom: 8px;">
                        <c:forEach begin="1" end="5" var="i">
                            <i class="fa-solid fa-star" style="${i <= r.rating ? '' : 'color: #ccc;'}"></i>
                        </c:forEach>
                    </div>

                    <div class="review-content" style="color: #333; line-height: 1.5;">
                            ${r.comment}
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>


</div>


<jsp:include page="footer.jsp" />
<script>
    window.contextPath = '${pageContext.request.contextPath}';
</script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const stars = document.querySelectorAll(".star-btn");
        const ratingInput = document.getElementById("rating-value");

        stars.forEach(star => {
            star.addEventListener("click", function() {
                let val = parseInt(this.getAttribute("data-value"));
                ratingInput.value = val;

                stars.forEach(s => {
                    if (parseInt(s.getAttribute("data-value")) <= val) {
                        s.style.color = "#f1c40f"; // Màu vàng
                    } else {
                        s.style.color = "#ccc";    // Màu xám
                    }
                });
            });
        });
    });
</script>

<script>
function toggleWishlist(productId) {
    console.log("Đang bấm trái tim cho sản phẩm ID:", productId);

    if (!window.contextPath) {
        alert("Lỗi: Không tìm thấy ContextPath!");
        return;
    }
    const url = window.contextPath + '/wishlist-add?id=' + productId;

    fetch(url)
        .then(response => {
            if (!response.ok) throw new Error('Lỗi Server: ' + response.status);
            return response.json();
        })
        .then(data => {
            console.log("Kết quả từ Servlet:", data);

            // Tìm icon để đổi màu
            const icon = document.getElementById('wishlist-icon-' + productId);
            if (icon) {
                if (data.status === "success") {
                    // Đổi sang trái tim đặc, màu đỏ
                    icon.classList.remove('fa-regular');
                    icon.classList.add('fa-solid');
                    icon.style.color = '#d0021b';
                    alert("Đã thêm vào yêu thích!");
                } else {
                    // Đổi về trái tim rỗng, mất màu
                    icon.classList.remove('fa-solid');
                    icon.classList.add('fa-regular');
                    icon.style.color = '';
                    alert(" Đã xóa khỏi yêu thích!");
                }
            }

            // Cập nhật số lượng trên vòng tròn đỏ (nếu bạn có đặt id="wishlist-count")
            const badge = document.getElementById('wishlist-count');
                if (badge) {
                    badge.innerText = data.count;
                }
        })
        .catch(err => {
            console.error('Lỗi fetch:', err);
            alert("Có lỗi xảy ra, kiểm tra Console (F12) nhé!");
        });
}
</script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmxc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>