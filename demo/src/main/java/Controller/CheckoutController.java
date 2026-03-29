package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

// Import đúng 2 nơi chứa class của bạn
import cart.Cart;
import model.User;

@WebServlet(name = "CheckoutController", value = "/checkout")
public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // 1. Kiểm tra đăng nhập (biến "auth" như bạn đã đặt)
        User user = (User) session.getAttribute("auth");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        // 2. Kiểm tra giỏ hàng
        Cart cart = (Cart) session.getAttribute("cart");

        // Thay vì cart.getItems(), mình check trực tiếp cart
        if (cart == null) {
            resp.sendRedirect("home");
            return;
        }

        // 3. Đẩy sang giao diện
        req.getRequestDispatcher("checkout.jsp").forward(req, resp);
    }
}