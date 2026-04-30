package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import services.AuthService;

import java.io.IOException;

@WebServlet(name = "LoginController", value = "/login")
public class LoginController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        String redirectUrl = req.getParameter("redirect");

        AuthService as = new AuthService();
        User u = as.checkLogin(username,password);
        if (u != null ) {

            HttpSession session = req.getSession();
            session.setAttribute("auth",u);
            if (u.getRole() == 1) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                if (redirectUrl != null && !redirectUrl.isEmpty() && !redirectUrl.contains(".jsp")) {
                    resp.sendRedirect(redirectUrl);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/home");
                }
            }

        } else {
            req.setAttribute("error", "Sai username hoặc password");
            req.setAttribute("redirect", redirectUrl);
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req,resp);
        }
    }
