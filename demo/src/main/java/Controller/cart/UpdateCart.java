package Controller.cart;

import cart.Cart;
import cart.CartItem;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpdateCart", value = "/update-cart")
public class UpdateCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        int delta = Integer.parseInt(req.getParameter("q"));

        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) return;

        // cập nhật cart
        cart.updateProduct(id, delta);
        session.setAttribute("cart", cart);

        // lấy lại số lượng item vừa update
        int itemQty = cart.getList().stream()
                .filter(i -> i.getProduct().getId() == id)
                .mapToInt(CartItem::getQuantity)
                .findFirst()
                .orElse(0);

        // trả JSON
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        resp.getWriter().write(
                "{"
                        + "\"itemQuantity\":" + itemQty + ","
                        + "\"total\":" + cart.getTotal() + ","
                        + "\"totalQuantity\":" + cart.getTotalQuantity()
                        + "}"
        );
    }
}
