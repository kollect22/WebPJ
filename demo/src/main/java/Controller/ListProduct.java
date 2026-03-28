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
//            List<Product> list = new ArrayList<>();

            String cidParam = request.getParameter("cid");
            String searchParam = request.getParameter("search");
            String pageParam = request.getParameter("page");

            int pageSize = 20;
            int page = 1;
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            int offset = (page - 1) * pageSize;
//            int totalPages = 0;

            int totalProducts = dao.getTotalProducts(searchParam, cidParam);
            int totalPages = (int) Math.ceil((double) totalProducts/pageSize);
            List<Product> list = dao.getProductsWithPagination(searchParam, cidParam, offset, pageSize);

            String title = "Tất cả sản phẩm";

            if(searchParam!= null && !searchParam.isEmpty()){
                title = "Kết quả tìm kiếm: '" + searchParam +"'";
            }else if(cidParam!=null && !cidParam.isEmpty()){
                int cid = Integer.parseInt((cidParam));
                title= dao .getCategoryName(cid);
                request.setAttribute("activeCid", cid);
            }

            request.setAttribute("list", list);
            request.setAttribute("totalProducts", totalProducts);

            request.setAttribute("pageTitle", title);

            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", searchParam);
            request.setAttribute("cid", cidParam);

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