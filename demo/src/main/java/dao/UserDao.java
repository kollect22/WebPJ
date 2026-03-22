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
}