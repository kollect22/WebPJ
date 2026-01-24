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
document.addEventListener("DOMContentLoaded", () => {
    loadHTML("footer", "footer.jsp");
    countProducts();
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

// đếm sản pham
function countProducts(){
    //tim the co ten .p...
    const products = document.querySelectorAll('.product-item');
    //tim cho hien thu
    const countDisplay = document.getElementById('product-count-display');
    if(countDisplay){
        countDisplay.innerText= products.length + " sản phẩm";
    }
}

document.addEventListener("DOMContentLoaded", () => {
    const toggle = document.getElementById("sortToggle");
    const menu = document.getElementById("sortMenu");
    const items = document.querySelectorAll(".sort-item");
    const hiddenInput = document.getElementById("sort-value");
    const label = document.getElementById("current-sort-text");

    if (!toggle || !menu) return;

    // Mở / đóng menu
    toggle.addEventListener("click", e => {
        e.stopPropagation();
        menu.classList.toggle("show");
    });

    // Click chọn sort
    items.forEach(item => {
        item.addEventListener("click", e => {
            e.stopPropagation();

            items.forEach(i => i.classList.remove("active"));
            item.classList.add("active");

            const value = item.dataset.value;
            hiddenInput.value = value;
            label.textContent = item.textContent.trim();

            menu.classList.remove("show");
            console.log("SORT:", value);
        });
    });

    // Click ra ngoài thì đóng
    document.addEventListener("click", () => {
        menu.classList.remove("show");
    });
});


// -------productdetails-------
// function changeImage(el) {
//     const mainImage = document.getElementById("mainImage");
//     if (!mainImage) return;
//
//     mainImage.src = el.src;
//
//
//     document.querySelectorAll(".thumb-list img")
//         .forEach(img => img.classList.remove("active"));
//     el.classList.add("active");
// }
//
function changeImage(element) {
    // 1. Lấy đường dẫn ảnh mới từ thuộc tính data-src của chấm màu
    var newImageSrc = element.getAttribute("data-src");

    // 2. Lấy đường dẫn trang chi tiết mới từ data-link
    var newLinkHref = element.getAttribute("data-link");

    // 3. Tìm thẻ cha (product-item) bao bọc sản phẩm này
    var productCard = element.closest(".product-item");

    // 4. Tìm thẻ <img> bên trong thẻ cha đó và thay đổi src
    var mainImage = productCard.querySelector(".product-card-img");
    if (mainImage) {
        mainImage.src = newImageSrc;
    }

    // 5. (Tùy chọn) Tìm thẻ <a> bao quanh ảnh và đổi href
    // Để khi bấm vào ảnh to nó dẫn đúng sang trang của màu đó
    var mainLink = productCard.querySelector(".product-link");
    if (mainLink) {
        mainLink.href = newLinkHref;
    }

    // 6. Hiệu ứng viền active cho chấm màu đang chọn
    // Xóa class active ở các chấm khác trong cùng sản phẩm
    var siblings = productCard.querySelectorAll(".color-swatch");
    siblings.forEach(function(swatch) {
        swatch.style.borderColor = "#ddd"; // Màu viền mặc định
    });
    // Tô viền đen cho chấm vừa bấm
    element.style.borderColor = "#000";
}

document.addEventListener("DOMContentLoaded", function() {

    // --- 1. Xử lý Accordion ---
    const accordionHeaders = document.querySelectorAll(".accordion-header");
    accordionHeaders.forEach(header => {
        header.addEventListener("click", function() {
            const accordionItem = this.parentElement;
            accordionItem.classList.toggle("active");
        });
    });

    // --- 2. Xử lý Tăng/Giảm Số lượng ---
    const decreaseBtn = document.querySelector('.quantity-btn[aria-label="Giảm"]');
    const increaseBtn = document.querySelector('.quantity-btn[aria-label="Tăng"]');
    const quantityInput = document.querySelector('.quantity-control input');

    if (decreaseBtn && increaseBtn && quantityInput) {
        decreaseBtn.addEventListener("click", () => {
            let val = parseInt(quantityInput.value) || 1;
            if (val > 1) quantityInput.value = val - 1;
        });

        increaseBtn.addEventListener("click", () => {
            let val = parseInt(quantityInput.value) || 1;
            quantityInput.value = val + 1;
        });
    }
});

document.addEventListener('DOMContentLoaded', function (){
    const track = document.querySelector('.slider-track');

    if(!track) return;

    const slides = Array.from(track.children);
    const autoPlayDelay = 3000;
    let currentIndex =0;
    let autoPlayInterval;

    function setPositionByIndex() {
        track.style.transform = `translateX(-${currentIndex * 100}%)`;
    }

    function nextSlide() {
        if (currentIndex < slides.length - 1) {
            currentIndex += 1;
        } else {
            currentIndex = 0;
        }
        // Đảm bảo transition luôn bật khi auto-play
        track.style.transition = 'transform 0.5s ease-in-out';
        setPositionByIndex();
    }

    function startAutoPlay() {
        autoPlayInterval = setInterval(nextSlide, autoPlayDelay);
    }
    startAutoPlay();

});

// Hàm riêng cho trang Chi tiết (đổi ảnh Gallery)
function changeGalleryImage(thumbElement) {
    // Đổi ảnh chính
    var newSrc = thumbElement.src;
    document.getElementById("mainImage").src = newSrc;

    // Xử lý active class cho thumbnail
    var allThumbs = document.querySelectorAll(".thumb-list img");
    allThumbs.forEach(t => t.classList.remove("active"));
    thumbElement.classList.add("active");
}

// Các hàm tăng giảm số lượng
function increaseQty() {
    var input = document.getElementById("qtyInput");
    input.value = parseInt(input.value) + 1;
    document.getElementById("hiddenQty").value = input.value;
}

function decreaseQty() {
    var input = document.getElementById("qtyInput");
    if(parseInt(input.value) > 1) {
        input.value = parseInt(input.value) - 1;
        document.getElementById("hiddenQty").value = input.value;
    }
}

