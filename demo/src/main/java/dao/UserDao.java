package dao;

import model.User;
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

    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        return get().withHandle(h -> {
            String sql = "UPDATE users SET password = :newPass WHERE id = :id AND password = :oldPass";

            int rowsAffected = h.createUpdate(sql)
                    .bind("newPass", newPassword)
                    .bind("id", userId)
                    .bind("oldPass", oldPassword)
                    .execute();
            
            return rowsAffected >0;
        });
    }
}