package Controller;

import dao.RegisterDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import services.AuthService;

import java.io.IOException;

@WebServlet(name = "RegisterController", value = "/register")
public class RegisterController extends HttpServlet {

    private AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String fullName = req.getParameter("fullName");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập tài khoản!");
            req.getRequestDispatcher("register.jsp").forward(req, res);
            return;
        }

        boolean isSuccess = authService.register(username, password, fullName);

        if (isSuccess) {
            req.getSession().setAttribute("user", username);
            res.sendRedirect(req.getContextPath() + "/home");
        } else {
            req.setAttribute("error", "Tài khoản đã tồn tại!");
            req.getRequestDispatcher("register.jsp").forward(req, res);
        }
    }
}
