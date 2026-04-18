package Controller;

import dao.UserDao;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.MD5;

import java.io.IOException;

@WebServlet(name = "ChangePasswordController", value = "/user/change-password")
public class ChangePasswordController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("auth") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        req.getRequestDispatcher("change-password.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();

        User currentUser = (User) session.getAttribute("auth");
        if (currentUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String oldPass = req.getParameter("oldPassword");
        String newPass = req.getParameter("newPassword");
        String confirmPass = req.getParameter("confirmPassword");

        if (!newPass.equals(confirmPass)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
            return;
        }

        String oldPassHash = MD5.getMd5(oldPass);
        String newPassHash = MD5.getMd5(newPass);

        UserDao dao = new UserDao();
        boolean isSuccess = dao.changePassword(currentUser.getId(), oldPass, newPass);

        if (isSuccess) {
            req.setAttribute("success", "Đổi mật khẩu thành công!");
            currentUser.setPassword(newPassHash);
            req.getSession().setAttribute("auth", currentUser);
        } else {
            req.setAttribute("error", "Mật khẩu cũ không chính xác!");
        }

        req.getRequestDispatcher("change-password.jsp").forward(req, resp);
    }
}