package Controller;

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
        "/admin/customer",
        "/admin/banner",
        "/admin/orders",
        "/admin/category"})
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

                String search = req.getParameter("search");

                int page = 1;
                String pageParam = req.getParameter("page");
                if (pageParam != null && !pageParam.isEmpty()) {
                    page = Integer.parseInt(pageParam);
                }

                int pageSize = 10;
                int offset = (page - 1) * pageSize;

                int totalProducts = productDao.getTotalProducts(search);
                int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

                List<Product> list = productDao.getProductsWithPagination(search, offset, pageSize);

                req.setAttribute("prodcd List", list);
                req.setAttribute("currentPage", page);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("search", search);

                req.setAttribute("activeMenu", "products");
                targetPage = "/admin/products.jsp";
                break;
            case "/admin/coupons":
                dao.CouponDao couponDao = new dao.CouponDao();

                String searchCoupon = req.getParameter("search");

                List<model.Coupon> couponList = couponDao.getAllCoupons(searchCoupon);

                req.setAttribute("couponList", couponList);
                req.setAttribute("search", searchCoupon);

                req.setAttribute("activeMenu", "coupons");
                targetPage = "/admin/coupons.jsp";
                break;
            case "/admin/customer":
                dao.UserDao userDao = new dao.UserDao();

                List<model.User> userList = userDao.getAllUsers();
                req.setAttribute("userList", userList);

                req.setAttribute("activeMenu", "customer");
                targetPage = "/admin/customer.jsp";
                break;
            case "/admin/banner":
                req.setAttribute("activeMenu", "banner");
                targetPage = "/admin/banner.jsp";
                break;
            case "/admin/orders":
                dao.OrderDao orderDao = new dao.OrderDao();

                List<model.Order> orderList = orderDao.getAllOrders();

                req.setAttribute("orderList", orderList);

                req.setAttribute("activeMenu", "orders");
                targetPage = "/admin/orders.jsp";
                break;
            case "/admin/category":
                dao.CategoryDao categoryDao = new dao.CategoryDao();
                List<model.Category> categoryList = categoryDao.getAll();

                req.setAttribute("categoryList", categoryList);
                req.setAttribute("activeMenu", "category");
                targetPage = "/admin/category.jsp";
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
