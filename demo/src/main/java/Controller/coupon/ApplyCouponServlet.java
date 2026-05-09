package Controller.coupon;

import dao.CouponDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Coupon;
import java.io.IOException;


@WebServlet(name = "ApplyCouponServlet", value = "/apply-coupon")
public class ApplyCouponServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");

        dao.CouponDao couponDao = new dao.CouponDao();
        model.Coupon coupon = couponDao.findByCode(code);

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        if (coupon != null) {
            request.getSession().setAttribute("appliedCoupon", coupon);
            response.getWriter().write("{\"success\": true}");
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"Mã không tồn tại!\"}");
        }
    }
}