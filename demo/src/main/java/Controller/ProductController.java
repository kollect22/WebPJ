package Controller;

import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.Review;
import java.util.List;
import services.ProductService;

import java.io.IOException;

@WebServlet(name = "ProductController", value = "/product-detail")
public class ProductController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        ProductService ps = new ProductService();

        try {
            int idP = Integer.parseInt(id);
            Product p = ps.getProduct(idP);
            if (p != null) {
                req.setAttribute("product", p);

                ProductDao dao = new ProductDao();

                List<model.Review> reviewList = dao.getReviewByProductId(idP);
                req.setAttribute("reviews", reviewList);

                req.getRequestDispatcher("product-details.jsp").forward(req, resp);
            } else {
                resp.sendRedirect("products");
            }
        } catch (NumberFormatException e) {
            throw new RuntimeException(e);
        }
    }
}
