package Controller.product;

import dao.ProductDao;
import jakarta.servlet.http.Part;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductAddController", value = "/admin/product-add")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class ProductAdd extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String sku = req.getParameter("sku");
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            String material = req.getParameter("material");
            String colorName = req.getParameter("colorName");

            int price = 0, salePrice = 0, categoryId = 1, groupId = 0;

            try {
                String strPrice = req.getParameter("price");
                if (strPrice != null && !strPrice.isEmpty()) price = Integer.parseInt(strPrice);

                String strSale = req.getParameter("salePrice");
                if (strSale != null && !strSale.isEmpty()) salePrice = Integer.parseInt(strSale);

                String strCat = req.getParameter("categoryId");
                if (strCat != null && !strCat.isEmpty()) categoryId = Integer.parseInt(strCat);

                String strGroup = req.getParameter("groupId");
                if (strGroup != null && !strGroup.isEmpty()) groupId = Integer.parseInt(strGroup);
            } catch (NumberFormatException e) {
                System.out.println("Lỗi parse số: " + e.getMessage());
            }

            Part mainImgPart = req.getPart("img");
            String mainImgFileName = "https://placehold.co/400x400?text=No+Image";

            if (mainImgPart != null && mainImgPart.getSize() > 0) {
                // Lấy tên file gốc
                String fileName = Paths.get(mainImgPart.getSubmittedFileName()).getFileName().toString();
                // Lưu file vào thư mục uploads
                mainImgPart.write(uploadPath + File.separator + fileName);
                // Gắn link để lưu vào Db
                mainImgFileName = "uploads/" + fileName;
            }

            //Xuwr lí nhiều ảnh upload
            List<String> galleryList = new ArrayList<>();
            for (Part part : req.getParts()) {
                if ("productImages".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    part.write(uploadPath + File.separator + fileName);
                    galleryList.add("uploads/" + fileName);
                }
            }

            //Gắn dữ liệu vào model
            Product newProduct = new Product();
            newProduct.setSku(sku);
            newProduct.setName(name);
            newProduct.setImg(mainImgFileName);
            newProduct.setGalleryImages(galleryList);

            newProduct.setPrice(price);
            newProduct.setSalePrice(salePrice);
            newProduct.setDescription(description);
            newProduct.setMaterial(material);
            newProduct.setCategoryId(categoryId);
            newProduct.setGroupId(groupId);
            newProduct.setColorName(colorName);

            ProductDao dao = new ProductDao();
            dao.insert(Arrays.asList(newProduct));

            // Chuyển hướng về trang danh sách
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi Thêm sản phẩm: " + e.getMessage());
        }
    }
}