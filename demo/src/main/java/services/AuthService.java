package services;

import dao.AuthDao;
import model.User;
import util.EmailUtil;
import util.MD5;

import java.time.LocalDateTime;
import java.util.UUID;

public class AuthService {
    AuthDao authDao = new AuthDao();

    public User checkLogin(String username, String passwordRaw) {
        User u = authDao.getUserByUsername(username);
        if (u == null) return null;

        String passwordHash = MD5.getMd5(passwordRaw);

        if (passwordHash.equals(u.getPassword()) && u.isActive()) {
            u.setPassword("");
            return u;
        }
        return null;
    }

    public boolean register(String username, String passwordRaw, String fullName, String appUrl) {
        if (authDao.checkExist(username)) return false;

        String passwordHash = MD5.getMd5(passwordRaw);

        int userId = authDao.registerUserReturnId(username, passwordHash, fullName);

        if (username.contains("@")) {
            String token = UUID.randomUUID().toString();
            LocalDateTime expiry = LocalDateTime.now().plusMinutes(15);
            authDao.saveToken(userId, token, expiry);

            String link = appUrl + "/verify?token=" + token;
            new Thread(() -> {
                String content = "<h3>Chào " + fullName + "!</h3>" +
                        "<p>Bấm vào đây để kích hoạt tài khoản:</p>" +
                        "<a href='" + link + "'>KÍCH HOẠT NGAY</a>" +
                        "<p>Link chỉ dùng 1 lần và hết hạn sau 15 phút.</p>";
                EmailUtil.send(username, "Xác thực tài khoản", content);
            }).start();

        } else {
            authDao.activeUser(userId);
        }

        return true;
    }

    public boolean verify(String token) {
        int userId = authDao.getUserIdByToken(token);

        if (userId != -1) {
            authDao.activeUser(userId);
            authDao.deleteToken(token);
            return true;
        }
        return false;
    }

    public User checkLoginByUsername(String username) {
        if (username == null) return null;

        String normalizedUser = username;
        if (normalizedUser.startsWith("+84")) {
            normalizedUser = "0" + normalizedUser.substring(3);
        }

        return authDao.getUserByUsername(normalizedUser);
    }
    public void registerForSocial(String username, String fullName, String img) {
        if (username.startsWith("+84")) {
            username = "0" + username.substring(3);
        }

        if (authDao.checkExist(username)) return;

        String dummyPass = "";

        int userId = authDao.registerUserReturnId(username, dummyPass, fullName);

        authDao.activeUser(userId);
    }
}
