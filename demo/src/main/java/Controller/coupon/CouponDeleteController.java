package Controller.coupon;

import dao.CouponDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "CouponDeleteController", value = "/admin/coupon-delete")
public class CouponDeleteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");

            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);

                CouponDao dao = new CouponDao();
                dao.delete(id);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/coupons?delete=success");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/coupons?delete=error");
        }
    }
}