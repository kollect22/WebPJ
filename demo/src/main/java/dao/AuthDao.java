package dao;

import model.User;

import java.time.LocalDateTime;

public class AuthDao extends BaseDao {
    public User getUserByUsername(String username) {
        return get().withHandle(h ->
                h.createQuery("select * from users where username = :u")
                        .bind("u",username)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null));
    }
    public boolean checkExist(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = :u";
        return get().withHandle(h ->
                h.createQuery(sql).bind("u", username).mapTo(Integer.class).one()
        ) > 0;
    }

    public int registerUserReturnId(String username, String passwordHash, String fullName) {
        String sql = "INSERT INTO users(username, password, full_name, active) VALUES (:u, :p, :fn, 0)";
        return get().withHandle(h ->
                h.createUpdate(sql)
                        .bind("u", username).bind("p", passwordHash).bind("fn", fullName)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class).one()
        );
    }

    public void saveToken(int userId, String token, LocalDateTime expiry) {
        get().useHandle(h -> h.createUpdate("INSERT INTO tokens(user_id, token, expiry_time) VALUES (:uid, :tk, :exp)")
                .bind("uid", userId).bind("tk", token).bind("exp", expiry)
                .execute());
    }

    public int getUserIdByToken(String token) {
        String sql = "SELECT user_id FROM tokens WHERE token = :tk AND expiry_time > NOW()";
        return get().withHandle(h ->
                h.createQuery(sql).bind("tk", token).mapTo(Integer.class).findOne().orElse(-1)
        );
    }

    public void activeUser(int userId) {
        get().useHandle(h -> h.createUpdate("UPDATE users SET active = 1 WHERE id = :id")
                .bind("id", userId).execute());
    }

    public void deleteToken(String token) {
        get().useHandle(h -> h.createUpdate("DELETE FROM tokens WHERE token = :tk")
                .bind("tk", token).execute());
    }

}
