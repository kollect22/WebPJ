package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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


//        if (list == null || list.isEmpty()) {
//            System.out.println("Danh sách rỗng.");
//        } else {
//            System.out.println("Ok " + list.size() + " sản phẩm.");
//            // In thử tên sản phẩm đầu tiên để chắc chắn
//            System.out.println("   -> Sản phẩm 1: " + list.get(0).getName());
//        }
//        // ----------------------------

        req.setAttribute("list", list);
        req.getRequestDispatcher("home.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}