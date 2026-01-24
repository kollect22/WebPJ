package Controller.cart;


import cart.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product; import services.ProductService;
import java.io.IOException;

@WebServlet(name = "AddCart", value= "/add-cart")
public class AddCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        int q = Integer.parseInt(req.getParameter("q"));
        ProductService ps = new ProductService();
        Product product = ps.getProduct(id);
        if (product == null) {
            resp.sendRedirect(req.getContextPath() + "/list-product.jsp");
            return;
        }
        HttpSession session = req.getSession();
        Cart c = (Cart) session.getAttribute("cart");
        if (c == null) {
            c = new Cart();
        }
        c.addProduct(product, q);
        session.setAttribute("cart", c);
        String referer = req.getHeader("referer");
        resp.sendRedirect(referer);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}