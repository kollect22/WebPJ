package dao;

import model.ColorVariant;
import model.Product;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.PreparedBatch;
import org.jdbi.v3.core.statement.Update;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductDao extends BaseDao {
    public List<Product> getListProduct() {
        return get().withHandle(h -> {
            // 1. Lấy danh sách sản phẩm
            List<Product> list = h.createQuery("SELECT p.*, c.name AS categoryName FROM products p LEFT JOIN categories c ON p.category_id = c.id")
                    .mapToBean(Product.class)
                    .list();

            for (Product p : list) {
                if (p.getGroupId() > 0) {
                    List<ColorVariant> colors = getRelatedColors(h, p.getGroupId(), p.getId());
                    p.setColors(colors);
                }   
            }

            return list;
        });
    }
    public Product getProduct(int id) {
        return get().withHandle(h -> {
//            return h.createQuery("select * from products where id = :id").bind("id",id).mapToBean(Product.class).first();
            String sql = "SELECT p.*, c.name AS categoryName " +
                    "FROM products p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.id = :id";
            Product product = h.createQuery(sql)
                    .bind("id", id)
                    .mapToBean(Product.class)
                    .findOne().orElse(null);

            if (product != null) {
                product.setGalleryImages(getGalleryImages(h, id));

                if (product.getGroupId() > 0) {
                    product.setColors(getRelatedColors(h, product.getGroupId(), id));
                }
            }
            return product;
        });
    }

    private List<String> getGalleryImages(Handle h,int productId){
        return h.createQuery("SELECT image_url FROM product_images WHERE product_id = :id")
                .bind("id", productId)
                .mapTo(String.class)
                .list();
    }

    private List<ColorVariant> getRelatedColors(Handle h, int groupId, int currentProductId) {
        // Mapping thủ công:
        // Database: id, color_name, img
        // Java Class ColorVariant: productid, colorName, imgThumbnail
        return h.createQuery("SELECT id AS productid, color_name AS colorName, img AS imgThumbnail FROM products WHERE group_id = :group_id AND id != :current_id")
                .bind("group_id", groupId)
                .bind("current_id", currentProductId)
                .mapToBean(ColorVariant.class)
                .list();
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
                // 1. Insert vào bảng products và lấy ID vừa tạo
                int productId = h.createUpdate("INSERT INTO products(sku, name, img, price, sale_price, description, material, width, height, depth, category_id, group_id, color_name) " +
                                "VALUES (:sku, :name, :img, :price, :salePrice, :description, :material, :width, :height, :depth, :categoryId, :groupId, :colorName)")
                        .bindBean(p)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class)
                        .one();

                // 2. Insert vào bảng product_images (Gallery) nếu có
                if (p.getGalleryImages() != null && !p.getGalleryImages().isEmpty()) {
                    for (String imgUrl : p.getGalleryImages()) {
                        h.createUpdate("INSERT INTO product_images(product_id, image_url) VALUES (:pid, :url)")
                                .bind("pid", productId)
                                .bind("url", imgUrl)
                                .execute();
                    }
                }
            }
        });
    }
    public void delete(int id) {
        get().useHandle(h -> {
            // Xóa ảnh trong gallery trước (product_images thay vì product_colors)
            h.createUpdate("DELETE FROM product_images WHERE product_id = :id")
                    .bind("id", id).execute();

            // Sau đó xóa sản phẩm
            h.createUpdate("DELETE FROM products WHERE id = :id")
                    .bind("id", id).execute();
        });
    }

    // 2. Hàm Sửa (Update)
    public void update(Product p) {
        get().useHandle(h -> {
            h.createUpdate("UPDATE products SET sku=:sku, name=:name, img=:img, price=:price, sale_price=:salePrice, " +
                            "description=:description, material=:material, width=:width, height=:height, depth=:depth, " +
                            "category_id=:categoryId, group_id=:groupId, color_name=:colorName " +
                            "WHERE id = :id")
                    .bindBean(p)
                    .execute();

            // (Nâng cao) Nếu muốn update cả Gallery ảnh thì phải xóa ảnh cũ đi và insert lại ảnh mới ở đây
        });
    }

    public List<Product> getProductsByCategory(int cid) {
        return get().withHandle(h -> {
            String sql = "SELECT p.id, p.name, p.img, p.price, p.sale_price AS salePrice , p.group_id " +
                    "FROM products p " +
                    "WHERE p.category_id = :cid";

            return h.createQuery(sql)
                    .bind("cid", cid)
                    .mapToBean(Product.class)
                    .list();
        });
    }

    //lay ten danh muc hien cho dsap
    public String getCategoryName(int cid) {
        return get().withHandle(h -> {
            String sql = "SELECT name FROM categories WHERE id = :id";

            return h.createQuery(sql)
                    .bind("id", cid)
                    .mapTo(String.class) // Chỉ lấy 1 giá trị
                    .findFirst()         // Lấy kết quả đầu tiên tìm thấy
                    .orElse("Tất cả sản phẩm" +cid);
        });
    }
//    public List<String> getColorsByProductId(int id){
//        return get().withHandle(h->
//                h.createQuery("SELECT color_code FROM product_colors WHERE product_id = :id")
//                        .bind("id", id)
//                        .mapTo(String.class)
//                        .list()
//        );
//    }


//    public static void main(String[] args) {
//        ProductDao pd = new ProductDao();
//        pd.insert(pd.getListProduct());
//    }

}
