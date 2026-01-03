package dao;

import model.User;

public class AuthDao extends BaseDao {
    public User getUserByUsername(String username) {
        return get().withHandle(h -> h.createQuery("select * from users where username = :u and active = 1").bind("u",username).mapToBean(User.class).first() );
    }
}
