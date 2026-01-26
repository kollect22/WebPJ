package Controller;

import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import services.ProductService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name = "ListProduct", value = "/list-product")
public class ListProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            ProductDao dao = new ProductDao();
            List<Product> list = new ArrayList<>();

            // 2. Lấy tham số từ URL
            // Ví dụ: /products?cid=2 (Lấy danh mục 2)
            // Ví dụ: /products (Lấy tất cả)
            String cidParam = request.getParameter("cid");
            String searchParam = request.getParameter("search");

            String title = "Tất cả sản phẩm";

            if (cidParam != null && !cidParam.isEmpty()) {
                int cid = Integer.parseInt(cidParam);
                list = dao.getProductsByCategory(cid);

                title = dao.getCategoryName(cid);

                request.setAttribute("activeCid", cid); // tô màu menu active của JSP

            } else if (searchParam != null && !searchParam.isEmpty()) {
                // TÌM KIẾM ---
                // list = dao.searchByName(searchParam);
                title = "Kết quả tìm kiếm: " + searchParam;

            } else {
                // --- TRƯỜNG HỢP: MẶC ĐỊNH (LẤY TẤT CẢ) ---
                list = dao.getListProduct();
            }

            // 4. Gửi dữ liệu sang JSP
            request.setAttribute("list", list);
            request.setAttribute("pageTitle", title);

            // 5. Điều hướng về 1 file JSP duy nhất
            request.getRequestDispatcher("/list-product.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>LỖI JAVA/SQL: " + e.getMessage() + "</h3>");
            response.getWriter().println("<pre>");
            e.printStackTrace(response.getWriter());
            response.getWriter().println("</pre>");
        }
//        ProductService ps = new ProductService();
//        List<Product> list = ps.getListProduct();
//        request.setAttribute("list", list);
//        request.getRequestDispatcher("list-product.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

