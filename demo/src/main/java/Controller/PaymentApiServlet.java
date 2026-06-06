package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import cart.Cart;
import cart.CartItem;
import dao.OrderDao;
import dao.ProductDao;
import model.Order;
import model.OrderDetail;
import model.User;
import services.PaymentService;

@WebServlet("/payment-api")
public class PaymentApiServlet extends HttpServlet {

    private final PaymentService paymentService = new PaymentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession();
            User auth = (User) session.getAttribute("auth");
            Cart cart = (Cart) session.getAttribute("cart");

            if (auth == null) {
                out.print("{\"status\": \"error\", \"message\": \"Vui lòng đăng nhập!\"}");
                return;
            }

            if (cart == null || cart.getList().isEmpty()) {
                out.print("{\"status\": \"error\", \"message\": \"Giỏ hàng trống!\"}");
                return;
            }

            String amountStr = request.getParameter("amount");
            String method = request.getParameter("method");
            String purchasedIds = request.getParameter("purchasedIds");

            String[] idsArray = (purchasedIds != null && !purchasedIds.isEmpty()) ? purchasedIds.split(",") : new String[0];


            String orderIdCode = "ORD" + System.currentTimeMillis();
            long payosOrderCode = System.currentTimeMillis() / 1000;

            Order order = new Order();
            order.setOrderIdCode(orderIdCode);
            order.setUserId(auth.getId());
            order.setFullName(auth.getFullName());
            order.setPhone(request.getParameter("phone"));
            order.setAddress(request.getParameter("address"));
            order.setTotalPrice(Double.parseDouble(amountStr));
            order.setPaymentMethod(method);
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
                        cart.deleteProduct(Integer.parseInt(idStr.trim()));
                    }
                    session.setAttribute("cart", cart);
                } else {
                    session.removeAttribute("cart");
                }


                long amount = Long.parseLong(amountStr);
                String checkoutUrl = paymentService.createPaymentUrl(amount, orderIdCode, payosOrderCode);

                out.print("{\"status\": \"success\", \"checkoutUrl\": \"" + checkoutUrl + "\"}");
            } else {
                out.print("{\"status\": \"error\", \"message\": \"Không thể lưu đơn hàng vào database!\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\": \"error\", \"message\": \"Lỗi hệ thống: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
}