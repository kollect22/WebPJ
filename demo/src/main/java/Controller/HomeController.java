package Controller;

import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Banner;
import model.Product;
import services.ProductService;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeController", value = {"/home", ""})
public class HomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductService service = new ProductService();
        List<Product> list = service.getListProduct();
        req.setAttribute("list", list);

        try {
            ProductDao productDao = new ProductDao();
            List<Banner> bannerList = productDao.getActiveBanners();

            req.setAttribute("bannerList", bannerList);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Lỗi load banner: " + e.getMessage());
        }

        req.getRequestDispatcher("home.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}