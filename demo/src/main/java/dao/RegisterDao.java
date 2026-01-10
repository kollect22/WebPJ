package dao;

public class RegisterDao extends BaseDao {

    public boolean register(String username, String password) {
        String sql = """
            INSERT INTO users(username, password, active)
            VALUES (:u, :p, 1)
        """;

        return get().withHandle(h ->
                h.createUpdate(sql)
                        .bind("u", username)
                        .bind("p", password)
                        .execute()
        ) > 0;
    }

    // kiểm tra trùng username
    public boolean exists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = :u";
        return get().withHandle(h ->
                h.createQuery(sql)
                        .bind("u", username)
                        .mapTo(Integer.class)
                        .one()
        ) > 0;
    }
}
