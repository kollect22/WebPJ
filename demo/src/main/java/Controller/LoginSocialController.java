package Controller;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseToken;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import services.AuthService;

import java.io.FileInputStream;
import java.io.IOException;

@WebServlet(name = "LoginSocialController", value = "/login-social")
public class LoginSocialController extends HttpServlet {

    @Override
    public void init() throws ServletException {
        try {
            if (FirebaseApp.getApps().isEmpty()) {
                String path = getServletContext().getRealPath("/WEB-INF/classes/firebase-key.json");
                FileInputStream serviceAccount = new FileInputStream(path);

                FirebaseOptions options = new FirebaseOptions.Builder()
                        .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                        .build();

                FirebaseApp.initializeApp(options);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idToken = req.getParameter("token");

        if (idToken == null || idToken.isEmpty()) {
            req.setAttribute("error", "Lỗi: Không nhận được Token từ Google");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        AuthService authService = new AuthService();
        try {
            FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(idToken);

            String email = decodedToken.getEmail();
            if (email == null) email = decodedToken.getUid();

            String name = decodedToken.getName();
            String picture = decodedToken.getPicture();

            User user = authService.checkLoginByUsername(email);
            if (user == null) {
                authService.registerForSocial(email, name, picture);
                user = authService.checkLoginByUsername(email);
            }

            HttpSession session = req.getSession();
            session.setAttribute("auth", user);
            resp.sendRedirect(req.getContextPath() + "/home");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi xác thực Token: " + e.getMessage());
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}