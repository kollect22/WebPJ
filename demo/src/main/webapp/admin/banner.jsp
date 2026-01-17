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
                                <th class="py-3">Vị trí</th>
                                <th class="py-3 text-center">Hành động</th>
                            </tr>
                            </thead>
                            <tbody id="banner-table-body">
                            <tr>
                                <td class="ps-4">
                                    <img src="${pageContext.request.contextPath}/assets/img/banner-hlw.jpg"
                                         alt="Banner" class="banner-thumb"
                                         onerror="this.src='https://placehold.co/120x60?text=No+Img'">
                                </td>
                                <td class="fw-bold">Ưu đãi Halloween</td>
                                <td class="text-primary">/sale/halloween</td>
                                <td><span class="badge bg-primary">Banner Chính</span></td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary me-1"><i class="fa-solid fa-pen-to-square"></i></button>
                                    <button class="btn btn-sm btn-outline-danger delete-btn"><i class="fa-solid fa-trash"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td class="ps-4">
                                    <img src="${pageContext.request.contextPath}/assets/img/banner-collection.jpg"
                                         alt="Banner" class="banner-thumb"
                                         onerror="this.src='https://placehold.co/120x60?text=No+Img'">
                                </td>
                                <td class="fw-bold">Bộ sưu tập Túi Xách</td>
                                <td class="text-primary">/collection/tui-xach</td>
                                <td><span class="badge bg-info text-dark">Dưới Products</span></td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary me-1"><i class="fa-solid fa-pen-to-square"></i></button>
                                    <button class="btn btn-sm btn-outline-danger delete-btn"><i class="fa-solid fa-trash"></i></button>
                                </td>
                            </tr>
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

                    <div class="mb-3">
                        <label class="form-label fw-bold">Vị trí hiển thị</label>
                        <select class="form-select" name="position">
                            <option value="main">Banner Chính (Slider)</option>
                            <option value="sub">Dưới danh sách sản phẩm</option>
                            <option value="sidebar">Sidebar bên phải</option>
                        </select>
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
        if (e.target.closest('.delete-btn')) {
            if(confirm('Bạn có chắc muốn xóa banner này?')) {
                e.target.closest('tr').remove();
            }
        }
    });
</script>

</body>
</html>