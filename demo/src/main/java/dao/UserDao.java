package dao;

import model.User;
import util.MD5;

import java.util.List;

public class UserDao extends BaseDao {

    public List<User> getAllUsers() {
        return get().withHandle(h -> {
            String sql = "SELECT * FROM users ORDER BY id DESC";

            return h.createQuery(sql)
                    .mapToBean(User.class)
                    .list();
        });
    }

    public boolean changePassword(int userId, String oldPasswordRaw, String newPasswordRaw) {
        String oldPassHash = MD5.getMd5(oldPasswordRaw);
        String newPassHash = MD5.getMd5(newPasswordRaw);

        return get().withHandle(h -> {
            String sql = "UPDATE users SET password = :newPass WHERE id = :id AND password = :oldPass";

            int rowsAffected = h.createUpdate(sql)
                    .bind("newPass", newPassHash)
                    .bind("id", userId)
                    .bind("oldPass", oldPassHash)
                    .execute();

            return rowsAffected > 0;
        });
    }
}