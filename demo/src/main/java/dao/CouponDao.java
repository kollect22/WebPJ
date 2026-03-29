package dao;

import model.Coupon;

import java.util.List;

public class CouponDao extends BaseDao {
    public List<Coupon> getAllCoupons(String search) {
        return get().withHandle(h -> {
            String sql = "SELECT * FROM coupons WHERE code LIKE :search ORDER BY id DESC";
            String keyword = (search == null) ? "" : search;

            return h.createQuery(sql)
                    .bind("search", "%" + keyword + "%")
                    .mapToBean(Coupon.class)
                    .list();
        });
    }
    public void insert(Coupon c) {
        get().useHandle(h -> {
            h.createUpdate("INSERT INTO coupons (code, discount_percent, min_order_value, quantity, status) " +
                            "VALUES (:code, :discountPercent, :minOrderValue, :quantity, :status)")
                    .bindBean(c)
                    .execute();
        });
    }
    public void delete(int id) {
        get().useHandle(h -> {
            h.createUpdate("DELETE FROM coupons WHERE id = :id")
                    .bind("id", id)
                    .execute();
        });
    }
    public Coupon findByCode(String code) {
        return get().withHandle(h -> {
            String sql = "SELECT * FROM coupons WHERE code = :code AND quantity > 0 AND status = 1";

            return h.createQuery(sql)
                    .bind("code", code)
                    .mapToBean(Coupon.class)
                    .findOne()
                    .orElse(null);
        });
    }
}
