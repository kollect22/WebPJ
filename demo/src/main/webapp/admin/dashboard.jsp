<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">

</head>

<body>
<div id="admin-page">
    <jsp:include page="sidebar.jsp"/>
    <main id="main">
        <header id="admin-header">
            <h1>Dashboard</h1>
            <div class="admin-info">
                <span>Xin chào, Admin!</span>
                <i class="fa-slab fa-regular fa-user"></i>
            </div>
        </header>
        <section class="kpi-cards">
            <div class="card">
                <i class="fa-solid fa-chart-line"></i>
                <h3>Doanh thu hôm nay</h3>
                <p>10.000.000 VNĐ</p>
            </div>
            <div class="card">
                <i class="fa-regular fa-truck"></i>
                <h3>Đơn hàng mới</h3>
                <p>12 đơn hàng</p>
            </div>
            <div class="card">
                <i class="fa-solid fa-coins"></i>
                <h3>Tổng lợi nhuận</h3>
                <p>100.000.000 VNĐ</p>
            </div>
            <div class="card">
                <i class="fa-solid fa-box-open"></i>
                <h3>Đơn hàng mới</h3>
                <p>12 đơn hàng</p>
            </div>
        </section>
        <section class="recent-orders">
            <h2>Đơn hàng gần đây</h2>
            <div class="table-container">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Khách hàng</th>
                            <th>Ngày đặt</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#1001</td>
                            <td>Nguyễn Văn A</td>
                            <td>20/11/2025</td>
                            <td>350.000 VNĐ</td>
                            <td class="status-pending">Chờ xử lý</td>
                        </tr>
                        <tr>
                            <td>#1002</td>
                            <td>Lê Thị B</td>
                            <td>19/11/2025</td>
                            <td>1.250.000 VNĐ</td>
                            <td class="status-shipped">Đã giao</td>
                        </tr>
                        <tr>
                            <td>#1003</td>
                            <td>Trần Đình C</td>
                            <td>18/11/2025</td>
                            <td>800.000 VNĐ</td>
                            <td class="status-completed">Hoàn thành</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</div>
</body>
</html>