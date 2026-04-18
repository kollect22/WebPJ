<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công - Fashion Store</title>
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
            padding-top: 130px;
        }
        .thankyou-card {
            background: #fff;
            border-radius: var(--border-radius-main);
            padding: 40px;
            border: 1px solid #f0f0f0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
        }
        /* Style cho card sản phẩm gợi ý để đồng bộ với trang chủ */
        .suggest-card {
            transition: 0.3s;
            border-radius: 15px !important;
        }
        .suggest-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1) !important;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container mb-5" style="min-height: 80vh;">
    <div class="row w-100 justify-content-center mx-0">
        <div class="col-lg-8">

            <div class="thankyou-card text-center p-5 bg-white shadow-sm mb-5">
                <div class="mb-4">
                    <i class="fa-solid fa-circle-check text-success" style="font-size: 80px;"></i>
                </div>

                <h1 class="fw-bold text-uppercase mb-3" style="letter-spacing: 2px;">
                    Đặt hàng thành công!
                </h1>

                <h5 class="text-muted mb-4">
                    Mã đơn hàng của bạn là:
                    <span class="text-dark fw-bold">
                        #<c:out value="${not empty sessionScope.orderId ? sessionScope.orderId : 'ĐANG CẬP NHẬT'}" />
                    </span>
                </h5>

                <p class="text-muted px-md-5 mb-4">
                    Cảm ơn bạn đã lựa chọn phụ kiện tại Fashion Store.<br>
                    Chúng mình sẽ sớm liên hệ để giao những món quà xinh xắn này đến bạn.
                </p>

                <div class="d-flex justify-content-center">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-dark px-5 py-3 rounded-pill fw-bold shadow-sm text-uppercase">
                        Tiếp tục mua sắm
                    </a>
                </div>
            </div>

            <div class="mt-5">
                <h4 class="text-center fw-bold text-uppercase mb-4" style="letter-spacing: 1px;">Có thể bạn cũng yêu thích</h4>
                <div class="row g-4 justify-content-center">

                    <c:forEach items="${sessionScope.recommendedList}" var="p">
                        <div class="col-md-4 col-6">
                            <div class="card h-100 border-0 shadow-sm text-center suggest-card" style="overflow: hidden;">
                                <img src="${pageContext.request.contextPath}/${p.img}" class="card-img-top" style="height: 200px; object-fit: cover;">
                                <div class="card-body d-flex flex-column">
                                    <p class="small fw-bold mb-1 text-truncate">${p.name}</p>
                                    <p class="text-danger fw-bold mb-3">
                                        <fmt:formatNumber value="${p.price}" pattern="#,###"/>đ
                                    </p>
                                    <a href="product?id=${p.id}" class="btn btn-outline-dark btn-sm rounded-pill mt-auto">Xem ngay</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

</body>
</html>