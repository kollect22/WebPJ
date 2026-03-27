package Controller;

import dao.ProductDao;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "WishlistController", urlPatterns = "/wishlist-add")
public class WishlistController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idRaw = request.getParameter("id");
        HttpSession session = request.getSession();
        ProductDao dao = new ProductDao();


        List<Integer> wishlistIds = (List<Integer>) session.getAttribute("wishlistSession");
        if (wishlistIds == null) wishlistIds = new ArrayList<>();


        if (idRaw != null && !idRaw.isEmpty()) {
            int pId = Integer.parseInt(idRaw);
            String status = "";

            if (wishlistIds.contains(pId)) {
                wishlistIds.remove(Integer.valueOf(pId));
                status = "removed";
            } else {
                wishlistIds.add(pId);
                status = "success";
            }
            session.setAttribute("wishlistSession", wishlistIds);


            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"status\": \"" + status + "\", \"count\": " + wishlistIds.size() + "}");
            return;
        }


        List<Product> wishlistProducts = new ArrayList<>();
        for (Integer id : wishlistIds) {
            Product p = dao.getProduct(id);
            if (p != null) wishlistProducts.add(p);
        }

        request.setAttribute("wishlistProducts", wishlistProducts);
        request.setAttribute("pageTitle", "Sản phẩm yêu thích");
        request.getRequestDispatcher("/wishlist.jsp").forward(request, response);
    }
}