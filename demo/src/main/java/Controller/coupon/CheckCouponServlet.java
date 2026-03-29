package Controller.coupon;

import dao.CouponDao;
import model.Coupon;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "CheckCouponServlet", value = "/check-coupon")
public class CheckCouponServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        CouponDao dao = new CouponDao();
        Coupon cp = dao.findByCode(code);

        resp.setContentType("application/json");
        if (cp != null) {
            resp.getWriter().write("{\"status\":\"success\", \"discountPercent\":" + cp.getDiscountPercent() + ", \"minOrderValue\":" + cp.getMinOrderValue() + "}");
        } else {
            resp.getWriter().write("{\"status\":\"error\", \"message\":\"Mã không tồn tại hoặc đã hết hạn\"}");
        }
    }
}