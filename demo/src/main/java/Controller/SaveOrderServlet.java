package Controller;

import cart.Cart;
import cart.CartItem;
import dao.OrderDao;
import dao.ProductDao;
import model.Order;
import model.OrderDetail;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/save-order")
public class SaveOrderServlet extends HttpServlet {

    // Trong doPost của SaveOrderServlet
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart"); // Giả sử giỏ hàng của bạn tên là cart

        if (cart == null || cart.getList().isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        // 1. Thu thập dữ liệu từ Form
        Order order = new Order();
        order.setOrderIdCode("ORD" + System.currentTimeMillis());
        order.setFullName(((User)session.getAttribute("auth")).getFullName());
        order.setPhone(request.getParameter("phone"));
        order.setAddress(request.getParameter("address"));
        order.setTotalPrice(Double.parseDouble(request.getParameter("totalPrice")));
        order.setPaymentMethod("COD");
        order.setStatus(0); // Mới đặt

        // 2. Chuyển đổi từ Giỏ hàng sang danh sách OrderDetail
        List<OrderDetail> details = new ArrayList<>();
        for (CartItem item : cart.getList()) {
            OrderDetail d = new OrderDetail();
            d.setProductId(item.getProduct().getId());
            d.setQuantity(item.getQuantity());
            d.setPrice(item.getPrice());
            details.add(d);
        }

        OrderDao orderDao = new OrderDao();
        orderDao.insertOrder(order, details);

        ProductDao pDao = new ProductDao();
        session.setAttribute("recommendedList", pDao.getRecommendedProducts(3));
        session.setAttribute("orderId", order.getOrderIdCode());


        session.removeAttribute("cart");
        request.getRequestDispatcher("thankyou.jsp").forward(request, response);
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}