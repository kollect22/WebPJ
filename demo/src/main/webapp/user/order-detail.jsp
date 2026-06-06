<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng mua sắm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        :root {
            --bg-body: #f7f7f7;
            --primary-color: #000;
        }
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            padding-top: 110px;
        }
        .detail-card {
            background: #fff;
            border-radius: 16px;
            padding: 30px;
            border: 1px solid #f0f0f0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.02);
        }
        .product-item-box {
            background: #fff;
            border-radius: 12px;
            border: 1px solid #f5f5f5 !important;
            transition: 0.3s;
        }
        .product-item-box:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.04);
        }
        .summary-box {
            background: #fff;
            border-radius: 16px;
            border: 1px solid #f0f0f0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.02);
        }
        .text-brand-danger {
            color: #d0021b; /* Màu đỏ sang trọng giống file checkout của bạn */
        }
        .bg-brand-light {
            background-color: #fdfdfd;
            border: 1px solid #eee;
        }
        .section-title-custom {
            font-size: 16px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .border-dashed-line {
            border-top: 1px dashed #ddd;
        }
    </style>
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <span class="badge bg-dark rounded-pill px-3 py-2 mb-2">
                Mã Đơn Hàng: ${not empty details[0].orderidcode ? details[0].orderidcode : details[0].order_id_code}
            </span>
            <h3 class="fw-bold text-dark mb-0">Chi Tiết Đơn Hàng Đã Đặt</h3>
        </div>
        <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-dark btn-sm rounded-pill px-4 fw-semibold shadow-sm bg-white">
            <i class="fa-solid fa-arrow-left me-1"></i> Trở về danh sách
        </a>
    </div>

    <div class="row g-4">
        <div class="col-lg-7">
            <div class="detail-card">
                <div class="mb-4">
                    <h3 class="section-title-custom mb-0"><i class="fa-solid fa-bag-shopping text-dark"></i> Kiện hàng sản phẩm</h3>
                </div>

                <c:set var="subTotal" value="0" />

                <c:forEach items="${details}" var="item">
                    <c:set var="itemTotal" value="${item.price * item.quantity}" />
                    <c:set var="subTotal" value="${subTotal + itemTotal}" />

                    <c:set var="imgUrl" value="${not empty item.product_image ? item.product_image : (not empty item.productImage ? item.productImage : item.productimage)}" />
                    <c:set var="pName" value="${not empty item.product_name ? item.product_name : (not empty item.productName ? item.productName : item.productname)}" />

                    <div class="product-item-box p-3 mb-3">
                        <div class="row align-items-center g-3">
                            <div class="col-auto">
                                <img src="${pageContext.request.contextPath}/${imgUrl}"
                                     class="rounded object-fit-cover border shadow-sm"
                                     style="width: 80px; height: 95px;">
                            </div>
                            <div class="col">
                                <div class="fw-bold text-dark mb-1 small" style="line-height: 1.4;">${pName}</div>
                                <div class="text-muted small">Số lượng: <span class="fw-bold text-dark">x${item.quantity}</span></div>
                                <div class="text-muted small mt-1">Đơn giá: <fmt:formatNumber value="${item.price}" pattern="#,###"/>đ</div>
                            </div>
                            <div class="col-auto text-end">
                                <span class="text-muted small d-block mb-1">Thành tiền</span>
                                <span class="fw-bold text-brand-danger h5 mb-0">
                                    <fmt:formatNumber value="${itemTotal}" pattern="#,###"/>đ
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="col-lg-5">
            <c:set var="dbTotalPrice" value="${not empty details[0].totalprice ? details[0].totalprice : (not empty details[0].total_price ? details[0].total_price : subTotal)}" />

            <c:set var="finalShippingFee" value="30000" />
            <c:set var="finalDiscount" value="0" />

            <c:choose>
                <%-- Trường hợp 1: Chênh lệch đúng 15.000đ -> Khách chọn gói ship 15k, ko voucher --%>
                <c:when test="${subTotal + 15000 == dbTotalPrice}">
                    <c:set var="finalShippingFee" value="15000" />
                    <c:set var="finalDiscount" value="0" />
                </c:when>
                <%-- Trường hợp 2: Chênh lệch đúng 30.000đ -> Khách chọn gói ship 30k, ko voucher --%>
                <c:when test="${subTotal + 30000 == dbTotalPrice}">
                    <c:set var="finalShippingFee" value="30000" />
                    <c:set var="finalDiscount" value="0" />
                </c:when>
                <%-- Trường hợp 3: Có sự xuất hiện của mã ưu đãi Voucher giảm giá --%>
                <c:otherwise>
                    <%-- Nếu tổng thanh toán nhỏ hơn hoặc bằng (tiền hàng + ship 15k) -> Khách dùng ship 15k + voucher --%>
                    <c:choose>
                        <c:when test="${dbTotalPrice <= subTotal + 15000}">
                            <c:set var="finalShippingFee" value="15000" />
                            <c:set var="finalDiscount" value="${(subTotal + 15000) - dbTotalPrice}" />
                        </c:when>
                        <%-- Ngược lại, tính toán dựa trên gói ship tiêu chuẩn 30k --%>
                        <c:otherwise>
                            <c:set var="finalShippingFee" value="30000" />
                            <c:set var="finalDiscount" value="${(subTotal + 30000) - dbTotalPrice}" />
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>

            <div class="summary-box p-4">
                <h3 class="section-title-custom mb-4" style="font-size:17px;"><i class="fa-solid fa-receipt"></i> Tóm tắt thanh toán</h3>

                <div class="d-flex justify-content-between mb-3">
                    <span class="text-muted small">Tạm tính đơn hàng</span>
                    <span class="fw-bold text-dark"><fmt:formatNumber value="${subTotal}" pattern="#,###"/>đ</span>
                </div>

                <div class="d-flex justify-content-between mb-3">
                    <span class="text-muted small">Phí vận chuyển</span>
                    <span class="fw-bold text-dark">+<fmt:formatNumber value="${finalShippingFee}" pattern="#,###"/>đ</span>
                </div>

                <div class="d-flex justify-content-between mb-3" style="${finalDiscount > 0 ? 'display: flex;' : 'display: none;'}">
                    <span class="text-muted small text-danger fw-semibold"><i class="fa-solid fa-ticket me-1"></i> Giảm giá mã ưu đãi</span>
                    <span class="fw-bold text-danger">-<fmt:formatNumber value="${finalDiscount}" pattern="#,###"/>đ</span>
                </div>

                <div class="total-row d-flex justify-content-between align-items-center pt-3 border-top border-dashed-line mt-2">
                    <span class="fw-bold text-dark">TỔNG CỘNG THỰC TRẢ</span>
                    <span class="h4 fw-bold text-brand-danger mb-0">
                        <fmt:formatNumber value="${dbTotalPrice}" pattern="#,###"/>đ
                    </span>
                </div>

                <div class="bg-brand-light p-3 rounded-3 mt-4 text-center">
                    <p class="small text-muted mb-0">
                        <i class="fa-solid fa-shield-check text-dark me-1"></i>
                        Đơn hàng được lưu trữ và đồng bộ bảo mật thành công trên hệ thống Fashion Store.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/footer.jsp" />

</body>
</html>