package Controller;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseToken;
import services.AuthService;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.FileInputStream;
import java.io.IOException;

@WebServlet(name = "LoginPhoneController", value = "/login-phone")
public class LoginPhoneController extends HttpServlet {

    @Override
    public void init() throws ServletException {
        try {
            FileInputStream serviceAccount =
                    new FileInputStream(getServletContext().getRealPath("/WEB-INF/classes/firebase-key.json"));

            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idToken = req.getParameter("token");
        AuthService authService = new AuthService();

        try {
            FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(idToken);

            String phone = decodedToken.getUid();

            User user = authService.checkLoginByPhone(phone);

            if (user == null) {
                authService.register(phone, "123456", "Người dùng mới", "http://...");
                user = authService.checkLoginByPhone(phone);
            }

            HttpSession session = req.getSession();
            session.setAttribute("auth", user);
            resp.sendRedirect("home");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(401, "Xác thực thất bại!");
        }
    }
}