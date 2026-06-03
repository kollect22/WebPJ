<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Banner</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <style>
        body {
            background-color: #f8f9fa;
        }
        .banner-thumb {
            width: 120px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #dee2e6;
        }
        .preview-container {
            width: 100%;
            height: 150px;
            border: 2px dashed #dee2e6;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            background-color: #f8f9fa;
            margin-top: 10px;
        }
        .preview-img {
            max-width: 100%;
            max-height: 100%;
            display: none;
        }
        .placeholder-text {
            color: #adb5bd;
            font-size: 0.9rem;
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
                <h3 class="mb-0 text-secondary">Quản lý Banner</h3>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBannerModal">
                    <i class="fa-solid fa-cloud-arrow-up me-2"></i> Tải lên Banner
                </button>
            </div>

            <div class="card shadow border-0 rounded-3">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped align-middle mb-0">
                            <thead class="bg-light text-secondary">
                            <tr>
                                <th class="py-3 ps-4">Hình ảnh</th>
                                <th class="py-3">Tiêu đề</th>
                                <th class="py-3">Liên kết (Link)</th>
                                <th class="py-3 text-center">Hành động</th>
                            </tr>
                            </thead>
                            <tbody id="banner-table-body">

                            <c:forEach items="${allBanners}" var="b">
                                <tr>
                                    <td class="ps-4">
                                        <img src="${pageContext.request.contextPath}/${b.img}"
                                             alt="Banner" class="banner-thumb"
                                             onerror="this.src='https://placehold.co/120x60?text=No+Img'">
                                    </td>
                                    <td class="fw-bold">${b.title}</td>
                                    <td class="text-primary">${b.link}</td>
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-outline-primary me-1 edit-btn"
                                                data-id="${b.id}"
                                                data-title="${b.title}"
                                                data-link="${b.link}"
                                                data-img="${b.img}">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger delete-btn" data-id="${b.id}"><i class="fa-solid fa-trash"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty allBanners}">
                                <tr>
                                    <td colspan="4" class="text-center py-4 text-secondary">
                                        <i class="fa-solid fa-folder-open me-1"></i> Chưa có banner nào trong hệ thống.
                                    </td>
                                </tr>
                            </c:if>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="addBannerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-white">
                <h5 class="modal-title text-primary fw-bold">THÊM BANNER MỚI</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <form id="bannerForm" action="${pageContext.request.contextPath}/admin/banner-add" method="post" enctype="multipart/form-data">

                    <div class="mb-3">
                        <label class="form-label fw-bold">Chọn hình ảnh</label>
                        <input type="file" class="form-control" id="bannerFile" name="file" accept="image/*" required onchange="previewImage(this)">

                        <div class="preview-container">
                            <span class="placeholder-text" id="placeholderText">Chưa chọn ảnh</span>
                            <img id="imgPreview" class="preview-img" src="" alt="Preview">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Tiêu đề Banner</label>
                        <input type="text" class="form-control" name="title" placeholder="Ví dụ: Siêu sale mùa hè..." required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Đường dẫn (Link)</label>
                        <input type="text" class="form-control" name="link" placeholder="/sale/summer" required>
                    </div>

                    <div class="modal-footer border-0 px-0 pb-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary px-4">Lưu Banner</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="editBannerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-white">
                <h5 class="modal-title text-primary fw-bold">CHỈNH SỬA BANNER</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/admin/banner-edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" id="editId" name="id">
                    <input type="hidden" id="editOldImg" name="oldImg">

                    <div class="mb-3">
                        <label class="form-label fw-bold">Hình ảnh hiện tại / Thay ảnh mới</label>
                        <input type="file" class="form-control" name="file" accept="image/*" onchange="previewEditImage(this)">
                        <div class="preview-container">
                            <img id="editImgPreview" class="preview-img" style="display: block;" src="" alt="Preview">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Tiêu đề Banner</label>
                        <input type="text" class="form-control" id="editTitle" name="title" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Đường dẫn (Link)</label>
                        <input type="text" class="form-control" id="editLink" name="link" required>
                    </div>

                    <div class="modal-footer border-0 px-0 pb-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary px-4">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function previewImage(input) {
        const preview = document.getElementById('imgPreview');
        const placeholder = document.getElementById('placeholderText');

        if (input.files && input.files[0]) {
            const reader = new FileReader();

            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
                placeholder.style.display = 'none';
            }

            reader.readAsDataURL(input.files[0]);
        } else {
            preview.style.display = 'none';
            placeholder.style.display = 'block';
        }
    }

    document.addEventListener('click', function(e) {
        const deleteBtn = e.target.closest('.delete-btn');
        if (deleteBtn) {
            if(confirm('Bạn có chắc muốn xóa banner này vĩnh viễn?')) {
                const bannerId = deleteBtn.getAttribute('data-id');

                fetch('${pageContext.request.contextPath}/admin/banner-delete?id=' + bannerId)
                    .then(response => {
                        if(response.ok) {
                            deleteBtn.closest('tr').remove();
                        } else {
                            alert('Lỗi! Không thể xóa banner này.');
                        }
                    });
            }
        }
    });
    function previewEditImage(input) {
        const preview = document.getElementById('editImgPreview');
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) { preview.src = e.target.result; }
            reader.readAsDataURL(input.files[0]);
        }
    }
    document.addEventListener('click', function(e) {
        const editBtn = e.target.closest('.edit-btn');
        if (editBtn) {
            const id = editBtn.getAttribute('data-id');
            const title = editBtn.getAttribute('data-title');
            const link = editBtn.getAttribute('data-link');
            const img = editBtn.getAttribute('data-img');

            document.getElementById('editId').value = id;
            document.getElementById('editTitle').value = title;
            document.getElementById('editLink').value = link;
            document.getElementById('editOldImg').value = img;

            document.getElementById('editImgPreview').src = '${pageContext.request.contextPath}/' + img;

            const editModal = new bootstrap.Modal(document.getElementById('editBannerModal'));
            editModal.show();
        }
    });
</script>

</body>
</html>