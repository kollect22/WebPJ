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

@WebServlet("/user/update-profile")
public class UpdateProfileController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("auth");

        if (currentUser != null) {
            // Lấy dữ liệu từ form dán vào đối tượng User hiện tại
            currentUser.setFullName(req.getParameter("fullName"));
            currentUser.setPhone(req.getParameter("phone"));
            currentUser.setEmail(req.getParameter("email"));
            currentUser.setGender(req.getParameter("gender"));
            // Lấy tên tỉnh/huyện từ thẻ hidden (provinceName) chứ không phải (province)
            currentUser.setProvince(req.getParameter("provinceName"));
            currentUser.setDistrict(req.getParameter("districtName"));
            currentUser.setWard(req.getParameter("wardName"));
            currentUser.setSpecificAddress(req.getParameter("specificAddress"));

            // Gọi DAO để lưu xuống db
            AuthDao authDao = new AuthDao();
            boolean isSuccess = authDao.updateUserProfile(currentUser);

            if (isSuccess) {
                // Cập nhật lại Session
                session.setAttribute("auth", currentUser);
                resp.sendRedirect(req.getContextPath() + "/user/profile.jsp?status=success");
            } else {
                resp.sendRedirect(req.getContextPath() + "/user/profile.jsp?status=error");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
}