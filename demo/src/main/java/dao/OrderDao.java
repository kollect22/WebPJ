package dao;

import model.Order;
import model.OrderDetail;
import org.jdbi.v3.core.Handle;
import java.util.List;

public class OrderDao extends BaseDao {

    public int insertOrder(Order order, List<OrderDetail> details) {
        return get().withHandle(handle -> {
            return handle.inTransaction(h -> {
                int newOrderId = h.createUpdate("INSERT INTO orders (order_id_code, user_id, full_name, phone, address, total_price, payment_method, status) " +
                                "VALUES (:code, :uid, :name, :phone, :addr, :price, :method, :status)")
                        .bind("code", order.getOrderIdCode())
                        .bind("uid", order.getUserId())
                        .bind("name", order.getFullName())
                        .bind("phone", order.getPhone())
                        .bind("addr", order.getAddress())
                        .bind("price", order.getTotalPrice())
                        .bind("method", order.getPaymentMethod())
                        .bind("status", order.getStatus())
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
    public List<Order> getAllOrders() {
        return get().withHandle(h -> {

            String sql = "SELECT * FROM orders ORDER BY id DESC";

            return h.createQuery(sql)
                    .mapToBean(Order.class)
                    .list();
        });
    }

    public List<Order> getOrdersByUserId(int userId) {
        return get().withHandle(h -> {
            String sql = "SELECT id, order_id_code as orderIdCode, user_id as userId, " +
                    "full_name as fullName, phone, address, total_price as totalPrice, " +
                    "payment_method as paymentMethod, status " +
                    "FROM orders WHERE user_id = :userId ORDER BY id DESC";

            return h.createQuery(sql)
                    .bind("userId", userId)
                    .mapToBean(Order.class)
                    .list();
        });
    }


}