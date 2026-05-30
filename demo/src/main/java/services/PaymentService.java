package services;

import vn.payos.PayOS;
import vn.payos.type.PaymentData;
import vn.payos.type.CheckoutResponseData;

public class PaymentService {
    private final String CLIENT_ID = "af9c7a07-c5bb-40ca-8db9-3cf4f4c5a769";
    private final String API_KEY = "6ce486ae-3b72-4edc-998c-61a43c14c32d";
    private final String CHECKSUM_KEY = "543d262c2c15dee67f2bf96dce4e52adb7bdd96ed227b137c7cc73d6b58ff703";

    private final PayOS payOS = new PayOS(CLIENT_ID, API_KEY, CHECKSUM_KEY);

    public String createPaymentUrl(long amount, String orderId) throws Exception {
      
        System.setProperty("com.fasterxml.jackson.deserialization.fail_on_unknown_properties", "false");
        try {
           
            long orderCode = System.currentTimeMillis() / 1000;

            String shortDescription = "DH" + (orderCode % 100000);

            PaymentData paymentData = PaymentData.builder()
                    .orderCode(orderCode)
                    .amount(2000)
                    .description(shortDescription)
                    .returnUrl("http://localhost:8080/demo/thankyou.jsp")
                    .cancelUrl("http://localhost:8080/demo/checkout.jsp")
                    .build();

          
            CheckoutResponseData data = payOS.createPaymentLink(paymentData);

            return data.getCheckoutUrl();

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Lỗi tạo link thanh toán: " + e.getMessage());
        }
    }
}