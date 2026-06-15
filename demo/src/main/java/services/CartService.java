package services;

import cart.Cart;
import cart.CartItem;
import model.Product;
import dao.BaseDao;
import java.util.List;
import java.util.Map;

public class CartService extends BaseDao {


    public void saveCartToDatabase(int userId, Cart cart) {
        System.out.println("DEBUG: Bắt đầu lưu giỏ hàng cho UserID: " + userId);

        if (cart == null || cart.getList().isEmpty()) {
            System.out.println("DEBUG: Giỏ hàng trống, bỏ qua không lưu!");
            return;
        }

        get().useTransaction(handle -> {
            // In ra số lượng món cần xóa và thêm
            int deleted = handle.execute("DELETE FROM cart_items WHERE user_id = ?", userId);
            System.out.println("DEBUG: Đã xóa " + deleted + " dòng cũ của user.");

            var batch = handle.prepareBatch("INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?)");
            for (CartItem item : cart.getList()) {
                System.out.println("DEBUG: Đang chuẩn bị insert sản phẩm ID: " + item.getProduct().getId() + " - SL: " + item.getQuantity());
                batch.bind(0, userId)
                        .bind(1, item.getProduct().getId())
                        .bind(2, item.getQuantity())
                        .add();
            }
            int[] result = batch.execute();
            System.out.println("DEBUG: Đã insert xong " + result.length + " sản phẩm vào DB.");
        });
    }

    public Cart getCartByUserId(int userId) {
        return get().withHandle(handle -> {
            Cart cart = new Cart();
            List<Map<String, Object>> results = handle.createQuery(
                            "SELECT p.*, ci.quantity FROM cart_items ci " +
                                    "JOIN products p ON ci.product_id = p.id WHERE ci.user_id = :userId")
                    .bind("userId", userId)
                    .mapToMap()
                    .list();

            for (Map<String, Object> row : results) {
                Product p = new Product((int) row.get("id"), (String) row.get("name"),
                        (String) row.get("img"), (int) row.get("price"));
                cart.addProduct(p, (int) row.get("quantity"));
            }
            return cart.getList().isEmpty() ? null : cart;
        });
    }
}