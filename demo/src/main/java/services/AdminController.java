package services;

import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.util.List;

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
                req.setAttribute("activeMenu", "dashboard");
                targetPage = "/admin/dashboard.jsp";
                break;
            case "/admin/products":
                ProductDao productDao = new ProductDao();
                List<Product> list = productDao.getListProduct();

                req.setAttribute("productList", list);
                req.setAttribute("activeMenu", "products");
                targetPage = "/admin/products.jsp";
                break;
            case "/admin/coupons":
                req.setAttribute("activeMenu", "coupons");
                targetPage = "/admin/coupons.jsp";
                break;
            case "/admin/customers":
                req.setAttribute("activeMenu", "customer");
                targetPage = "/admin/customer.jsp";
                break;
            case "/admin/banner":
                req.setAttribute("activeMenu", "banner");
                targetPage = "/admin/banner.jsp";
                break;
            case "/admin/orders":
                req.setAttribute("activeMenu", "orders");
                targetPage = "/admin/orders.jsp";
                break;
            default:
                req.setAttribute("activeMenu", "dashboard");
                targetPage = "/admin/dashboard.jsp";
        }
        req.getRequestDispatcher(targetPage).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
