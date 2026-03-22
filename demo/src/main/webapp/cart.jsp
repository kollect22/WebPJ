<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"/>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            background: #f4f4f4;
            font-family: "Segoe UI", Arial, sans-serif;
            color: #111;
        }
        .container-breadcrumbs {
            margin-top: 110px;
            padding: 0 40px;
            margin-bottom: 20px;
        }

        .breadcrumbs {
            color: #666;
            font-size: 14px;
            margin: 0;
            padding: 0;
            border-bottom: none;
        }

        .breadcrumbs i,
        .breadcrumbs a {
            color: #333;
            text-decoration: none;
        }

        .breadcrumbs a:hover {
            text-decoration: underline;
            color: #000;
        }

        .breadcrumbs span {
            color: #999;
        }

        .container {
            max-width: 1300px;
            margin: 20px auto;
            display: flex;
            gap: 30px;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        /* ===== LEFT ===== */
        .cart-items { flex: 2; }

        .cart-item {
            display: flex;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid #e5e5e5;
            position: relative;
            transition: 0.25s;
        }

        .cart-item:hover {
            background: #fafafa;
            transform: translateY(-2px);
        }

        .item-check {
            margin-right: 15px;
            transform: scale(1.2);
            accent-color: #111;
            cursor: pointer;
        }

        .item-image {
            width: 100px;
            height: 100px;
            margin-right: 20px;
            border-radius: 6px;
            overflow: hidden;
            border: 1px solid #ddd;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .item-details { flex: 1; }

        .item-name {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .item-price {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .quantity-control {
            display: inline-flex;
            border: 1px solid #ccc;
            border-radius: 4px;
            overflow: hidden;
        }

        .quantity-control a {
            padding: 6px 12px;
            text-decoration: none;
            color: #111;
            background: #f8f8f8;
            transition: 0.2s;
        }

        .quantity-control a:hover {
            background: #e5e5e5;
        }

        .quantity-control span {
            padding: 6px 14px;
            font-weight: 600;
        }

        .remove-item {
            position: absolute;
            right: 10px;
            top: 20px;
            color: #999;
            font-size: 18px;
        }

        .remove-item:hover { color: #111; }

        /* ===== RIGHT ===== */
        .cart-summary {
            flex: 1;
            background: #fafafa;
            padding: 25px;
            border-radius: 6px;
            border-left: 1px solid #e5e5e5;
        }

        .cart-summary h2 {
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 22px;
        }

        .cart-summary strong {
            font-size: 22px;
        }

        .checkout-btn {
            display: block;
            width: 100%;
            padding: 14px 0;
            margin-top: 25px;
            background: #111;
            color: #fff;
            text-align: center;
            font-size: 17px;
            font-weight: 600;
            letter-spacing: 1px;
            border-radius: 4px;
            text-decoration: none;
            transition: 0.3s;
        }

        .checkout-btn:hover {
            background: #000;
            transform: translateY(-2px);
        }

        .continue {
            display: inline-block;
            margin-top: 20px;
            color: #111;
            font-size: 14px;
            text-decoration: none;
            border-bottom: 1px solid transparent;
        }

        .continue:hover {
            border-bottom: 1px solid #111;
        }

        @media (max-width: 900px) {
            .container { flex-direction: column; }
            .cart-summary {
                border-left: none;
                border-top: 1px solid #e5e5e5;
            }
        }
    </style>
</head>

<body>
<jsp:include page="header.jsp" />

<div class="container-breadcrumbs">
    <nav class="breadcrumbs">
        <i class="fa-solid fa-house"></i>
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a> /
        <span>Giỏ hàng</span>
    </nav>
</div>

<div class="container">

    <div class="cart-items">

        <c:if test="${empty sessionScope.cart || empty sessionScope.cart.list}">
            <p style="text-align:center;font-size:18px;color:#777">
                Giỏ hàng của bạn đang trống
            </p>
        </c:if>

        <c:forEach items="${sessionScope.cart.list}" var="ci">
            <div class="cart-item" id="item-${ci.product.id}">


                <input type="checkbox"
                       class="item-check"
                       checked
                       data-id="${ci.product.id}"
                       data-price="${ci.product.price}"
                       data-qty="${ci.quantity}"
                       onchange="recalculateTotal()">


                <div class="item-image">
                    <img src="${ci.product.img}" alt="${ci.product.name}">
                </div>

                <div class="item-details">
                    <div class="item-name">${ci.product.name}</div>

                    <div class="item-price">
                        <fmt:formatNumber value="${ci.product.price * ci.quantity}"
                                          groupingUsed="true"/> VNĐ
                    </div>

                    <div class="quantity-control">
                        <a href="javascript:void(0)"
                           class="minus-btn"
                           onclick="updateCart(${ci.product.id}, -1)">-</a>

                        <span id="qty-${ci.product.id}">
                            ${ci.quantity}
                        </span>

                        <a href="javascript:void(0)"
                           onclick="updateCart(${ci.product.id}, 1)">+</a>
                    </div>

                </div>

               <a href="javascript:void(0)"
                  onclick="deleteItem(${ci.product.id})">
                   <i class="fa-solid fa-xmark"></i>
               </a>



            </div>
        </c:forEach>

    </div>

    <div class="cart-summary">
        <h2>TẠM TÍNH</h2>

        <p>
            Tổng tiền:<br>
            <strong id="cart-total">
                <fmt:formatNumber value="${sessionScope.cart.total}" groupingUsed="true"/> VNĐ
            </strong>

        </p>

        <a href="checkout" class="checkout-btn">
            THANH TOÁN
        </a>

        <a href="list-product" class="continue">
            ← Tiếp tục mua sắm
        </a>
    </div>

</div>

<jsp:include page="footer.jsp" />

<script>
    window.contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

</body>
</html>
