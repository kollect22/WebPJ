package services;

import com.google.gson.Gson;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.HashMap;
import java.util.Map;

public class PaymentService {
    // Lưu ý: Bạn cần thay bằng Key thật từ trang chủ PayOS.vn
    private final String CLIENT_ID = "YOUR_CLIENT_ID";
    private final String API_KEY = "YOUR_API_KEY";

    public String createPaymentUrl(long amount, String orderId) throws Exception {
        Map<String, Object> body = new HashMap<>();
        // Lưu ý: orderCode của PayOS phải là kiểu số (int/long)
        body.put("orderCode", Long.parseLong(orderId));
        body.put("amount", amount);
        body.put("description", "Thanh toan don hang" + orderId);

        // Quan trọng: Thêm /demo_war vào URL để đúng với cấu trúc server của bạn
        body.put("returnUrl", "http://localhost:8080/demo_war/success.jsp");
        body.put("cancelUrl", "http://localhost:8080/demo_war/cancel.jsp");

        String jsonBody = new Gson().toJson(body);

        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://api-payos.vn/v2/payment-requests"))
                .header("Content-Type", "application/json")
                .header("x-client-id", CLIENT_ID)
                .header("x-api-key", API_KEY)
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        return response.body();
    }
}