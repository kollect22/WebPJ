package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import services.AuthService;
import util.Validator;

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

        if (!Validator.isValidUsername(username)) {
            req.setAttribute("error", "Vui lòng nhập đúng định dạng Email hoặc Số điện thoại (10 số)!");
            req.getRequestDispatcher("login.jsp").forward(req, res);
            return;
        }

        if (!Validator.isStrongPassword(password)) {
            req.setAttribute("error", "Mật khẩu phải trên 8 ký tự, bao gồm chữ hoa, chữ thường và số!");
            req.getRequestDispatcher("login.jsp").forward(req, res);
            return;
        }

        if (fullName != null) {
            fullName = fullName.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
        }

        String appUrl = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+ req.getContextPath();

        boolean isSuccess = authService.register(username, password, fullName, appUrl);

        if (isSuccess) {
            if (username.contains("@")) {
                req.setAttribute("mess", "Đăng ký thành công! Vui lòng kiểm tra Email để kích hoạt tài khoản.");
            } else {
                req.setAttribute("mess", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
            }

            req.getRequestDispatcher("login.jsp").forward(req, res);
        } else {
            req.setAttribute("error", "Tài khoản (Email/SĐT) đã tồn tại!");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
}