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

@WebServlet(name = "AdminBannerEditController", value = "/admin/banner-edit")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class AdminBannerEditController extends HttpServlet {
    private final ProductDao productDao = new ProductDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Đọc thông tin chữ từ Form gửi lên
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String link = request.getParameter("link");
            String oldImg = request.getParameter("oldImg");

            // Xử lý file ảnh tải lên
            Part filePart = request.getPart("file");
            String dbImagePath = oldImg;

            // Kiểm tra xem Admin có thực sự chọn một file mới không
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                // Vị trí lưu file trên server Tomcat
                String uploadPath = request.getServletContext().getRealPath("") + File.separator + "img" + File.separator + "banners";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                filePart.write(uploadPath + File.separator + fileName);
                dbImagePath = "img/banners/" + fileName;
            }

            // Đóng gói dữ liệu và gọi DAO thực thi cập nhật xuống Database
            Banner banner = productDao.getBannerById(id);
            if (banner != null) {
                banner.setTitle(title);
                banner.setLink(link);
                banner.setImg(dbImagePath);

                productDao.updateBanner(banner);
            }

            // Quay trở lại trang danh sách quản lý banner
            response.sendRedirect(request.getContextPath() + "/admin/banners");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi xử lý cập nhật banner: " + e.toString());
        }
    }
}