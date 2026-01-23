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
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            ProductDao dao = new ProductDao();
            Product p = dao.getProduct(id);

            req.setAttribute("p", p);
            req.getRequestDispatcher("/admin/product-edit.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            String strPrice = req.getParameter("price");
            String img = req.getParameter("img");

            double tempPrice = 0;
            if (strPrice != null) {
                tempPrice = Double.parseDouble(strPrice.replace(",", "").replace(".", ""));
            }

            Product p = new Product();
            p.setId(id);
            p.setName(name);
            p.setPrice((int) tempPrice);
            p.setImg(img);
            p.setSalePrice(0);

            ProductDao dao = new ProductDao();
            dao.update(p);

            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}