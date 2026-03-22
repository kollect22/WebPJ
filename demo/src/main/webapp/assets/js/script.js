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

const productSections = document.querySelectorAll(".products");

productSections.forEach(section => {
    const productList = section.querySelector(".product-list");
    const btnLeft = section.querySelector(".scroll-left");
    const btnRight = section.querySelector(".scroll-right");

    if (productList && btnLeft && btnRight) {

        btnLeft.addEventListener("click", () => {
            productList.scrollBy({
                left: -scrollAmount,
                behavior: "smooth"
            });
        });

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
    filterBtn.addEventListener("click", () => {
        overlay.classList.add("active");
    });

    closeBtn.addEventListener("click", () => {
        overlay.classList.remove("active");
    });

    overlay.addEventListener("click", (e) => {
        if (e.target === overlay) {
            overlay.classList.remove("active");
        }
    });
}

// đếm sản pham
function countProducts(){
    const products = document.querySelectorAll('.product-item');
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

    toggle.addEventListener("click", e => {
        e.stopPropagation();
        menu.classList.toggle("show");
    });

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
    var newImageSrc = element.getAttribute("data-src");

    var newLinkHref = element.getAttribute("data-link");

    var productCard = element.closest(".product-item");

    var mainImage = productCard.querySelector(".product-card-img");
    if (mainImage) {
        mainImage.src = newImageSrc;
    }

    var mainLink = productCard.querySelector(".product-link");
    if (mainLink) {
        mainLink.href = newLinkHref;
    }

    var siblings = productCard.querySelectorAll(".color-swatch");
    siblings.forEach(function(swatch) {
        swatch.style.borderColor = "#ddd";
    });
    element.style.borderColor = "#000";
}

document.addEventListener("DOMContentLoaded", function() {

    const accordionHeaders = document.querySelectorAll(".accordion-header");
    accordionHeaders.forEach(header => {
        header.addEventListener("click", function() {
            const accordionItem = this.parentElement;
            accordionItem.classList.toggle("active");
        });
    });

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
        track.style.transition = 'transform 0.5s ease-in-out';
        setPositionByIndex();
    }

    function startAutoPlay() {
        autoPlayInterval = setInterval(nextSlide, autoPlayDelay);
    }
    startAutoPlay();

});

function changeGalleryImage(thumbElement) {
    var newSrc = thumbElement.src;
    document.getElementById("mainImage").src = newSrc;

    var allThumbs = document.querySelectorAll(".thumb-list img");
    allThumbs.forEach(t => t.classList.remove("active"));
    thumbElement.classList.add("active");
}

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

function addToCart(productId) {
    fetch(window.contextPath + '/add-cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'id=' + productId + '&q=1'
    })
        .then(res => res.json())

        .then(data => {
            const cartCountEl = document.querySelector('.cart-count');
            if (cartCountEl) {
                cartCountEl.innerText = data.totalQuantity;

                cartCountEl.classList.add('cart-bump');

                setTimeout(() => {
                    cartCountEl.classList.remove('cart-bump');
                }, 300);
            }
        });


}
function updateCart(productId, delta) {
    const qtyEl = document.getElementById('qty-' + productId);
    const currentQty = parseInt(qtyEl.innerText);

    if (currentQty === 1 && delta === -1) {
        alert(' Số lượng tối thiểu là 1');
        return;
    }

    fetch(window.contextPath + '/update-cart', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'id=' + productId + '&q=' + delta
    })
        .then(res => res.json())
        .then(data => {
            qtyEl.innerText = data.itemQuantity;

            document.getElementById('cart-total').innerText =
                new Intl.NumberFormat().format(data.total) + ' VNĐ';

            document.querySelector('.cart-count').innerText =
                data.totalQuantity;
            recalculateTotal();
        });
}



function deleteItem(productId) {
    fetch(window.contextPath + '/del-cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'id=' + productId
    })
        .then(res => res.json())
        .then(data => {

            const item = document.getElementById('item-' + productId);
            if (item) item.remove();

            // update tổng tiền
            document.getElementById('cart-total').innerText =
                new Intl.NumberFormat().format(data.total) + ' VNĐ';

            // update icon cart
            updateCartIcon(data.totalQty);
        });
}
function updateCartIcon(qty) {
    const el = document.getElementById('cart-count');
    if (el) el.innerText = qty;
}
function recalculateTotal() {
    let total = 0;

    document.querySelectorAll('.item-check').forEach(cb => {
        if (cb.checked) {
            const price = parseFloat(cb.dataset.price);
            const qty = parseInt(
                document.getElementById('qty-' + cb.dataset.id).innerText
            );
            total += price * qty;
        }
    });

    document.getElementById('cart-total').innerText =
        new Intl.NumberFormat().format(total) + ' VNĐ';
}










