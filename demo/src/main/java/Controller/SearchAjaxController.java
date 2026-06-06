package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import model.Product;
import services.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchAjaxController", value = "/api/search")
public class SearchAjaxController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");

        ProductService productService = new ProductService();
        List<Product> resultList;

        if(keyword==null || keyword.trim().isEmpty()){
            resultList = productService.getRecommendedProducts(5);
        }else {
            resultList = productService.searchByName(keyword);
        }

        Gson gson = new Gson();
        String jsonResponse = gson.toJson(resultList);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        resp.getWriter().write(jsonResponse);
    }
}