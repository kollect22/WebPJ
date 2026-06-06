<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán - Fashion Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <style>
                :root {
                    --bg-body: #f7f7f7;
                    --primary-color: #000;
                    --border-radius-main: 16px;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background-color: var(--bg-body);
                    /* 1. SỬA LỖI BỊ CHE: Đẩy nội dung xuống dưới Header (Tăng khoảng cách tùy Header bạn) */
                    padding-top: 130px;
                }

                .checkout-card {
                    background: #fff;
                    border-radius: var(--border-radius-main);
                    padding: 30px;
                    border: 1px solid #f0f0f0;
                    box-shadow: 0 4px 15px rgba(0,0,0,0.03);
                    margin-bottom: 25px;
                }

                .section-title {
                    font-size: 17px;
                    font-weight: 700;
                    margin-bottom: 25px;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }


                .payment-logo-container {
                    width: 55px;
                    height: 55px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border-radius: 10px;
                    margin-right: 15px;
                    border: 1px solid #eee;
                    background: #fff;
                    padding: 5px;
                }


                .payment-logo-container img {
                    max-width: 100%;
                    height: auto;
                    object-fit: contain;
                }


                .shipping-icon-container {
                    width: 55px;
                    height: 55px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    background: #f9f9f9;
                    border-radius: 10px;
                    margin-right: 15px;
                }
                .shipping-icon-container i { font-size: 24px; color: #555; }




                .btn-checkout-confirm {
                    width: 100%;
                    padding: 18px;
                    background: var(--primary-color);
                    color: #fff;
                    border: none;
                    border-radius: 50px;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    transition: 0.3s;
                }
                .btn-checkout-confirm:hover { background: #333; transform: translateY(-2px); }

                .method-icon-box {
                    width: 60px;
                    height: 60px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border-radius: 12px;
                    margin-right: 15px;
                    background: #f8f9fa; /* Nền xám nhạt tinh tế */
                    border: 1px solid #eee;
                    transition: 0.3s;
                }

                .method-icon-box i {
                    font-size: 26px;
                    color: #333; /* Màu icon tối để sang trọng */
                }

                /* Hiệu ứng khi người dùng chọn */
                input[type="radio"]:checked + .option-card .method-icon-box {
                    background: #000;
                    border-color: #000;
                }

                input[type="radio"]:checked + .option-card .method-icon-box i {
                    color: #fff;
                }

                .option-card {
                    display: flex;
                    align-items: center;
                    padding: 20px;
                    border: 1px solid #eee;
                    border-radius: 15px;
                    margin-bottom: 12px;
                    cursor: pointer;
                    transition: 0.3s ease;
                }

                input[type="radio"]:checked + .option-card {
                    border-color: #000;
                    background-color: #fdfdfd;
                    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
                }
                /* Sticky Đơn hàng cho Shop túi xách */
                .sticky-summary {
                    position: sticky;
                    top: 110px; /* Căn chỉnh tùy Header bạn */
                }
                /* Style cho phần Voucher hài hòa với tổng thể */
                .voucher-input-group {
                    display: flex;
                    gap: 10px;
                    margin-bottom: 20px;
                }

                .voucher-input-group input {
                    border-radius: 50px; /* Bo tròn giống các nút của bạn */
                    padding: 10px 20px;
                    border: 1px solid #eee;
                    flex-grow: 1;
                    font-size: 14px;
                }

                .btn-apply-voucher {
                    background: #f8f9fa;
                    border: 1px solid #ddd;
                    border-radius: 50px;
                    padding: 0 20px;
                    font-size: 13px;
                    font-weight: 600;
                    transition: 0.3s;
                }

                .btn-apply-voucher:hover {
                    background: #000;
                    color: #fff;
                    border-color: #000;
                }

                .discount-row {
                    color: #d0021b; /* Màu đỏ đô sang trọng */
                    font-size: 0.9rem;
                    display: none; /* Ẩn đi khi chưa có mã */
                }
        </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container checkout-page mb-5">
   <form id="checkoutForm" method="post">
        <input type="hidden" name="purchasedIds" value="${selectedIds}">
        <div class="row g-4">

            <div class="col-lg-7">
                <div class="checkout-card">
                    <h3 class="section-title"><i class="fa-solid fa-location-dot"></i> 01. Thông tin giao hàng</h3>
                    <div class="row g-3">
                        <div class="col-md-12 text-muted mb-2 small">
                            Người nhận: <strong>${sessionScope.auth.fullName}</strong>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="small fw-bold mb-1">Số điện thoại *</label>
                            <input type="tel" name="phone" class="form-control" required placeholder="Nhập số điện thoại">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="small fw-bold mb-1">Email</label>
                            <input type="email" class="form-control" placeholder="Nhận hóa đơn điện tử">
                        </div>
                        <div class="col-12">
                            <label class="small fw-bold mb-1">Địa chỉ chi tiết *</label>
                            <textarea name="address" class="form-control" rows="2" required placeholder="Số nhà, tên đường, phường/xã..."></textarea>
                        </div>
                    </div>
                </div>

                <div class="checkout-card">
                    <h3 class="section-title"><i class="fa-solid fa-truck-fast"></i> 02. Vận chuyển</h3>

                    <label class="w-100">
                        <input type="radio" name="shippingMethod" value="30000" class="btn-check" checked onchange="updateTotal()">
                        <div class="option-card">
                            <div class="shipping-icon-container"><i class="fa-solid fa-box"></i></div>
                            <div class="flex-grow-1">
                                <div class="fw-bold">Giao hàng nhanh (GHN)</div>
                                <div class="small text-muted">Dự kiến nhận sau 1-2 ngày</div>
                            </div>
                            <div class="fw-bold text-dark">30.000đ</div>
                        </div>
                    </label>

                    <label class="w-100">
                        <input type="radio" name="shippingMethod" value="15000" class="btn-check" onchange="updateTotal()">
                        <div class="option-card">
                            <div class="shipping-icon-container"><i class="fa-solid fa-box-open"></i></div>
                            <div class="flex-grow-1">
                                <div class="fw-bold">Giao hàng tiết kiệm</div>
                                <div class="small text-muted">Dự kiến nhận sau 3-5 ngày</div>
                            </div>
                            <div class="fw-bold text-dark">15.000đ</div>
                        </div>
                    </label>
                </div>

               <div class="checkout-card">
                   <h3 class="section-title"><i class="fa-solid fa-credit-card"></i> 03. Phương thức thanh toán</h3>

                   <label class="w-100">
                       <input type="radio" name="paymentMethod" value="BANK" class="btn-check" checked>
                       <div class="option-card">
                           <div class="method-icon-box">
                               <i class="fa-solid fa-building-columns"></i>
                           </div>
                           <div class="flex-grow-1">
                               <div class="fw-bold">Chuyển khoản Ngân hàng</div>
                               <div class="small text-muted">Quét mã VietQR để thanh toán nhanh</div>
                           </div>
                       </div>
                   </label>

                   <label class="w-100">
                       <input type="radio" name="paymentMethod" value="MOMO" class="btn-check">
                       <div class="option-card">
                           <div class="method-icon-box">
                               <i class="fa-solid fa-wallet"></i>
                           </div>
                           <div class="flex-grow-1">
                               <div class="fw-bold">Ví điện tử (MoMo/ZaloPay)</div>
                               <div class="small text-muted">Thanh toán qua ứng dụng ví điện tử</div>
                           </div>
                       </div>
                   </label>

                   <label class="w-100">
                       <input type="radio" name="paymentMethod" value="COD" class="btn-check">
                       <div class="option-card">
                           <div class="method-icon-box">
                               <i class="fa-solid fa-hand-holding-dollar"></i>
                           </div>
                           <div class="flex-grow-1">
                               <div class="fw-bold">Thanh toán khi nhận hàng (COD)</div>
                               <div class="small text-muted">Nhận hàng, kiểm tra túi rồi mới trả tiền</div>
                           </div>
                       </div>
                   </label>
               </div>
            </div>

            <div class="col-lg-5">
                <div class="checkout-card sticky-summary">
                    <h3 class="section-title" style="border:none;">Đơn hàng của bạn</h3>

                    <div class="summary-item-list" style="max-height: 380px; overflow-y: auto;">
                        <c:forEach items="${selectedItems}" var="item">
                            <div class="item-mini d-flex gap-3 mb-3 pb-3 border-bottom">
                                <div class="item-img" style="width: 70px; height: 85px;">
                                    <img src="${pageContext.request.contextPath}/${item.product.img}"
                                         class="w-100 h-100 object-fit-cover rounded border">
                                </div>

                                <div class="flex-grow-1">
                                    <div class="small fw-bold">${item.product.name}</div>
                                    <div class="small text-muted">Số lượng: ${item.quantity}</div>
                                    <div class="fw-bold mt-1 text-danger">
                                        <fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,###"/>đ
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="voucher-section mt-4">
                         <label class="small fw-bold mb-2"><i class="fa-solid fa-ticket me-1"></i> Ưu đãi / Mã giảm giá</label>
                         <div class="voucher-input-group">
                             <input type="text" id="coupon-code" name="couponCode" placeholder="Nhập mã ưu đãi..."
                                     value="${sessionScope.appliedCoupon.code}">
                             <button type="button" class="btn-apply-voucher" onclick="applyCoupon()">ÁP DỤNG</button>
                         </div>
                        <div id="coupon-message" class="small mt-1"></div>
                    </div>

                    <div class="price-details mt-4 border-top pt-3">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted small">Tạm tính</span>
                            <span id="display-subtotal" class="fw-bold">
                                <fmt:formatNumber value="${selectedSubtotal}" pattern="#,###"/>đ
                            </span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted small">Phí vận chuyển</span>
                            <span id="display-shipping" class="fw-bold">30,000đ</span>
                        </div>

                    <div id="row-discount" class="discount-row justify-content-between mb-3"
                         style="${not empty sessionScope.appliedCoupon ? 'display: flex;' : 'display: none;'}">
                        <span class="small">Giảm giá mã ưu đãi</span>
                        <span id="display-discount" class="fw-bold">
                           <fmt:formatNumber value="${discountAmount}" pattern="- #,###"/>đ
                        </span>
                    </div>

                        <div class="total-row d-flex justify-content-between align-items-center pt-3 border-top">
                            <span class="fw-bold">TỔNG CỘNG</span>
                            <span id="display-total" class="h4 fw-bold text-danger mb-0">
                                <fmt:formatNumber value="${selectedSubtotal + 30000 - discountAmount}" pattern="#,###"/>đ
                            </span>
                        </div>
                    </div>

                    <input type="hidden" name="totalPrice" id="input-total" value="${selectedSubtotal + 30000 - discountAmount}">
                    <button type="button" class="btn-checkout-confirm mt-4" onclick="handleCheckout()">
                        HOÀN TẤT ĐẶT HÀNG
                    </button>
                    <p class="text-center text-muted small mt-3 mb-0">
                        <i class="fa-solid fa-lock me-1"></i> Thông tin được bảo mật
                    </p>
                </div>
            </div>

        </div>
    </form>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function changeQty(id, delta) {
        const qtyText = document.getElementById('qty-text-' + id);
        const badge = document.getElementById('badge-' + id);

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
            updateTotal();
        })
        .catch(err => console.error("Lỗi kết nối Servlet:", err));
    }
    function handleCheckout(event) {
        if (event) event.preventDefault();

        const form = document.getElementById('checkoutForm');
        const paymentMethodEl = document.querySelector('input[name="paymentMethod"]:checked');

        if (!paymentMethodEl) {
            alert("Vui lòng chọn phương thức thanh toán!");
            return false;
        }
        const paymentMethod = paymentMethodEl.value;

        // --- XỬ LÝ COD ---
        if (paymentMethod === 'COD') {
            form.action = 'save-order';
            form.submit();
            return false;
        }

        // --- XỬ LÝ BANK ---
        if (paymentMethod === 'BANK') {
            const btn = document.querySelector('.btn-checkout-confirm');
            btn.innerHTML = '<i class="fa fa-spinner fa-spin"></i> ĐANG TẠO MÃ QR...';
            btn.disabled = true;

            const formData = new URLSearchParams(new FormData(form));
            // Đẩy kèm 2 tham số quan trọng mà PaymentApiServlet cần bốc dỡ
            formData.append("amount", document.getElementById('input-total').value);
            formData.append("method", "BANK");

            fetch('${pageContext.request.contextPath}/payment-api', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData.toString()
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'success') {
                    // Đã sửa lỗi chính tả biến hứng 'data' nhảy thẳng sang link QR ngân hàng
                    window.location.href = data.checkoutUrl;
                } else {
                    alert("Lỗi thanh toán: " + data.message);
                    btn.disabled = false;
                    btn.innerHTML = 'HOÀN TẤT ĐẶT HÀNG';
                }
            })
            .catch(err => {
                console.error("Fetch error:", err);
                alert("Lỗi hệ thống: Không thể kết nối với cổng thanh toán.");
                btn.disabled = false;
                btn.innerHTML = 'HOÀN TẤT ĐẶT HÀNG';
            });
        }
        return false;
    }

    function updateTotal() {
        // 1. Lấy phí vận chuyển từ radio đang chọn
        const shippingRadio = document.querySelector('input[name="shippingMethod"]:checked');
        let shipping = shippingRadio ? parseFloat(shippingRadio.value) : 0;

        // 2. Lấy số tiền Tạm tính từ giao diện (loại bỏ chữ 'đ' và dấu phẩy/chấm)
        const subtotalText = document.getElementById('display-subtotal').innerText;
        let subtotal = parseFloat(subtotalText.replace(/[^\d]/g, '')) || 0;

        // 3. Lấy số tiền giảm giá
        let discount = 0;
        const discountEl = document.getElementById('display-discount');
        if (discountEl) {
            discount = Math.abs(parseFloat(discountEl.innerText.replace(/[^\d]/g, ''))) || 0;
        }

        // 4. Tính tổng cuối cùng
        const finalTotal = subtotal + shipping - discount;

        // 5. Cập nhật lên giao diện
        document.getElementById('display-shipping').innerText = shipping.toLocaleString('vi-VN') + "đ";
        document.getElementById('display-total').innerText = finalTotal.toLocaleString('vi-VN') + "đ";

        // 6. Cập nhật vào input hidden để gửi lên Server khi nhấn Hoàn tất
        document.getElementById('input-total').value = finalTotal;
    }

    function applyCoupon() {
        const code = document.getElementById('coupon-code').value;
        const msg = document.getElementById('coupon-message');

        if(!code) {
            msg.innerHTML = "<span class='text-warning'>Vui lòng nhập mã ưu đãi!</span>";
            return;
        }
        fetch('${pageContext.request.contextPath}/apply-coupon', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({ 'code': code })
        })
        .then(res => res.json())
        .then(data => {
            if(data.success) {
                msg.innerHTML = "<span class='text-success'>Áp dụng mã thành công!</span>";
                // Tải lại trang để Controller tính toán lại giá tiền mới
                location.reload();
            } else {
                msg.innerHTML = "<span class='text-danger'>" + data.message + "</span>";
            }
        })
        .catch(err => {
            console.error("Lỗi áp dụng mã:", err);
            msg.innerHTML = "<span class='text-danger'>Lỗi hệ thống, vui lòng thử lại!</span>";
        });
    }
</script>
<script src="https://pay.payos.vn/lib/payos_checkout_sdk.js"></script>
</body>
</html>