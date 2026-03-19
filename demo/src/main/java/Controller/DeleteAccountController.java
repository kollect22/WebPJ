package Controller;

import dao.AuthDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebServlet("/user/delete-profile")
public class DeleteAccountController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("auth") != null) {
            User currentUser = (User) session.getAttribute("auth");

            // Xóa dưới Database
            AuthDao authDao = new AuthDao();
            authDao.deleteUser(currentUser.getId());

            // Hủy phiên đăng nhập
            session.invalidate();
        }

        // Trả về trang chủ sau khi xóa xong
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}