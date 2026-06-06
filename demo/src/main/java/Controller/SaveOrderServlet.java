package Controller;

import cart.Cart;
import cart.CartItem;
import dao.OrderDao;
import dao.ProductDao;
import model.Order;
import model.OrderDetail;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/save-order")
public class SaveOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User auth = (User) session.getAttribute("auth");

        if (auth == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (cart == null || cart.getList().isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        String purchasedIds = request.getParameter("purchasedIds");
        String[] idsArray = (purchasedIds != null && !purchasedIds.isEmpty()) ? purchasedIds.split(",") : new String[0];

        String orderIdCode = "ORD" + System.currentTimeMillis();
        Order order = new Order();
        order.setOrderIdCode(orderIdCode);
        order.setUserId(auth.getId());
        order.setFullName(auth.getFullName());
        order.setPhone(request.getParameter("phone"));
        order.setAddress(request.getParameter("address"));
        order.setTotalPrice(Double.parseDouble(request.getParameter("totalPrice")));
        order.setPaymentMethod("COD");
        order.setStatus(0);

        List<OrderDetail> details = new ArrayList<>();
        for (CartItem item : cart.getList()) {
            if (idsArray.length == 0) {
                OrderDetail d = new OrderDetail();
                d.setProductId(item.getProduct().getId());
                d.setQuantity(item.getQuantity());
                d.setPrice(item.getProduct().getPrice());
                details.add(d);
            } else {
                for (String id : idsArray) {
                    if (String.valueOf(item.getProduct().getId()).equals(id.trim())) {
                        OrderDetail d = new OrderDetail();
                        d.setProductId(item.getProduct().getId());
                        d.setQuantity(item.getQuantity());
                        d.setPrice(item.getPrice());
                        details.add(d);
                        break;
                    }
                }
            }
        }

        OrderDao orderDao = new OrderDao();
        int newOrderId = orderDao.insertOrder(order, details);

        if (newOrderId > 0) {
            ProductDao pDao = new ProductDao();
            session.setAttribute("recommendedList", pDao.getRecommendedProducts(3));
            session.setAttribute("orderId", orderIdCode);

            if (idsArray.length > 0) {
                for (String idStr : idsArray) {
                    try {
                        cart.deleteProduct(Integer.parseInt(idStr.trim()));
                    } catch (Exception e) {}
                }
                session.setAttribute("cart", cart);
            } else {
                session.removeAttribute("cart");
            }
            request.getRequestDispatcher("thankyou.jsp").forward(request, response);
        } else {
            response.getWriter().println("Lỗi: Không thể lưu đơn hàng COD.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}