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
        //return new ArrayList<Product>(data.values());
        return get().withHandle(h -> {
            List<Product> list = h.createQuery("select * from products").mapToBean(Product.class).list();

            for(Product p : list){
                p.setColors(getColorsByProductId(p.getId()));
            } return list;
        });
    }
    public Product getProduct(int id) {
        return get().withHandle(h ->
                h.createQuery("SELECT * FROM products WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public void insert(List<Product> list) {
        get().useHandle(h -> {
//            PreparedBatch pb = h.prepareBatch("insert into products values (:id, :name, :img, :price)");
//            PreparedBatch pb = h.prepareBatch("INSERT INTO products (name, img, price, sale_price, description, category) VALUES (:name, :img, :price, :salePrice, :description, :category)");
//            list.forEach(l ->{
//                pb.bindBean(l).add();
//            });
//            pb.execute();
            for (Product p : list) {
                int productId = h.createUpdate("INSERT INTO products(name, img, price, sale_price, description, category) VALUES (:name, :img, :price, :salePrice, :description, :category)")
                        .bindBean(p)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class)
                        .one();

                if (p.getColors() != null) {
                    for (String color : p.getColors()) {
                        h.createUpdate("INSERT INTO product_colors(product_id, color_code) VALUES (:pid, :colorCode)")
                                .bind("pid", productId)
                                .bind("colorCode", color)
                                .execute();
                    }
                }
            }
        });
    }

    public List<String> getColorsByProductId(int id){
        return get().withHandle(h->
                h.createQuery("SELECT color_code FROM product_colors WHERE product_id = :id")
                        .bind("id", id)
                        .mapTo(String.class)
                        .list()
        );
    }


//    public static void main(String[] args) {
//        ProductDao pd = new ProductDao();
//        pd.insert(pd.getListProduct());
//    }

}
