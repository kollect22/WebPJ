package Controller;

import dao.OrderDao;
import model.Order;
import model.OrderDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderDetailController", value = "/admin/admin-order-detail")
public class AdminOrderDetailController extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }

            int orderId = Integer.parseInt(idParam);

            Order order = orderDao.getOrderById(orderId);
            List<OrderDetail> orderDetails = orderDao.getOrderDetails(orderId);

            if (order != null) {
                request.setAttribute("order", order);
                request.setAttribute("orderDetails", orderDetails);

                request.getRequestDispatcher("/admin/admin-order-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/orders");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi hệ thống: " + e.toString());
        }
    }
}
