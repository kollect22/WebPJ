<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Sản phẩm</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <style>
        body {
            background-color: #f8f9fa;
        }
        .thumb {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>

<div class="d-flex" id="wrapper">

    <div class="border-end bg-white" id="sidebar-wrapper" style="min-height: 100vh;">
        <jsp:include page="sidebar.jsp"/>
    </div>

    <div id="page-content-wrapper" class="w-100">

        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm px-4 py-3">
            <div class="container-fluid">
                <h4 class="mb-0 text-primary fw-bold">Dashboard</h4>
                <div class="ms-auto d-flex align-items-center">
                    <span class="me-3 text-secondary">Xin chào, <strong>Admin!</strong></span>
                    <div class="rounded-circle bg-light d-flex justify-content-center align-items-center" style="width: 40px; height: 40px;">
                        <i class="fa-regular fa-user text-primary"></i>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container-fluid px-4 mt-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="mb-0 text-secondary text-nowrap">Danh sách Sản phẩm</h3>

                <form action="${pageContext.request.contextPath}/admin/products" method="GET" class="d-flex w-50 mx-4">
                    <input type="text" name="search" class="form-control me-2" placeholder="Tìm theo tên sản phẩm..." value="${param.search}">
                    <button type="submit" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form>

                <button type="button" class="btn btn-primary text-nowrap" data-bs-toggle="modal" data-bs-target="#addProductModal">
                    <i class="fa-solid fa-plus me-1"></i> Thêm Sản phẩm
                </button>
            </div>

            <div class="card shadow border-0 rounded-3">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped align-middle mb-0">
                            <thead class="bg-light text-secondary">
                            <tr>
                                <th class="py-3 ps-4">Ảnh</th>
                                <th class="py-3">Tên Sản phẩm</th>
                                <th class="py-3">Mã SKU</th>
                                <th class="py-3">Giá</th>
                                <th class="py-3">Trạng thái</th>
                                <th class="py-3 text-center">Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${productList}" var="p">
                                <tr>
                                    <td class="ps-4">
                                        <img src="${pageContext.request.contextPath}/${p.img}"
                                             alt="${p.name}" class="thumb"
                                             onerror="this.src='https://placehold.co/50x50?text=No+Img'">
                                    </td>

                                    <td class="fw-bold text-dark">${p.name}</td>

                                    <td class="text-muted">SP-${p.id}</td>

                                    <td class="text-primary fw-bold">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ"/>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${p.price > 0}">
                                                <span class="badge bg-success bg-opacity-75">Còn hàng</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger bg-opacity-75">Hết hàng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="text-center">
                                        <button type="button" class="btn btn-sm btn-outline-primary me-1" title="Sửa"
                                                data-bs-toggle="modal"
                                                data-bs-target="#editProductModal"
                                                data-id="${p.id}"
                                                data-name="${p.name}"
                                                data-price="${p.price}"
                                                data-quantity="${p.quantity}"
                                                data-category="${p.categoryId}"
                                                data-img="${p.img}"
                                                data-desc="${p.description}"
                                                onclick="fillEditModal(this)">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </button>

                                        <button class="btn btn-sm btn-outline-danger" onclick="confirmDelete(${p.id})" title="Xóa">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <c:if test="${totalPages > 0}">
                    <div class="card-footer bg-white border-0 py-3 mt-2">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-end mb-0">

                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage - 1}&search=${param.search}">Trang trước</a>
                                </li>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&search=${param.search}">${i}</a>
                                    </li>
                                </c:forEach>

                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage + 1}&search=${param.search}">Trang sau</a>
                                </li>

                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-white">
                <h5 class="modal-title text-primary fw-bold" id="addProductModalLabel">THÊM SẢN PHẨM MỚI</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <form id="addProductForm" action="${pageContext.request.contextPath}/admin/product-add" method="post">

                    <div class="mb-3">
                        <label for="prodName" class="form-label fw-bold">Tên sản phẩm</label>
                        <input type="text" class="form-control" id="prodName" name="name" required placeholder="Nhập tên sản phẩm...">
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="prodCategory" class="form-label fw-bold">Danh mục (ID)</label>
                            <input type="text" class="form-control" id="prodCategory" name="categoryId" required placeholder="Ví dụ: 1">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="prodPrice" class="form-label fw-bold">Giá (VNĐ)</label>
                            <input type="number" class="form-control" id="prodPrice" name="price" required placeholder="100000">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="prodQty" class="form-label fw-bold">Số lượng</label>
                            <input type="number" class="form-control" id="prodQty" name="quantity" required value="10" min="0">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="prodDesc" class="form-label fw-bold">Mô tả</label>
                        <textarea class="form-control" id="prodDesc" name="description" rows="3" placeholder="Mô tả sản phẩm..."></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="prodImg" class="form-label fw-bold">Link Ảnh (URL)</label>
                        <input type="text" class="form-control" id="prodImg" name="img"
                               placeholder="Dán link ảnh online vào đây..."
                               oninput="document.getElementById('imgPreview').src = this.value || 'https://placehold.co/150x150?text=Xem+Truoc+Anh'">

                        <div class="mt-3 text-center bg-light rounded py-2 border">
                            <img id="imgPreview" src="https://placehold.co/150x150?text=Xem+Truoc+Anh"
                                 alt="Preview" style="max-width: 150px; max-height: 150px; object-fit: contain;">
                        </div>
                    </div>

                    <div class="modal-footer border-0 px-0 pb-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary px-4">Lưu Sản Phẩm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="editProductModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-white">
                <h5 class="modal-title text-primary fw-bold">CHỈNH SỬA SẢN PHẨM</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/admin/product-edit" method="post">

                    <input type="hidden" id="editId" name="id">

                    <div class="mb-3">
                        <label class="form-label fw-bold">Tên sản phẩm</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="form-label fw-bold">Danh mục (ID)</label>
                            <input type="text" class="form-control" id="editCategory" name="categoryId" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label fw-bold">Giá</label>
                            <input type="number" class="form-control" id="editPrice" name="price" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label fw-bold">Số lượng</label>
                            <input type="number" class="form-control" id="editQuantity" name="quantity" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Mô tả</label>
                        <textarea class="form-control" id="editDesc" name="description" rows="3"></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Link Ảnh (URL)</label>
                        <input type="text" class="form-control" id="editImg" name="img"
                               oninput="document.getElementById('editImgPreview').src = this.value || 'https://placehold.co/150x150?text=Xem+Truoc+Anh'">
                        <div class="mt-3 text-center bg-light rounded py-2 border">
                            <img id="editImgPreview" src="" alt="Preview" style="max-width: 150px; max-height: 150px; object-fit: contain;">
                        </div>
                    </div>

                    <div class="modal-footer border-0 px-0 pb-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary px-4">Lưu Cập Nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function confirmDelete(id) {
        if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này không?")) {
            window.location.href = "${pageContext.request.contextPath}/admin/product-delete?id=" + id;
        }
    }
    function fillEditModal(button) {
        let id = button.getAttribute('data-id');
        let name = button.getAttribute('data-name');
        let price = button.getAttribute('data-price');
        let quantity = button.getAttribute('data-quantity');
        let category = button.getAttribute('data-category');
        let desc = button.getAttribute('data-desc');
        let img = button.getAttribute('data-img');

        document.getElementById('editId').value = id;
        document.getElementById('editName').value = name;
        document.getElementById('editPrice').value = price;
        document.getElementById('editQuantity').value = quantity;
        document.getElementById('editCategory').value = category;
        document.getElementById('editDesc').value = desc;
        document.getElementById('editImg').value = img;

        let preview = document.getElementById('editImgPreview');
        if (img && img.startsWith('http')) {
            preview.src = img;
        } else if (img) {
            preview.src = '${pageContext.request.contextPath}/' + img;
        } else {
            preview.src = 'https://placehold.co/150x150?text=Xem+Truoc+Anh';
        }
    }
</script>

</body>
</html>