package Controller;

import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

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

            String cidParam = request.getParameter("cid");
            String searchParam = request.getParameter("search");
            String pageParam = request.getParameter("page");

            int pageSize = 8;
            int page = 1;
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            int offset = (page - 1) * pageSize;
            int totalPages = 0;

            String title = "Tất cả sản phẩm";

            if (cidParam != null && !cidParam.isEmpty()) {
                int cid = Integer.parseInt(cidParam);
                list = dao.getProductsByCategory(cid);
                title = dao.getCategoryName(cid);
                request.setAttribute("activeCid", cid);

                totalPages = 0;

            } else {
                if (searchParam != null && !searchParam.isEmpty()) {
                    title = "Kết quả tìm kiếm: " + searchParam;
                }

                int totalProducts = dao.getTotalProducts(searchParam);
                totalPages = (int) Math.ceil((double) totalProducts / pageSize);
                list = dao.getProductsWithPagination(searchParam, offset, pageSize);
            }

            request.setAttribute("list", list);
            request.setAttribute("pageTitle", title);

            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", searchParam);

            request.getRequestDispatcher("/list-product.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>LỖI JAVA/SQL: " + e.getMessage() + "</h3>");
            response.getWriter().println("<pre>");
            e.printStackTrace(response.getWriter());
            response.getWriter().println("</pre>");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}