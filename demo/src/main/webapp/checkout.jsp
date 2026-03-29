<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán - Fashion Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

    <style>
        :root {
            --primary-color: #000;
            --bg-gray: #fcfcfc;
            --gift-color: #28a745;
        }

        .checkout-page {
            max-width: 1200px;
            margin: 0 auto;
            padding-top: 100px; /* Tăng khoảng cách này nếu header vẫn che */
            padding-bottom: 50px;
        }

        .option-card {
            display: flex;
            align-items: center;
            gap: 12px;
            border: 1px solid #eee;
            padding: 12px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.2s;
            border-radius: 4px;
        }

        .option-card:hover {
            border-color: #000;
            background-color: #f9f9f9;
        }

        .option-card input[type="radio"] {
            accent-color: #000;
        }

        .option-info {
            flex-grow: 1;
        }

        .option-name {
            display: block;
            font-size: 13px;
            font-weight: 600;
        }

        .option-desc {
            display: block;
            font-size: 11px;
            color: #666;
        }

        .option-price {
            font-weight: 600;
            font-size: 13px;
        }

        .checkout-grid {
            display: grid;
            grid-template-columns: 1.1fr 0.9fr;
            gap: 50px;
        }

        .section-title {
            font-size: 15px;
            text-transform: uppercase;
            border-bottom: 1px solid #000;
            padding-bottom: 8px;
            margin-bottom: 25px;
            font-weight: 600;
        }

        .input-group {
            margin-bottom: 15px;
        }

        .input-group label {
            display: block;
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 6px;
        }

        .input-group input,
        .input-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            outline: none;
        }

        .order-summary {
            background: var(--bg-gray);
            padding: 30px;
            border: 1px solid #eee;
            position: sticky;
            top: 20px;
        }

        .item-mini {
            display: flex;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

        .item-img {
            width: 70px;
            height: 90px;
            position: relative;
        }

        .item-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .qty-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #000;
            color: #fff;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
        }

        .btn-qty {
            width: 22px;
            height: 22px;
            cursor: pointer;
            border: 1px solid #ccc;
            background: #fff;
        }

        .total-row {
            border-top: 2px solid #000;
            padding-top: 15px;
            font-weight: bold;
            font-size: 18px;
            display: flex;
            justify-content: space-between;
        }

        .btn-submit {
            width: 100%;
            padding: 15px;
            background: #000;
            color: #fff;
            border: none;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="checkout-page">
    <form action="place-order" method="POST" id="checkoutForm">
        <div class="checkout-grid">

            <div class="checkout-left">
                <section class="checkout-section">
                    <h3 class="section-title">01. Thông tin giao hàng</h3>
                    <div class="input-group">
                        <label>Họ và tên</label>
                        <%-- Sửa thành fullName khớp với file User.java --%>
                        <input type="text" value="${sessionScope.auth.fullName}" readonly>
                    </div>
                    <div class="input-group">
                        <label>Số điện thoại *</label>
                        <input type="tel" name="phone" required placeholder="09xxx">
                    </div>
                    <div class="input-group">
                        <label>Địa chỉ nhận hàng *</label>
                        <textarea name="address" rows="3" required placeholder="Số nhà, tên đường..."></textarea>
                    </div>
                </section>

                <section class="checkout-section">
                    <h3 class="section-title">02. Đơn vị vận chuyển</h3>

                    <label class="option-card">
                        <input type="radio" name="shippingMethod" value="50000" onchange="updateTotal()">
                        <div class="option-info">
                            <span class="option-name">Giao hàng hỏa tốc (Grab/Ahamove)</span>
                            <span class="option-desc">Nhận hàng ngay trong 2h</span>
                        </div>
                        <span class="option-price">50,000 đ</span>
                    </label>

                    <label class="option-card">
                        <input type="radio" name="shippingMethod" value="30000" checked onchange="updateTotal()">
                        <div class="option-info">
                            <span class="option-name">Giao hàng nhanh (GHN/GHTK)</span>
                            <span class="option-desc">Dự kiến nhận hàng sau 1-2 ngày</span>
                        </div>
                        <span class="option-price">30,000 đ</span>
                    </label>

                    <label class="option-card">
                        <input type="radio" name="shippingMethod" value="15000" onchange="updateTotal()">
                        <div class="option-info">
                            <span class="option-name">Giao hàng tiết kiệm</span>
                            <span class="option-desc">Dự kiến nhận hàng sau 3-5 ngày</span>
                        </div>
                        <span class="option-price">15,000 đ</span>
                    </label>

                    <h3 class="section-title" style="margin-top: 30px;">03. Phương thức thanh toán</h3>

                    <label class="option-card">
                        <input type="radio" name="paymentMethod" value="COD" checked>
                        <i class="fa-solid fa-money-bill-1-wave"></i>
                        <div class="option-info">
                            <span class="option-name">Thanh toán khi nhận hàng (COD)</span>
                        </div>
                    </label>

                    <label class="option-card">
                        <input type="radio" name="paymentMethod" value="MOMO">
                        <i class="fa-solid fa-wallet" style="color: #ae2070;"></i>
                        <div class="option-info">
                            <span class="option-name">Ví điện tử MoMo</span>
                        </div>
                    </label>

                    <label class="option-card">
                        <input type="radio" name="paymentMethod" value="BANK">
                        <i class="fa-solid fa-building-columns"></i>
                        <div class="option-info">
                            <span class="option-name">Chuyển khoản ngân hàng (QR Code)</span>
                        </div>
                    </label>
                </section>
            </div>

            <div class="checkout-right">
                <div class="order-summary">
                    <h3 class="section-title" style="border:none;">Đơn hàng của bạn</h3>

                    <div class="summary-item-list">
                        <%-- Dùng .list để gọi hàm getList() trong Cart.java --%>
                        <c:forEach items="${sessionScope.cart.list}" var="item">
                            <div class="item-mini" id="item-${item.product.id}">
                                <div class="item-img">
                                    <img src="${pageContext.request.contextPath}/${item.product.img}">
                                    <span class="qty-badge" id="badge-${item.product.id}">${item.quantity}</span>
                                </div>
                                <div class="item-info">
                                    <p style="font-size:13px; font-weight:600; margin:0;">${item.product.name}</p>
                                    <p class="price-text" data-unit-price="${item.price}">
                                        <fmt:formatNumber value="${item.price}" pattern="#,###"/> đ
                                    </p>
                                    <div style="display:flex; align-items:center; gap:10px;">
                                        <button type="button" class="btn-qty" onclick="changeQty(${item.product.id}, -1)">-</button>
                                        <span id="qty-text-${item.product.id}">${item.quantity}</span>
                                        <button type="button" class="btn-qty" onclick="changeQty(${item.product.id}, 1)">+</button>
                                    </div>
                                </div>
                                <div style="text-align: right; min-width:80px;">
                                    <span id="item-total-${item.product.id}" style="font-weight:bold;">
                                        <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/> đ
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="price-details" style="margin-top:20px;">
                        <div style="display:flex; justify-content:space-between; margin-bottom:10px;">
                            <span>Tạm tính</span>
                            <%-- Dùng .total để gọi hàm getTotal() trong Cart.java --%>
                            <span id="display-subtotal">
                                <fmt:formatNumber value="${sessionScope.cart.total}" pattern="#,###"/> đ
                            </span>
                        </div>
                        <div style="display:flex; justify-content:space-between; margin-bottom:10px;">
                            <span>Phí vận chuyển</span>
                            <span id="display-shipping">30,000 đ</span>
                        </div>
                        <div class="total-row">
                            <span>TỔNG CỘNG</span>
                            <span id="display-total">
                                <fmt:formatNumber value="${sessionScope.cart.total + 30000}" pattern="#,###"/> đ
                            </span>
                        </div>
                    </div>

                    <input type="hidden" name="totalPrice" id="input-total" value="${sessionScope.cart.total + 30000}">
                    <button type="submit" class="btn-submit">HOÀN TẤT ĐẶT HÀNG</button>
                </div>
            </div>
        </div>
    </form>
</div>

<jsp:include page="footer.jsp" />

<script>
   function changeQty(id, delta) {
       // Tìm thẻ hiển thị số lượng dựa trên ID truyền vào
       const qtyText = document.getElementById('qty-text-' + id);
       const badge = document.getElementById('badge-' + id);

       // Nếu không tìm thấy thẻ, dừng lại ngay để không báo lỗi đỏ
       if (!qtyText) {
           console.error("Không tìm thấy thẻ với ID: qty-text-" + id);
           return;
       }

       let currentQty = parseInt(qtyText.innerText);
       let newQty = currentQty + delta;

       if (newQty <= 0) {
           if (confirm("Bạn có muốn xóa sản phẩm này khỏi giỏ hàng không?")) {
               window.location.href = "${pageContext.request.contextPath}/del-cart?id=" + id + "&src=checkout";
           }
           return;
       }
       const params = new URLSearchParams();
       params.append('id', id);
       params.append('q', delta);

       fetch('update-cart', {
           method: 'POST',
           headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
           body: params
       })
       .then(response => response.json())
       .then(data => {

           qtyText.innerText = data.itemQuantity;
           if(badge) badge.innerText = data.itemQuantity;

           const itemTotalEl = document.getElementById('item-total-' + id);
           if(itemTotalEl) {
               const priceEl = document.querySelector('#item-' + id + ' .price-text');
               const unitPrice = parseFloat(priceEl.getAttribute('data-unit-price'));
               itemTotalEl.innerText = (unitPrice * data.itemQuantity).toLocaleString() + " đ";
           }

           const subtotalEl = document.getElementById('display-subtotal');
           if(subtotalEl) {
               subtotalEl.innerText = data.total.toLocaleString() + " đ";
           }

           // Tính lại phí ship và tổng cộng
           updateTotal();
       })
       .catch(err => console.error("Lỗi kết nối Servlet:", err));
   }

   function updateTotalFinal(subtotal) {
       const shippingRadio = document.querySelector('input[name="shippingMethod"]:checked');
       let shipping = shippingRadio ? parseFloat(shippingRadio.value) : 0;

       const finalTotal = subtotal + shipping;

       document.getElementById('display-shipping').innerText = shipping.toLocaleString() + " đ";
       document.getElementById('display-total').innerText = finalTotal.toLocaleString() + " đ";
       document.getElementById('input-total').value = finalTotal;
   }

   function updateTotal() {
       let subtotalText = document.getElementById('display-subtotal').innerText;
       let subtotal = parseFloat(subtotalText.replace(/[^\d]/g, ''));
       updateTotalFinal(subtotal);
   }
</script>

</body>
</html>