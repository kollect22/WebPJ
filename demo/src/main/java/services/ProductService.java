package services;
import dao.ProductDao;
import model.Product;
import java.util.List;
import java.util.ArrayList;

public class ProductService {

    ProductDao productDao = new ProductDao();

    public List<Product> getListProduct() {
        return productDao.getListProduct();
    }

    public Product getProduct(int id) {

        return productDao.getProduct(id);
    }

    public List<Product> searchByName(String keyword) {
        ProductDao dao = new ProductDao();
        return dao.searchByName(keyword);
    }

    public List<Product> getRecommendedProducts(int limit){
        return productDao.getRecommendedProducts(limit);
    }
}