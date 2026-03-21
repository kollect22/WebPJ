package Controller.product;

import dao.ProductDao;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ProductEditController", value = "/admin/product-edit")
public class ProductEdit extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            String strPrice = req.getParameter("price");
            String img = req.getParameter("img");

            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String description = req.getParameter("description");

            double tempPrice = 0;
            if (strPrice != null && !strPrice.isEmpty()) {
                tempPrice = Double.parseDouble(strPrice.replace(",", "").replace(".", ""));
            }

            ProductDao dao = new ProductDao();

            Product p = dao.getProduct(id);

            if (p != null) {
                p.setName(name);
                p.setPrice((int) tempPrice);
                p.setImg(img);
                p.setCategoryId(categoryId);
                p.setQuantity(quantity);
                p.setDescription(description);

                dao.update(p);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=update_failed");
        }
    }
}