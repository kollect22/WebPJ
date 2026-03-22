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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idToken = req.getParameter("idToken");
        AuthService authService = new AuthService();

        try {
            FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(idToken);

            String phoneRaw = (String) decodedToken.getClaims().get("phone_number");
            String phone = phoneRaw;
            if (phoneRaw != null && phoneRaw.startsWith("+84")) {
                phone = "0" + phoneRaw.substring(3);
            }
            User user = authService.checkLoginByUsername(phone);

            if (user == null) {
                authService.registerForSocial(phone, "Người dùng " + phone, null);
                user = authService.checkLoginByUsername(phone);
            }

            HttpSession session = req.getSession();
            session.setAttribute("auth", user);
            resp.sendRedirect(req.getContextPath() + "/home");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi xác thực SĐT: " + e.getMessage());
            req.getRequestDispatcher("verify-phone.jsp").forward(req, resp);
        }
    }
}