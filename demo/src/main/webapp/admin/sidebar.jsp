<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside id="sidebar">
    <div class="logo-admin">ADMIN</div>
    <nav class="side-nav">
        <ul>
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa-solid fa-gauge"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-bag-shopping"></i> Sản phẩm</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-receipt"></i> Đơn hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/coupons"><i class="fa-solid fa-percent"></i> Khuyến mãi</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/banner"><i class="fa-solid fa-image"></i> Banner</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/customer"><i class="fa-solid fa-user"></i> Khách hàng</a></li>
        </ul>
    </nav>
</aside>