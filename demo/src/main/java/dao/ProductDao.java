package dao;

import model.Product;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.PreparedBatch;
import org.jdbi.v3.core.statement.Update;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductDao extends BaseDao {
    static Map<Integer, Product> data = new HashMap<>();
    static {
        data.put(1, new Product(1, "Khăn lụa", "img/accessory/KhanLua.webp", 10000));
        data.put(2, new Product(2, "Túi da", "img/products/tui-da/a1.jpeg", 100020));
        data.put(3, new Product(3, "Túi da thật", "img/products/tui-da/a1.jpeg", 100004));
        data.put(4, new Product(4, "Túi đeo vai", "img/products/tui-deo-vai/anh1.jpg", 100500));
    }

    public List<Product> getListProduct() {
        return new ArrayList<Product>(data.values());
//        return get().withHandle(h -> {
//            return h.createQuery("select * from products").mapToBean(Product.class).list();
//        });
    }
    public Product getProduct(int id) {
        return data.get(id);
//        return get().withHandle(h -> {
//            return h.createQuery("select * from products where id = :id").bind("id",id).mapToBean(Product.class).first();
//        });
    }
//    public void insert(List<Product> list) {
//        get().useHandle(h -> {
//            PreparedBatch pb = h.prepareBatch("insert into products values (:id, :name, :img, :price)");
//            list.forEach(l ->{
//                pb.bindBean(l).add();
//            });
//            pb.execute();
//        });
//    }
//
//    public static void main(String[] args) {
//        ProductDao pd = new ProductDao();
//        pd.insert(pd.getListProduct());
//    }
public static void main(String[] args) {
    ProductDao dao = new ProductDao();
    List<Product> list = dao.getListProduct();

    System.out.println("------------ TEST DAO ------------");
    System.out.println("Số lượng sản phẩm: " + list.size());
    for (Product p : list) {
        System.out.println("- " + p.getName() + " (Giá: " + p.getPrice() + ")");
    }}
}
