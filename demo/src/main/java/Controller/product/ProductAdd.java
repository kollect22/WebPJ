package Controller.product;

import dao.ProductDao;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;

@WebServlet(name = "ProductAddController", value = "/admin/product-add")
public class ProductAdd extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            String name = req.getParameter("name");
            String strPrice = req.getParameter("price");
            String img = req.getParameter("img");

            String category = req.getParameter("category");
            String description = req.getParameter("description");

            double price = 0;
            if (strPrice != null && !strPrice.isEmpty()) {
                price = Double.parseDouble(strPrice);
            }

            if (img == null || img.trim().isEmpty()) {
                img = "https://placehold.co/400x400?text=No+Image";
            }

            Product newProduct = new Product();
            newProduct.setName(name);
            newProduct.setPrice((int) price);
            newProduct.setImg(img);
            newProduct.setSalePrice(0);

            newProduct.setDescription(description);
            newProduct.setCategory(category);

            ProductDao dao = new ProductDao();
            dao.insert(Arrays.asList(newProduct));

            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi Thêm sản phẩm: " + e.getMessage());
        }
    }
}