<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<footer class="footer">
    <div class="footer-container">

        <div class="footer-col">
            <h3>FASHION STORE</h3>
            <p style="margin-top: 20px;">Nâng tầm phong cách của bạn với những bộ sưu tập túi xách thời thượng nhất.</p>
            <div class="contact-info" style="margin-top: 20px;">
                <p><i class="fa-solid fa-location-dot"></i> 123 Đường Nguyễn Văn Cừ, Q.5, TP.HCM</p>
                <p><i class="fa-solid fa-phone"></i> 1900 1000 (9:00 - 21:00)</p>
                <p><i class="fa-solid fa-envelope"></i> support@fashionstore.com</p>

                <div class="footer-icons">
                    <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#"><i class="fa-brands fa-tiktok"></i></a>
                    <a href="#"><i class="fa-brands fa-youtube"></i></a>
                </div>
            </div>
        </div>

        <div class="footer-col">
            <h3>HỖ TRỢ KHÁCH HÀNG</h3>
            <ul>
                <li><a href="#">Hướng dẫn mua hàng</a></li>
                <li><a href="#">Chính sách giao hàng</a></li>
                <li><a href="#">Chính sách đổi trả</a></li>
                <li><a href="#">Chính sách bảo mật</a></li>
                <li><a href="#">Câu hỏi thường gặp (FAQs)</a></li>
            </ul>
        </div>

        <div class="footer-col">
            <h3>Về chúng tôi</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/introduce.jsp">Giới thiệu</a></li>
                <li><a href="#">Tuyển dụng</a></li>
                <li><a href="#">Liên hệ hợp tác</a></li>
            </ul>
        </div>

        <div class="footer-col">
            <h3>ĐĂNG KÝ NHẬN TIN</h3>
            <p>Nhận thông tin về các chương trình khuyến mãi sớm nhất.</p>

            <form class="newsletter-form" action="#" method="get">
                <input type="email" placeholder="Nhập email của bạn..." required>
                <button type="submit"><i class="fa-solid fa-arrow-right"></i></button>
            </form>
        </div>
    </div>

    <div class="copyright">
        <p>© 2025 Fashion Store. All rights reserved.</p>
    </div>
</footer>