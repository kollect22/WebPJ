package services;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name ="AdminController", urlPatterns = {
        "/admin/dashboard",
        "/admin/products",
        "/admin/coupons",
        "/admin/customers",
        "/admin/banner",
        "/admin/orders"})
public class AdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String path = req.getServletPath();
        String targetPage = "";

        switch (path) {
            case "/admin/dashboard":
                targetPage = "/admin/dashboard.jsp";
                break;
            case "/admin/products":
                targetPage = "/admin/products.jsp";
                break;
            case "/admin/coupons":
                targetPage = "/admin/coupons.jsp";
                break;
            case "/admin/customers":
                targetPage = "/admin/customers.jsp";
                break;
            case "/admin/banner":
                targetPage = "/admin/banner.jsp";
                break;
            case "/admin/orders":
                targetPage = "/admin/orders.jsp";
                break;
            default:
                targetPage = "/admin/dashboard.jsp";
        }
        req.getRequestDispatcher(targetPage).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
