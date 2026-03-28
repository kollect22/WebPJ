<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm yêu thích - Fashion Store</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

    <style>
        :root {
            --primary-color: #000;
            --accent-color: #d0021b;
            --bg-gray: #f9f9f9;
            --border-color: #f1f1f1;
        }

        .wishlist-page {
            max-width: 1200px;
            margin: 80px auto; /* Tăng khoảng cách với Header */
            padding: 0 20px;
            min-height: 60vh;
        }

        .wishlist-page h2 {
            font-family: 'Playfair Display', serif; /* Nếu bạn có font này nhìn sẽ rất sang */
            font-size: 28px;
            font-weight: 400;
            letter-spacing: 3px;
            margin-bottom: 50px;
            text-align: center;
            text-transform: uppercase;
        }

        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 40px 25px; /* Tăng khoảng cách giữa các hàng */
        }

        .wishlist-item {
            position: relative;
            transition: transform 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
        }

        .wishlist-item:hover {
            transform: translateY(-8px);
        }

        /* Khung ảnh sản phẩm */
        .wishlist-item .img-container {
            position: relative;
            width: 100%;
            padding-top: 133%; /* Tỉ lệ 3:4 chuẩn thời trang */
            overflow: hidden;
            background: var(--bg-gray);
        }

        .wishlist-item img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s ease;
        }

        .wishlist-item:hover img {
            transform: scale(1.05);
        }

        /* Thông tin sản phẩm */
        .wishlist-item .item-info {
            padding: 20px 5px;
            text-align: left; /* Căn lề trái nhìn sẽ sang hơn căn giữa */
        }

        .wishlist-item h3 {
            font-size: 14px;
            font-weight: 500;
            margin: 0 0 8px;
            color: #111;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .wishlist-item .price {
            font-size: 15px;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 15px;
        }


        .wishlist-actions {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .btn-action {
            width: 100%;
            padding: 12px;
            font-size: 11px;
            font-weight: bold;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            cursor: pointer;
            transition: 0.3s ease;
            border: 1px solid var(--primary-color);
        }

        /* Style chung cho cả 2 nút */
        .btn-add-cart, .btn-buy-now {
            width: 100%;
            padding: 12px;
            font-size: 11px;
            font-weight: bold;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            cursor: pointer;
            transition: 0.3s ease;
            border: 1px solid var(--primary-color);
            margin-bottom: 5px;
            display: block;
        }


        .btn-add-cart {
            background: var(--primary-color);
            color: #fff;
        }

        .btn-add-cart:hover {
            background: #333;
            border-color: #333;
        }


        .btn-buy-now {
            background: #fff;
            color: #000;
        }

        .btn-buy-now:hover {
            background: #f8f8f8;
            color: var(--accent-color);
            border-color: var(--accent-color);
        }

        .btn-remove {
            background: transparent;
            color: #888;
            border: 1px solid #ddd;
            font-weight: 400;
        }

        .btn-remove:hover {
            color: var(--accent-color);
            border-color: var(--accent-color);
        }


        .remove-corner {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 30px;
            height: 30px;
            background: rgba(255,255,255,0.9);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 10;
            transition: 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .remove-corner:hover {
            background: var(--accent-color);
            color: white;
        }


        .empty-state {
            text-align: center;
            padding: 100px 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }


        .empty-state i {
            font-size: 80px;
            color: #f1f1f1;
            margin-bottom: 10px;
        }


        .empty-state p {
            font-size: 16px;
            color: #666;
            letter-spacing: 1px;
            margin: 0;
        }


        .btn-continue {
            display: inline-block;
            margin-top: 15px;
            padding: 15px 40px;
            background-color: #000;
            color: #fff !important;
            text-decoration: none !important;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 2px;
            transition: all 0.3s ease;
            border: 1px solid #000;
        }

        .btn-continue:hover {
            background-color: #fff;
            color: #000 !important;
            border-color: #000;
        }

    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="wishlist-page">
    <h2><i class="fa-solid fa-heart" style="color: #d0021b;"></i> Danh sách yêu thích</h2>

    <c:choose>
        <%-- Kiểm tra danh sách wishlistProducts từ Servlet gửi sang --%>
        <c:when test="${empty wishlistProducts}">
            <div class="empty-state">
                <i class="fa-regular fa-heart"></i>
                <p>Danh sách yêu thích của bạn đang trống.</p>

                <a href="${pageContext.request.contextPath}/home" class="btn-continue">
                    Tiếp tục mua sắm
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="wishlist-grid">
                <c:forEach items="${wishlistProducts}" var="p">
                   <div class="wishlist-item" id="product-card-${p.id}">
                           <div class="remove-corner" onclick="removeWishlist(${p.id})">
                               <i class="fa-solid fa-xmark"></i>
                           </div>

                           <a href="detail?id=${p.id}">
                               <div class="img-container">
                                   <img src="${pageContext.request.contextPath}/${p.img}" alt="${p.name}">
                               </div>
                           </a>

                        <div class="item-info">
                            <h3>${p.name}</h3>
                            <div class="price">
                                <c:choose>
                                    <c:when test="${p.salePrice > 0}">
                                        <fmt:formatNumber value="${p.salePrice}" pattern="#,###"/> đ
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                                    </c:otherwise>
                                </c:choose>
                            </div>

                           <div class="wishlist-actions">
                               <button class="btn-add-cart" onclick="addToCart(${p.id})">
                                   THÊM VÀO GIỎ
                               </button>

                               <button class="btn-buy-now" onclick="addToCart(${p.id}, true)">
                                   MUA NGAY
                               </button>
                           </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp" />
<script>
    function removeWishlist(productId) {
        fetch('${pageContext.request.contextPath}/wishlist-add?id=' + productId)
            .then(response => response.json())
            .then(data => {
                if (data.status === "success" || data.count !== undefined) {

                    const badge = document.getElementById('wishlist-count');
                    if (badge) {
                        badge.innerText = data.count;

                        badge.style.display = data.count > 0 ? 'flex' : 'none';
                    }

                    const productCard = document.getElementById('product-card-' + productId);
                    if (productCard) {
                        productCard.style.transition = 'all 0.4s ease';
                        productCard.style.opacity = '0';
                        productCard.style.transform = 'scale(0.8)';

                        setTimeout(() => {
                            productCard.remove();

                            const remainingItems = document.querySelectorAll('.wishlist-item');
                            if (remainingItems.length === 0) {
                                location.reload();
                            }
                        }, 400);
                    }
                }
            })
            .catch(err => console.error('Lỗi khi xóa:', err));
    }
</script>
<script>
    window.contextPath = '${pageContext.request.contextPath}';
</script>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>


</body>
</html>