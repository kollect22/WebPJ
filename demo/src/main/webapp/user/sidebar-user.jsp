<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="d-flex flex-column p-3 bg-white" style="width: 280px; height: 100vh;">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="text-center fw-bold text-decoration-none text-blue">User</a>
    <hr>

    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/user/profile.jsp"
               class="nav-link ${activeMenu == 'profile' ? 'active' : 'link-dark'}">
                <i class="fa-solid fa-gauge me-2"></i> Profile
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/user/user-order"
               class="nav-link ${activeMenu == 'user-order' ? 'active' : 'link-dark'}">
                <i class="fa-solid fa-bag-shopping me-2"></i> Đơn hàng
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/user/user-wishlist"
               class="nav-link ${activeMenu == 'wishlist' ? 'active' : 'link-dark'}">
                <i class="fa-solid fa-receipt me-2"></i> Danh sách yêu thích
            </a>
        </li>


    </ul>
</div>