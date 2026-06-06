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
        String orderCode = req.getParameter("id");

        // Gọi DAO để tìm đơn hàng theo mã chữ
        Order order = orderDao.getOrderByCode(orderCode);

        if (order != null) {
            // Nếu có đơn hàng, lấy ID để tìm chi tiết các món hàng
            List<OrderDetail> orderDetails = orderDao.getOrderDetails(order.getId());

            req.setAttribute("order", order);
            req.setAttribute("orderDetails", orderDetails);
            req.getRequestDispatcher("/user/order-detail.jsp").forward(req, resp);
        } else {
            // Nếu không tìm thấy, đá về trang danh sách
            resp.sendRedirect(req.getContextPath() + "/my-orders?msg=OrderNotFound");
        }
    }
}