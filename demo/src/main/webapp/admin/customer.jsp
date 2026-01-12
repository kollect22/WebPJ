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
            <h2>Danh sách Khách hàng</h2>
            <div class="search-box">
                <input type="text" placeholder="Tìm kiếm theo Tên hoặc Email" style="padding: 10px; border-radius: 4px; border: 1px solid #444; background-color: #333; color: white;">
            </div>
        </div>

        <div class="table-container">
            <table class="admin-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Họ tên</th>
                    <th>Email</th>
                    <th>SĐT</th>
                    <th>Tổng đơn hàng</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Nguyễn Văn A</td>
                    <td>vana@gmail.com</td>
                    <td>0901234567</td>
                    <td>5</td>
                    <td>
                        <button class="btn-action"><i class="fa-solid fa-eye"></i></button>
                        <button class="btn-action"><i class="fa-solid fa-envelope"></i></button>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Lê Thị B</td>
                    <td>leb@gmail.com</td>
                    <td>0987654321</td>
                    <td>12</td>
                    <td>
                        <button class="btn-action"><i class="fa-solid fa-eye"></i></button>
                        <button class="btn-action"><i class="fa-solid fa-envelope"></i></button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>