package Controller.product;

import dao.ProductDao;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// Mapping đường dẫn "/detail"
@WebServlet(name = "ProductDetailController", urlPatterns = "/detail")
public class ProductDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");

        if (idParam == null) {
            resp.sendRedirect("home");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            ProductDao dao = new ProductDao();
            Product p = dao.getProduct(id);

            if (p == null) {
                resp.getWriter().print("Sản phẩm không tồn tại");
                return;
            }

            // Gửi dữ liệu sang JSP
            req.setAttribute("product", p);
            req.setAttribute("listImages", p.getGalleryImages());
            req.setAttribute("relatedColors", p.getColors());

            // Chuyển hướng đến file giao diện
            req.getRequestDispatcher("product-details.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h1>Đã xảy ra lỗi!</h1>");
            resp.getWriter().println("<p>" + e.getMessage() + "</p>");
            resp.getWriter().println("<pre>");
            e.printStackTrace(resp.getWriter());
            resp.getWriter().println("</pre>");
        }
    }
}