<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body>
<div class="d-flex" >
    <jsp:include page="/header.jsp"></jsp:include>
</div>
<div class="container">
    <nav aria-label="breadcrumb" class="bg-white p-3 rounded mb-4" style="margin-top: 100px">
        <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/index.jsp" class="text-decoration-none text-black">
                    <i class="fa-solid fa-house"></i> Trang chủ
                </a>
            </li>

            <li class="breadcrumb-item active">
                <a href="#" class="text-decoration-none text-black fw-bold">Thông tin</a>
            </li>

        </ol>
    </nav>
    <div class="row">

        <div class="col-lg-3 mb-4">
            <div class="list-group shadow-sm">
                <a href="${pageContext.request.contextPath}/user/profile.jsp" class="list-group-item list-group-item-action active text-white fw-bold" aria-current="true">
                    <i class="fa-regular fa-user me-2"></i> Thông tin tài khoản
                </a>

                <a href="${pageContext.request.contextPath}/user/orders.jsp" class="list-group-item list-group-item-action text-muted">
                    <i class="fa-solid fa-box me-2"></i> Đơn hàng của tôi
                </a>

                <a href="${pageContext.request.contextPath}/wishlist" class="list-group-item list-group-item-action text-muted">
                    <i class="fa-regular fa-heart me-2"></i> Sản phẩm yêu thích
                </a>

                <a href="${pageContext.request.contextPath}/user/change-password.jsp" class="list-group-item list-group-item-action text-muted">
                    <i class="fa-solid fa-lock me-2"></i> Đổi mật khẩu
                </a>

                <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action text-danger mt-2 border-top">
                    <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                </a>
            </div>
        </div>

        <div class="col-lg-9 col-md-8">
            <div class="bg-white p-4 rounded shadow-sm">
                <h4 class="mb-4 fw-bold text-black">Hồ sơ của tôi</h4>

                <form action="${pageContext.request.contextPath}/user/update-profile" method="POST">

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="fullName" class="form-label fw-bold">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Ví dụ: Nguyễn Văn A" value="${sessionScope.auth.fullName}" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="phone" class="form-label fw-bold">Số điện thoại <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control" id="phone" name="phone" pattern="(84|0[3|5|7|8|9])+([0-9]{8})" placeholder="Ví dụ: 0912345678" value="${sessionScope.auth.phone}" required title="Vui lòng nhập đúng số điện thoại 10 số">
                        </div>

                        <div class="col-md-6 mt-3 mt-md-0">
                            <label for="email" class="form-label fw-bold">Địa chỉ Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="email@example.com" value="${sessionScope.auth.email}" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold d-block">Giới tính <span class="text-danger">*</span></label>

                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="genderMale" value="Nam" required
                            ${empty sessionScope.auth.gender || sessionScope.auth.gender == 'Nam' ? 'checked' : ''}>
                            <label class="form-check-label" for="genderMale">Nam</label>
                        </div>

                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="Nu" required
                            ${sessionScope.auth.gender == 'Nu' ? 'checked' : ''}>
                            <label class="form-check-label" for="genderFemale">Nữ</label>
                        </div>
                        <h5 class="mb-3 mt-4 fw-bold text-black border-bottom pb-2">Địa chỉ nhận hàng</h5>

                        <input type="hidden" id="provinceName" name="provinceName" value="${sessionScope.auth.province}">
                        <input type="hidden" id="districtName" name="districtName" value="${sessionScope.auth.district}">
                        <input type="hidden" id="wardName" name="wardName" value="${sessionScope.auth.ward}">

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label for="province" class="form-label fw-bold">Tỉnh / Thành phố <span class="text-danger">*</span></label>
                                <select class="form-select" id="province" name="province" required>
                                    <option value="" selected disabled>Chọn Tỉnh/Thành</option>
                                </select>
                            </div>

                            <div class="col-md-4 mt-3 mt-md-0">
                                <label for="district" class="form-label fw-bold">Quận / Huyện <span class="text-danger">*</span></label>
                                <select class="form-select" id="district" name="district" required>
                                    <option value="" selected disabled>Chọn Quận/Huyện</option>
                                </select>
                            </div>

                            <div class="col-md-4 mt-3 mt-md-0">
                                <label for="ward" class="form-label fw-bold">Phường / Xã <span class="text-danger">*</span></label>
                                <select class="form-select" id="ward" name="ward" required>
                                    <option value="" selected disabled>Chọn Phường/Xã</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="specificAddress" class="form-label fw-bold">Địa chỉ cụ thể (Số nhà, ngõ, tên đường) <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="specificAddress" name="specificAddress"
                                   placeholder="Ví dụ: 123 Lê Lợi, Tòa nhà Bitexco..."
                                   value="${sessionScope.auth.specificAddress}" required>
                        </div>

                    <hr class="mb-4">

                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-dark px-4 py-2 fw-bold">Lưu thay đổi</button>
                    </div>

                </form>
            </div>
        </div>

    </div>
</div>

<div class="d-flex">
    <jsp:include page="/footer.jsp"></jsp:include>
</div>
<script src="${pageContext.request.contextPath}/assets/js/api-tinhthanh.js"></script>
</body>
</html>
