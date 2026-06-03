package Controller;

import dao.ProductDao;
import model.Banner;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(name = "AdminBannerAddController", value = "/admin/banner-add")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class AdminBannerAddController extends HttpServlet {
    private final ProductDao productDao = new ProductDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String link = request.getParameter("link");

            // Xử lý file ảnh tải lên
            Part filePart = request.getPart("file");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Tìm đường dẫn vật lý đến thư mục chứa ảnh trong project
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "img" + File.separator + "banners";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir(); // Tự tạo thư mục nếu chưa có

            // Ghi file ảnh vào thư mục trên server
            filePart.write(uploadPath + File.separator + fileName);
            String dbImagePath = "img/banners/" + fileName; // Đường dẫn tương đối để lưu xuống DB

            // Đóng gói đối tượng và lưu vào Database
            Banner banner = new Banner();
            banner.setImg(dbImagePath);
            banner.setTitle(title);
            banner.setLink(link);
            banner.setStatus(1);

            productDao.insertBanner(banner);

            //Lưu thành công thì tải lại trang Quản lý Banner
            response.sendRedirect(request.getContextPath() + "/admin/banners");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi xử lý upload: " + e.toString());
        }
    }
}