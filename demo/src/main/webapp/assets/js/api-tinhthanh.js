    document.addEventListener("DOMContentLoaded", function() {
    // Lấy các thẻ select và thẻ hidden
    const provinceSelect = document.getElementById("province");
    const districtSelect = document.getElementById("district");
    const wardSelect = document.getElementById("ward");

    const provinceName = document.getElementById("provinceName");
    const districtName = document.getElementById("districtName");
    const wardName = document.getElementById("wardName");

    // 1. Gọi API lấy danh sách Tỉnh/Thành phố khi vừa load trang
    fetch('https://esgoo.net/api-tinhthanh/1/0.htm')
    .then(response => response.json())
    .then(data => {
    if (data.error === 0) {
    data.data.forEach(item => {
    let option = document.createElement("option");
    option.value = item.id; // Value chứa ID để API dùng
    option.text = item.full_name; // Text chứa Tên chữ để hiển thị
    provinceSelect.appendChild(option);
});
}
});

    // 2. Bắt sự kiện khi người dùng chọn/đổi Tỉnh/Thành
    provinceSelect.addEventListener("change", function() {
    // Lưu lại Tên chữ vào thẻ ẩn để chuẩn bị gửi về Server
    provinceName.value = this.options[this.selectedIndex].text;

    // Làm sạch dữ liệu cũ của Quận/Huyện và Phường/Xã
    districtSelect.innerHTML = '<option value="" selected disabled>Chọn Quận/Huyện</option>';
    wardSelect.innerHTML = '<option value="" selected disabled>Chọn Phường/Xã</option>';
    wardName.value = "";
    districtName.value = "";

    // Gọi API lấy Quận/Huyện dựa theo ID Tỉnh vừa chọn
    let provinceId = this.value;
    fetch(`https://esgoo.net/api-tinhthanh/2/${provinceId}.htm`)
    .then(response => response.json())
    .then(data => {
    if (data.error === 0) {
    data.data.forEach(item => {
    let option = document.createElement("option");
    option.value = item.id;
    option.text = item.full_name;
    districtSelect.appendChild(option);
});
}
});
});

    // 3. Bắt sự kiện khi người dùng chọn/đổi Quận/Huyện
    districtSelect.addEventListener("change", function() {
    // Lưu Tên Quận vào thẻ ẩn
    districtName.value = this.options[this.selectedIndex].text;

    // Làm sạch dữ liệu cũ của Phường/Xã
    wardSelect.innerHTML = '<option value="" selected disabled>Chọn Phường/Xã</option>';
    wardName.value = "";

    // Gọi API lấy Phường/Xã dựa theo ID Quận vừa chọn
    let districtId = this.value;
    fetch(`https://esgoo.net/api-tinhthanh/3/${districtId}.htm`)
    .then(response => response.json())
    .then(data => {
    if (data.error === 0) {
    data.data.forEach(item => {
    let option = document.createElement("option");
    option.value = item.id;
    option.text = item.full_name;
    wardSelect.appendChild(option);
});
}
});
});

    // 4. Bắt sự kiện khi người dùng chọn/đổi Phường/Xã
    wardSelect.addEventListener("change", function() {
    // Lưu Tên Phường vào thẻ ẩn
    wardName.value = this.options[this.selectedIndex].text;
});
});
