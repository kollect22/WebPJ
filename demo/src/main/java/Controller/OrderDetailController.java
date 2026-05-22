package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;
import model.OrderDetail;
import dao.OrderDao;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderDetailController", value = "/order-detail")
public class OrderDetailController extends HttpServlet {
    private OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy mã đơn hàng từ trên thanh URL xuống
        String orderId = req.getParameter("id");

        if (orderId == null || orderId.isEmpty()) {
            resp.sendRedirect("my-my-orders.jsp");
            return;
        }

        Order order = orderDao.getOrderByCode(orderId);
        List<OrderDetail> orderDetails = orderDao.getOrderDetails(order.getId());

        // Gửi dữ liệu sang JSP
        req.setAttribute("order", order);
        req.setAttribute("orderDetails", orderDetails);

        // Điều hướng sang file JSP
        req.getRequestDispatcher("order-detail.jsp").forward(req, resp);
    }
}