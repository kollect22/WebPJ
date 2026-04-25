package Controller;

import dao.OrderDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Order;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderHistoryController", value = "/my-orders")
public class OrderHistoryController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User auth = (User) request.getSession().getAttribute("auth");
        if (auth == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        OrderDao dao = new OrderDao();
        List<Order> orders = dao.getOrdersByUserId(auth.getId());

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/user/orders.jsp").forward(request, response);

    }
}