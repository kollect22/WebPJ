package Controller;

import dao.OrderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateOrderStatusController", value = "/admin/update-order-status")
public class UpdateOrderStatusController extends HttpServlet {
    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            int status = Integer.parseInt(req.getParameter("status"));

            orderDao.updateOrderStatus(id, status);

            resp.sendRedirect(req.getContextPath() + "/admin/admin-order-detail?id=" + id);

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi hệ thống: " + e.toString());
        }
    }
}