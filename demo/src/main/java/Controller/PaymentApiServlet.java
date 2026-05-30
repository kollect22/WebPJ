package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.ProductDao;
import model.Product;
import services.PaymentService; // Nhớ import service của mình vào

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/payment-api")
public class PaymentApiServlet extends HttpServlet {

    // Khởi tạo service
    private final PaymentService paymentService = new PaymentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String amountStr = request.getParameter("amount");
        String method = request.getParameter("method");

        // Tạo orderId để lưu vào Database/Session (Ví dụ: ORD171654321)
        String orderId = "ORD" + System.currentTimeMillis();

        try {
            HttpSession session = request.getSession();

            // Xử lý logic sản phẩm gợi ý như cũ của bạn
            ProductDao pDao = new ProductDao();
            List<Product> recommendedList = pDao.getRecommendedProducts(3);
            session.setAttribute("recommendedList", recommendedList);
            session.setAttribute("orderId", orderId);

            String checkoutUrl = "";

            if ("BANK".equals(method)) {
                // --- ĐOẠN THAY ĐỔI QUAN TRỌNG ---
                try {
                    long amount = Long.parseLong(amountStr);
                    // Gọi sang PaymentService để lấy link PayOS xịn
                    checkoutUrl = paymentService.createPaymentUrl(amount, orderId);
                } catch (Exception e) {
                    throw new Exception("Lỗi gọi PayOS: " + e.getMessage());
                }
                // -------------------------------
            } else if ("MOMO".equals(method)) {
                // Nếu bạn chưa làm Momo thì tạm thời để link fake hoặc báo lỗi
                checkoutUrl = "https://momo.vn/payment/fake-link";
            } else {
                checkoutUrl = "http://localhost:8080/demo_war/checkout.jsp"; // Quay về nếu không chọn method
            }

            // Trả về JSON cho phía Client (File JavaScript của bạn sẽ nhận cái này)
            out.print("{\"status\": \"success\", \"checkoutUrl\": \"" + checkoutUrl + "\", \"orderCode\": \"" + orderId + "\"}");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\": \"error\", \"message\": \"Lỗi: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
}