package Controller.cart;

import cart.Cart;
import cart.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "DelProduct", value = "/del-cart")
public class DelProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        HttpSession session = req.getSession();
        Cart c = (Cart) session.getAttribute("cart");
        if (c != null) {
            c.deleteProduct(id);
        }
        resp.sendRedirect("cart");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        HttpSession session = req.getSession();
        Cart c = (Cart) session.getAttribute("cart");

        if (c != null) {
            c.deleteProduct(id);
        }

        int totalQty = (c == null) ? 0 : c.getTotalQuantity();
        double total = (c == null) ? 0 : c.getTotal();

        resp.setContentType("application/json");
        resp.getWriter().write(
                "{"
                        + "\"totalQty\":" + totalQty + ","
                        + "\"total\":" + total
                        + "}"
        );
    }
}
