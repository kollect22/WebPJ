package Controller;

import dao.OrderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CancelOrderController", value = "/cancel-order")
public class CancelOrderController extends HttpServlet {
    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String reason = req.getParameter("cancelReason");

            if (reason != null) {
                reason = reason.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
            }

            boolean isCanceled = orderDao.cancelOrder(orderId, reason);

            if (isCanceled) {
                req.getSession().setAttribute("mess", "Đã hủy đơn hàng thành công!");
            } else {
                req.getSession().setAttribute("error", "Không thể hủy đơn hàng này!");
            }

            // Đá về trang danh sách đơn hàng
            resp.sendRedirect(req.getContextPath() + "/my-orders");

        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/my-orders");
        }
    }
}