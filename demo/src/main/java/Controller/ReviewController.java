package Controller;

import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "ReviewController", value = "/submit-review")
public class ReviewController extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        model.User currentUser = (model.User) session.getAttribute("auth");

        if(currentUser == null){
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try{
            int productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            ProductDao dao = new ProductDao();
            dao.insertReview(productId, currentUser.getId(), rating, comment);
            response.sendRedirect(request.getContextPath()+ "/product-detail?id=" + productId);

        }catch(Exception e){
            e.printStackTrace();
            response.getWriter().println("<h3>Lỗi lưu đánh giá: " + e.getMessage() + "</h3>");        }

    }
}
