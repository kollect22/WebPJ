package services;

import dao.RegisterDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "RegisterController", value = "/register-servlet")
public class RegisterController extends HttpServlet {

    private RegisterDao registerDao = new RegisterDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (registerDao.exists(email)) {
            request.setAttribute("error", "Email đã tồn tại!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        boolean success = registerDao.register(email, password);

        if (success) {
            HttpSession session = request.getSession();
            session.setAttribute("user", email);

            response.sendRedirect("home.jsp");
        } else {
            request.setAttribute("error", "Đăng ký thất bại!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
