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
    loadHTML("header", "header.html");
    loadHTML("footer", "footer.html");
});

//scroll top button
const btn = document.getElementById("scrollTopBtn");

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
//scroll left right
document.querySelectorAll(".products").forEach(section => {
    const list = section.querySelector(".product-list");
    const items = list.querySelectorAll(".product-item");
    const leftBtn = section.querySelector(".scroll-left");
    const rightBtn = section.querySelector(".scroll-right");

    // Ẩn sản phẩm từ sản phẩm thứ 5
    items.forEach((item, index) => {
        if (index >= 4) item.style.display = "none";
    });

    // Cuộn theo từng item
    const itemWidth = items[0].offsetWidth + 20; // 20 là gap

    rightBtn.onclick = () => {
        list.scrollLeft += itemWidth;
    };

    leftBtn.onclick = () => {
        list.scrollLeft -= itemWidth;
    };
});