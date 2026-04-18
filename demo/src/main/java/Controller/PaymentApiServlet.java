package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ProductDao;
import model.Product;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/payment-api")
public class PaymentApiServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String amount = request.getParameter("amount");
        String method = request.getParameter("method");
        String orderCode = "ORD" + System.currentTimeMillis();

        String checkoutUrl = "";

        try {
            HttpSession session = request.getSession();

            ProductDao pDao = new ProductDao();
            List<Product> recommendedList = pDao.getRecommendedProducts(3);

            session.setAttribute("recommendedList", recommendedList);
            session.setAttribute("orderId", orderCode);

            if ("BANK".equals(method)) {
                checkoutUrl = "https://img.vietqr.io/image/VIETINBANK-113366668888-compact.jpg?amount="
                        + amount + "&addInfo=Thanh toan " + orderCode;
            } else if ("MOMO".equals(method)) {
                checkoutUrl = "https://momo.vn/payment/fake-link";
            }

            out.print("{\"status\": \"success\", \"checkoutUrl\": \"" + checkoutUrl + "\", \"orderCode\": \"" + orderCode + "\"}");

        } catch (Exception e) {
            out.print("{\"status\": \"error\", \"message\": \"Kết nối API thất bại\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
}