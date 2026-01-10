package services;
import dao.ProductDao;
import model.Product;
import java.util.List;
import java.util.ArrayList;

public class ProductService {


    ProductDao dao = new ProductDao();
    public List<Product> getListProduct() {
        return dao.getListProduct();
    }

    public Product getProduct(int id) {
       return null;
    }
}