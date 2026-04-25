package Controller;

import cart.Cart;
import cart.CartItem;
import dao.OrderDao;
import model.Order;
import model.User;
import services.PaymentService;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
    private final PaymentService paymentService = new PaymentService();
    private final OrderDao orderDao = new OrderDao(); // Thêm Dao để lưu

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy chuỗi IDs từ URL (ví dụ: "1,3,5")
        String idsParam = request.getParameter("ids");
        Cart cart = (Cart) request.getSession().getAttribute("cart");

        // 2. Nếu giỏ hàng trống hoặc không có ID nào được truyền sang
        if (cart == null || idsParam == null || idsParam.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        String[] selectedIds = idsParam.split(",");
        List<CartItem> selectedItems = new ArrayList<>();
        long subtotal = 0;

        // 3. Lọc danh sách sản phẩm dựa trên ID đã chọn
        for (CartItem item : cart.getList()) {
            for (String id : selectedIds) {
                if (String.valueOf(item.getProduct().getId()).equals(id)) {
                    selectedItems.add(item);
                    // Cộng dồn tiền: Đơn giá * Số lượng
                    subtotal += (item.getProduct().getPrice() * item.getQuantity());
                    break;
                }
            }
        }

        request.setAttribute("selectedIds", idsParam);
        request.setAttribute("selectedItems", selectedItems);
        request.setAttribute("selectedSubtotal", subtotal);

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User auth = (User) request.getSession().getAttribute("auth");
            if (auth == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String orderIdCode = "ORD" + (long) (Math.random() * 1000000000L);
            long amount = Long.parseLong(request.getParameter("totalPrice"));

            Order order = new Order();
            order.setOrderIdCode(orderIdCode);
            order.setUserId(auth.getId());
            order.setFullName(auth.getFullName());
            order.setPhone(auth.getPhone());
            order.setAddress(auth.getSpecificAddress());
            order.setTotalPrice(amount);
            order.setPaymentMethod("Banking");
            order.setStatus(0);

            orderDao.insertOrder(order, new ArrayList<>());

            // 4. Gọi API thanh toán
            String jsonRaw = paymentService.createPaymentUrl(amount, orderIdCode);
            JsonObject jsonObject = JsonParser.parseString(jsonRaw).getAsJsonObject();

            if (jsonObject.get("error").getAsInt() == 0) {
                String checkoutUrl = jsonObject.get("data").getAsJsonObject().get("checkoutUrl").getAsString();
                response.sendRedirect(checkoutUrl);
            } else {
                response.getWriter().println("Loi API: " + jsonRaw);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("He thong gap loi: " + e.getMessage());
        }
    }
}