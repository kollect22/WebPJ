package Controller.cart;

import cart.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;
import services.ProductService;

import java.io.IOException;

@WebServlet(name = "AddCart", value = "/add-cart")
public class AddCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idStr = req.getParameter("id");
            String qStr = req.getParameter("q");
            String action = req.getParameter("action");

            if (idStr == null || idStr.isEmpty() || qStr == null || qStr.isEmpty()) {
                resp.sendError(400, "Thiếu ID hoặc số lượng sản phẩm");
                return;
            }

            int id = Integer.parseInt(idStr);
            int q = Integer.parseInt(qStr);

            ProductService ps = new ProductService();
            Product product = ps.getProduct(id);
            if (product == null) {
                resp.sendError(404, "Sản phẩm không tồn tại");
                return;
            }

            HttpSession session = req.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }
            cart.addProduct(product, q);
            session.setAttribute("cart", cart);

            if ("buy".equals(action)) {
                resp.sendRedirect("cart.jsp");
            } else {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"totalQuantity\":" + cart.getTotalQuantity() + "}");
            }

        } catch (NumberFormatException e) {

            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu số không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Lỗi Server: " + e.getMessage());
        }
    }
}