package services;

import dao.AuthDao;
import model.User;

public class AuthService {
    AuthDao authDao = new AuthDao();

    public User checkLogin(String username, String password){
        User u = authDao.getUserByUsername(username);
        if(u == null) return null;
        if(u.getPassword().equals(password) && u.isActive()){
            u.setPassword("");
            return u;
        }
        return null;
    }
}
