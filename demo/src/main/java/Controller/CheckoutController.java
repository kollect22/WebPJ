package Controller;

import services.PaymentService;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/xu-ly-thanh-toan")
public class CheckoutController extends HttpServlet {
    private final PaymentService paymentService = new PaymentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Tạo mã đơn hàng ngẫu nhiên bằng số (dưới 10 chữ số để tránh lỗi long)
            String orderId = String.valueOf((long) (Math.random() * 100000000));
            long amount = 10000; // Số tiền demo 10,000 VND

            String jsonRaw = paymentService.createPaymentUrl(amount, orderId);

            // Phân tích dữ liệu JSON nhận được
            JsonObject jsonObject = JsonParser.parseString(jsonRaw).getAsJsonObject();

            // Kiểm tra nếu API trả về thành công (error = 0)
            if (jsonObject.get("error").getAsInt() == 0) {
                String checkoutUrl = jsonObject.get("data").getAsJsonObject().get("checkoutUrl").getAsString();
                // Chuyển hướng khách sang trang thanh toán của ngân hàng
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