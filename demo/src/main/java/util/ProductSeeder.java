package util;

import dao.ProductDao;
import model.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductSeeder {

    public static void main(String[] args) {

        ProductDao dao = new ProductDao();
        List<Product> list = new ArrayList<>();

        list.add(new Product(
                0,
                "Túi xách nữ",
                "img/products/tui-xach-nau-ca-tinh/a1.jpg",
                250000,
                "Túi xách nữ cá tính",
                "Túi xách",
                null
        ));

        list.add(new Product(
                0,
                "Túi da",
                "img/products/tui-da/a1.jpeg",
                320000,
                "Túi da cao cấp",
                "Túi xách",
                null
        ));

        list.add(new Product(
                0,
                "Túi đeo chéo",
                "img/products/tui-deo-cheo/anh1.jpg",
                280000,
                "Túi đeo chéo năng động",
                "Túi xách",
                null
        ));

        list.add(new Product(
                0,
                "Túi da cá sấu",
                "img/products/tui-da-ca-sau/a1.jpeg",
                950000,
                "Túi da cá sấu thật",
                "Túi xách",
                null
        ));

        list.add(new Product(
                0,
                "Túi Enola",
                "img/products/tui-enola/anh4.jpg",
                450000,
                "Túi thời trang Enola",
                "Túi xách",
                null
        ));

        list.add(new Product(
                0,
                "Túi xách hàng hiệu",
                "img/products/tui-hang-hieu/a1.jpg",
                1200000,
                "Túi xách hàng hiệu cao cấp",
                "Túi xách",
                null
        ));

        list.add(new Product(
                0,
                "Túi Mirabelle",
                "img/products/tui-mirabelle/nau3.jpg",
                520000,
                "Túi Mirabelle thời trang",
                "Túi xách",
                null
        ));

        list.add(new Product(
                0,
                "Túi xách Noane",
                "img/products/tui-noane/anh3.jpg",
                480000,
                "Túi xách Noane thanh lịch",
                "Túi xách",
                null
        ));

        list.add(new Product(
                0,
                "Túi xách nữ quai đôi",
                "img/products/tui-quai-doi/a1.jpg",
                390000,
                "Túi xách nữ quai đôi",
                "Túi xách",
                null
        ));

        list.add(new Product(
                0,
                "Túi xách nữ Handmade",
                "img/products/tui-xach-handmade/a2.jpg",
                420000,
                "Túi xách nữ handmade",
                "Túi xách",
                null
        ));

        dao.insert(list);

        System.out.println("✅ ĐÃ SEED XONG DỮ LIỆU SẢN PHẨM");
    }
}
