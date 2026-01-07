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
        data.put(1, new Product(1, "", "", 10000));
    }

    public List<Product> getListProduct() {
        //return new ArrayList<Product>(data.values());
        return get().withHandle(h -> {
            return h.createQuery("select * from products").mapToBean(Product.class).list();
        });
    }
    public Product getProduct(int id) {
        // data.get(id);
        return get().withHandle(h -> {
            return h.createQuery("select * from products where id = :id").bind("id",id).mapToBean(Product.class).first();
        });
    }
    public void insert(List<Product> list) {
        get().useHandle(h -> {
            PreparedBatch pb = h.prepareBatch("insert into products values (:id, :name, :img, :price)");
            list.forEach(l ->{
                pb.bindBean(l).add();
            });
            pb.execute();
        });
    }

//    public static void main(String[] args) {
//        ProductDao pd = new ProductDao();
//        pd.insert(pd.getListProduct());
//    }
}
