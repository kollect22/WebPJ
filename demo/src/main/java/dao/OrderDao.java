package dao;

import model.Order;
import model.OrderDetail;
import org.jdbi.v3.core.Handle;
import java.util.List;
import java.util.Map;

public class OrderDao extends BaseDao {

    public int insertOrder(Order order, List<OrderDetail> details) {
        return get().withHandle(handle -> {
            return handle.inTransaction(h -> {
                int newOrderId = h.createUpdate("INSERT INTO orders (order_id_code, user_id, full_name, phone, address, total_price, payment_method, status) " +
                                "VALUES (:orderIdCode, :userId, :fullName, :phone, :address, :totalPrice, :paymentMethod, :status)")
                        .bindBean(order)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class)
                        .one();

                var batch = h.prepareBatch("INSERT INTO order_details (order_id, product_id, quantity, price) " +
                        "VALUES (:orderId, :productId, :quantity, :price)");
                for (OrderDetail detail : details) {
                    batch.bind("orderId", newOrderId)
                            .bind("productId", detail.getProductId())
                            .bind("quantity", detail.getQuantity())
                            .bind("price", detail.getPrice())
                            .add();
                }
                batch.execute();

                return newOrderId;
            });
        });
    }

    public List<Order> getOrdersByUserId(int userId) {
        return get().withHandle(h -> {
            String sql = "SELECT id, order_id_code AS orderIdCode, user_id AS userId, " +
                    "full_name AS fullName, phone, address, total_price AS totalPrice, " +
                    "payment_method AS paymentMethod, status, " +
                    "created_at AS createdAt " +
                    "FROM orders WHERE user_id = :userId ORDER BY id DESC";

            return h.createQuery(sql)
                    .bind("userId", userId)
                    .mapToBean(Order.class)
                    .list();
        });
    }

    public List<Order> getAllOrders() {
        return get().withHandle(h -> {
            String sql = "SELECT id, order_id_code AS orderIdCode, user_id AS userId, " +
                    "full_name AS fullName, phone, address, total_price AS totalPrice, " +
                    "payment_method AS paymentMethod, status " +
                    "FROM orders ORDER BY id DESC";

            return h.createQuery(sql)
                    .mapToBean(Order.class)
                    .list();
        });
    }

    public List<Map<String, Object>> getOrderDetailWithProduct(int orderId) {
        return get().withHandle(h -> {
            String sql = "SELECT od.*, p.name AS productName, p.image AS productImage " +
                    "FROM order_details od " +
                    "JOIN products p ON od.product_id = p.id " +
                    "WHERE od.order_id = :orderId";

            return h.createQuery(sql)
                    .bind("orderId", orderId)
                    .mapToMap()
                    .list();
        });
    }

    public void updateStatus(int orderId, int status) {
        get().useHandle(h -> {
            h.createUpdate("UPDATE orders SET status = :status WHERE id = :id")
                    .bind("status", status)
                    .bind("id", orderId)
                    .execute();
        });
    }

    public Order getOrderByCode(String orderIdCode) {
        return get().withHandle(h -> {
            return h.createQuery("SELECT * FROM orders WHERE order_id_code = :code")
                    .bind("code", orderIdCode)
                    .mapToBean(Order.class)
                    .findFirst()
                    .orElse(null);
        });
    }

    public List<OrderDetail> getOrderDetails(int orderId) {
        return get().withHandle(h -> {
            String sql = "SELECT od.*, p.name AS productName " +
                    "FROM order_details od " +
                    "JOIN products p ON od.id = p.id " +
                    "WHERE od.id = :id";

            return h.createQuery(sql)
                    .bind("id", orderId)
                    .mapToBean(OrderDetail.class)
                    .list();
        });
    }
    public boolean cancelOrder(int orderId, String reason) {
        return get().withHandle(h -> {
            return h.createUpdate("UPDATE orders SET status = 2, cancel_reason = :reason WHERE id = :orderId AND status = 0")
                    .bind("reason", reason)
                    .bind("orderId", orderId)
                    .execute() > 0;
        });
    }
}