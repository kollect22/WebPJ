package dao;

import model.Category;
import java.util.List;

public class CategoryDao extends BaseDao {

    public List<Category> getAll() {
        return get().withHandle(h -> {
            return h.createQuery("SELECT * FROM categories ORDER BY id DESC")
                    .mapToBean(Category.class)
                    .list();
        });
    }

    public boolean insert(String categoryName) {
        return get().withHandle(h -> {
            return h.createUpdate("INSERT INTO categories (name) VALUES (:name)")
                    .bind("name", categoryName)
                    .execute() > 0;
        });
    }
}