package dao;

import model.Order;
import model.OrderDetail;
import org.jdbi.v3.core.Handle;
import java.util.List;

public class OrderDao extends BaseDao {

    public int insertOrder(Order order, List<OrderDetail> details) {
        return get().withHandle(handle -> {
            // Sử dụng Transaction để đảm bảo an toàn dữ liệu
            return handle.inTransaction(h -> {
                // 1. Lưu vào bảng orders
                int newOrderId = h.createUpdate("INSERT INTO orders (order_id_code, user_id, full_name, phone, address, total_price, payment_method, status) " +
                                "VALUES (:orderIdCode, :userId, :fullName, :phone, :address, :totalPrice, :paymentMethod, :status)")
                        .bindBean(order)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class)
                        .one();


                for (OrderDetail detail : details) {
                    h.createUpdate("INSERT INTO order_details (order_id, product_id, quantity, price) " +
                                    "VALUES (:orderId, :productId, :quantity, :price)")
                            .bind("orderId", newOrderId) // ID lấy từ kết quả insert bảng orders
                            .bind("productId", detail.getProductId())
                            .bind("quantity", detail.getQuantity())
                            .bind("price", detail.getPrice())
                            .execute();
                }
                return newOrderId;
            });
        });
    }
}