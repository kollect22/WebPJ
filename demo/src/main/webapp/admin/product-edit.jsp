<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm" style="max-width: 600px; margin: 0 auto;">
        <div class="card-header bg-white">
            <h4 class="text-primary mb-0">Cập nhật Sản phẩm #${p.id}</h4>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/product-edit" method="post">

                <input type="hidden" name="id" value="${p.id}">

                <div class="mb-3">
                    <label class="form-label fw-bold">Tên sản phẩm</label>
                    <input type="text" class="form-control" name="name" value="${p.name}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Giá (VNĐ)</label>
                    <input type="number" class="form-control" name="price" value="${p.price}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Link Ảnh</label>
                    <input type="text" class="form-control" name="img" value="${p.img}">

                    <div class="mt-2 text-center">
                        <img src="${p.img}" class="rounded border" style="width: 150px; height: 150px; object-fit: cover"
                             onerror="this.src='https://placehold.co/150?text=No+Img'">
                        <div class="small text-muted mt-1">Ảnh hiện tại</div>
                    </div>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                    <button type="submit" class="btn btn-primary px-4">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>