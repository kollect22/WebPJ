package Controller.coupon;

import dao.CouponDao;
import model.Coupon;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "CouponAddController", value = "/admin/coupon-add")
public class CouponAddController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            String code = req.getParameter("code");
            int discountPercent = Integer.parseInt(req.getParameter("discountPercent"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            Coupon c = new Coupon();
            c.setCode(code.toUpperCase());
            c.setDiscountPercent(discountPercent);
            c.setQuantity(quantity);
            c.setMinOrderValue(0);
            c.setStatus(1);

            CouponDao dao = new CouponDao();
            dao.insert(c);

            resp.sendRedirect(req.getContextPath() + "/admin/coupons?success=true");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/coupons?error=true");
        }
    }
}