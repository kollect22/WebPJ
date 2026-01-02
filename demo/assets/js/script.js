function loadHTML(id, file) {
    fetch(file)
        .then(response => {
            if (!response.ok) throw new Error("Không thể tải file: " + file);
            return response.text();
        })
        .then(data => {
            document.getElementById(id).innerHTML = data;
        })
        .catch(err => console.error(err));
}

// Gọi hàm khi trang load
window.addEventListener("DOMContentLoaded", () => {
    loadHTML("header", "header.jsp");
    loadHTML("footer", "footer.jsp");
});

//scroll top button
const btn = document.getElementById("scrollTopBtn");

if(btn){
    window.onscroll = function () {
        if (document.documentElement.scrollTop > 200) {
            btn.style.display = "flex";
        } else {
            btn.style.display = "none";
        }
    };

    btn.onclick = function () {
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
    };
}
//scroll left right
const scrollAmount = 335;

// 1. Chọn TẤT CẢ các container cha có class "products"
const productSections = document.querySelectorAll(".products");

// 2. Lặp qua từng container (section) sản phẩm
productSections.forEach(section => {
    // Trong mỗi section, tìm danh sách sản phẩm và các nút cuộn tương ứng
    const productList = section.querySelector(".product-list");
    const btnLeft = section.querySelector(".scroll-left");
    const btnRight = section.querySelector(".scroll-right");

    // Đảm bảo tất cả các phần tử đều tồn tại trước khi gán sự kiện
    if (productList && btnLeft && btnRight) {

        // Gán sự kiện cho nút bên trái của section hiện tại
        btnLeft.addEventListener("click", () => {
            productList.scrollBy({
                left: -scrollAmount,
                behavior: "smooth"
            });
        });

        // Gán sự kiện cho nút bên phải của section hiện tại
        btnRight.addEventListener("click", () => {
            productList.scrollBy({
                left: scrollAmount,
                behavior: "smooth"
            });
        });
    }
});

//Bộ Lọc trong product
const filterBtn = document.getElementById("filter-toggle-btn")
const closeBtn = document.getElementById("filter-close-btn");
const overlay = document.getElementById("filter-overlay");

if (filterBtn && closeBtn && overlay) {
    // Mở sidebar
    filterBtn.addEventListener("click", () => {
        overlay.classList.add("active");
    });

    // Đóng sidebar bằng nút X
    closeBtn.addEventListener("click", () => {
        overlay.classList.remove("active");
    });

    // Đóng sidebar khi bấm ra ngoài
    overlay.addEventListener("click", (e) => {
        if (e.target === overlay) {
            overlay.classList.remove("active");
        }
    });
}



