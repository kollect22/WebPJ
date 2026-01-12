<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
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
        <div class="module-header">
            <h2>Danh sách Đơn hàng</h2>
        </div>
        <div class="table-container">
            <table class="admin-table">
                <thead>
                <tr>
                    <th>Mã Đơn</th>
                    <th>Khách hàng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>#1004</td>
                    <td>Phạm Văn F</td>
                    <td>19/11/2025</td>
                    <td>680.000 VNĐ</td>
                    <td><span class="badge badge-warning">Chờ xử lý</span></td>
                    <td>
                        <button class="btn-action"><i class="fa-solid fa-eye"></i></button>
                        <button class="admin-btn btn-primary" style="padding: 5px 10px; font-size: 14px;">Xác nhận</button>
                    </td>
                </tr>
                <tr>
                    <td>#1003</td>
                    <td>Trần Đình C</td>
                    <td>18/11/2025</td>
                    <td>800.000 VNĐ</td>
                    <td><span class="badge badge-success">Đã hoàn thành</span></td>
                    <td>
                        <button class="btn-action"><i class="fa-solid fa-eye"></i></button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>