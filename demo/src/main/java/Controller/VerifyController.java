package Controller;

import services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "VerifyController", value = "/verify")
public class VerifyController extends HttpServlet {
    AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");

        boolean success = authService.verify(token);

        if (success) {
            req.setAttribute("mess", "Kích hoạt thành công! Mời đăng nhập.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Link không hợp lệ hoặc đã được sử dụng!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}