<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="d-flex flex-column p-3 bg-white" style="width: 280px; height: 100vh;">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="...">Admin Shop</a>
    <hr>

    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="nav-link ${activeMenu == 'dashboard' ? 'active' : 'link-dark'}">
                <i class="fa-solid fa-gauge me-2"></i> Dashboard
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/products"
               class="nav-link ${activeMenu == 'products' ? 'active' : 'link-dark'}">
                <i class="fa-solid fa-bag-shopping me-2"></i> Sản phẩm
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/orders"
               class="nav-link ${activeMenu == 'orders' ? 'active' : 'link-dark'}">
                <i class="fa-solid fa-receipt me-2"></i> Đơn hàng
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/coupons"
               class="nav-link ${activeMenu == 'coupons' ? 'active' : 'link-dark'}">
                <i class="fa-solid fa-receipt me-2"></i> Khuyến mãi
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/customer.jsp"
               class="nav-link ${activeMenu == 'customer' ? 'active' : 'link-dark'}">
                <i class="fa-solid fa-receipt me-2"></i> Khách hàng
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/banner"
               class="nav-link ${activeMenu == 'banner' ? 'active' : 'link-dark'}">
                <i class="fa-solid fa-receipt me-2"></i> Banner
            </a>
        </li>

    </ul>
</div>