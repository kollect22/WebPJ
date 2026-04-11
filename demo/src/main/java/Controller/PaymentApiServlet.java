package Controller; // Bạn nhớ đặt đúng tên package của bạn nha

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/payment-api")
public class PaymentApiServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Thiết lập kiểu trả về là JSON và hỗ trợ tiếng Việt
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String amount = request.getParameter("amount");
        String method = request.getParameter("method");
        String orderCode = "ORD" + System.currentTimeMillis();

        String checkoutUrl = "";

        try {
            if ("BANK".equals(method)) {
                // Tạo nhanh Link QR để bạn demo cho thầy cô xem trước
                checkoutUrl = "https://img.vietqr.io/image/VIETINBANK-113366668888-compact.jpg?amount="
                        + amount + "&addInfo=Thanh toan " + orderCode;
            } else if ("MOMO".equals(method)) {
                // Link giả lập cho MoMo
                checkoutUrl = "https://momo.vn/payment/fake-link";
            }

            // Trả về chuỗi JSON chuẩn (Lưu ý dấu ngoặc kép)
            out.print("{\"status\": \"success\", \"checkoutUrl\": \"" + checkoutUrl + "\", \"orderCode\": \"" + orderCode + "\"}");

        } catch (Exception e) {
            out.print("{\"status\": \"error\", \"message\": \"Kết nối API thất bại\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
}