package Controller.product;

import dao.ProductDao;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductAddController", value = "/admin/product-add")
public class ProductAdd extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            String sku = req.getParameter("sku");
            String name = req.getParameter("name");
            String img = req.getParameter("img"); // Ảnh đại diện
            String description = req.getParameter("description");
            String material = req.getParameter("material");
            String colorName = req.getParameter("colorName");

            int price = 0;
            int salePrice = 0;
            int categoryId = 1; // Mặc định nếu lỗi
            int groupId = 0;

//            String category = req.getParameter("category");
//            String description = req.getParameter("description");
//
//            double price = 0;
//            if (strPrice != null && !strPrice.isEmpty()) {
//                price = Double.parseDouble(strPrice);
//            }
//
//            if (img == null || img.trim().isEmpty()) {
//                img = "https://placehold.co/400x400?text=No+Image";
//            }

            try {
                price = Integer.parseInt(req.getParameter("price"));
                String strSale = req.getParameter("salePrice");
                if (strSale != null && !strSale.isEmpty()) {
                    salePrice = Integer.parseInt(strSale);
                }

                String strCat = req.getParameter("categoryId");
                if (strCat != null && !strCat.isEmpty()) categoryId = Integer.parseInt(strCat);

                String strGroup = req.getParameter("groupId");
                if (strGroup != null && !strGroup.isEmpty()) groupId = Integer.parseInt(strGroup);

            } catch (NumberFormatException e) {
                System.out.println("Lỗi parse số: " + e.getMessage());
            }

            // 3. Xử lý kích thước (Double)
            double width = 0, height = 0, depth = 0;
            try {
                String w = req.getParameter("width");
                String h = req.getParameter("height");
                String d = req.getParameter("depth");
                if(w!=null && !w.isEmpty()) width = Double.parseDouble(w);
                if(h!=null && !h.isEmpty()) height = Double.parseDouble(h);
                if(d!=null && !d.isEmpty()) depth = Double.parseDouble(d);
            } catch (Exception e) {
                System.out.println("Lỗi parse kích thước");
            }

            // Xử lý ảnh mặc định nếu để trống
            if (img == null || img.trim().isEmpty()) {
                img = "https://placehold.co/400x400?text=No+Image";
            }

            Product newProduct = new Product();
            newProduct.setSku(sku);
            newProduct.setName(name);
            newProduct.setImg(img);
            newProduct.setPrice(price);
            newProduct.setSalePrice(salePrice);
            newProduct.setDescription(description);
            newProduct.setMaterial(material);
            newProduct.setCategoryId(categoryId);

            newProduct.setGroupId(groupId);
            newProduct.setColorName(colorName);
//
//            newProduct.setDescription(description);
//            newProduct.setCategory(category);

            // Xử lý Gallery (Danh sách ảnh phụ)
            // Giả sử bên form nhập nhiều link ảnh, mỗi link cách nhau bằng xuống dòng (\n)
            String galleryText = req.getParameter("gallery");
            List<String> galleryList = new ArrayList<>();
            if (galleryText != null && !galleryText.trim().isEmpty()) {
                // Tách chuỗi theo dòng
                String[] lines = galleryText.split("\n");
                for (String line : lines) {
                    if (!line.trim().isEmpty()) {
                        galleryList.add(line.trim());
                    }
                }
            }

            newProduct.setGalleryImages(galleryList);

            ProductDao dao = new ProductDao();
            dao.insert(Arrays.asList(newProduct));

            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi Thêm sản phẩm: " + e.getMessage());
        }
    }
}