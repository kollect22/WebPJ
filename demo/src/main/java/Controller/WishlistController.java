package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// Định nghĩa đường dẫn là /wishlist
@WebServlet(name = "WishlistController", urlPatterns = "/wishlist")
public class WishlistController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Thiết lập tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 2. Đặt tiêu đề cho trang (để file header.jsp hoặc <title> sử dụng)
        request.setAttribute("pageTitle", "Sản phẩm yêu thích");

        // 3. Chuyển hướng sang file giao diện JSP
        request.getRequestDispatcher("/wishlist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Nếu có xử lý form POST thì viết ở đây, hiện tại chỉ cần GET để xem trang
        doGet(request, response);
    }
}