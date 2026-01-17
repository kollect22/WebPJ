<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng & Thanh toán</title>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            color: #333;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .container {
            display: flex;
            max-width: 1200px;
            margin: 80px auto 0;
            gap: 30px;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            flex: 1;
            width: 100%;
        }
        .cart-items { flex: 2; }
        .cart-summary {
            flex: 1;
            padding: 20px;
            border-left: 1px solid #eee;
        }
        .cart-item {
            display: flex;
            border-bottom: 1px solid #eee;
            padding: 15px 0;
            position: relative;
        }
        .item-image {
            width: 100px;
            height: 100px;
            margin-right: 15px;
        }
        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .quantity-control a {
            padding: 5px 10px;
            border: 1px solid #000;
            text-decoration: none;
            margin: 0 5px;
            color: black;
        }
        .remove-item {
            position: absolute;
            top: 10px;
            right: 10px;
            color: #999;
        }
        .remove-item:hover { color: red; }
    </style>
</head>

<body>

<div class="container">

    <!-- ================= BÊN TRÁI: GIỎ HÀNG ================= -->
    <div class="cart-items">
        <!-- NẾU GIỎ HÀNG TRỐNG -->
        <c:if test="${empty sessionScope.cart || empty sessionScope.cart.list}">
            <p>Giỏ hàng của bạn đang trống.</p>
        </c:if>

        <!-- NẾU CÓ SẢN PHẨM -->
        <div class="item-list">
            <c:forEach items="${sessionScope.cart.list}" var="ci">

                <div class="cart-item">

                    <div class="item-image">
                        <img src="${ci.product.img}" alt="${ci.product.name}">
                    </div>

                    <div class="item-details">
                        <div class="item-name">
                            <strong>${ci.product.name}</strong>
                        </div>

                        <div class="item-price">
                            ${ci.product.price * ci.quantity} VNĐ
                        </div>

                        <!-- NÚT + / - -->
                        <div class="quantity-control">
                            <a href="add-cart?id=${ci.product.id}&q=-1">-</a>
                            <span>${ci.quantity}</span>
                            <a href="add-cart?id=${ci.product.id}&q=1">+</a>
                        </div>
                    </div>

                    <!-- XÓA -->
                    <a href="add-cart?id=${ci.product.id}&q=-${ci.quantity}">
                        <i class="fa-solid fa-xmark remove-item"></i>
                    </a>

                </div>

            </c:forEach>
        </div>
    </div>

    <!-- ================= BÊN PHẢI: TỔNG TIỀN ================= -->
    <div class="cart-summary">
        <h2>TẠM TÍNH</h2>

        <p>
            Tổng tiền:
            <strong style="font-size:18px">
                ${sessionScope.cart.total} VNĐ
            </strong>
        </p>

        <br>

        <a href="products-category-all">
            ← Tiếp tục mua sắm
        </a>
    </div>

</div>

</body>
</html>
