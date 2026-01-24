
package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Product implements Serializable {
    private int id;
    private String name;
    private String sku;
    private String img;
    private int price;
    private int salePrice;

    private String description;
    private String material;

    private double width;           // Chiều rộng
    private double height;          // Chiều cao
    private double depth;

    private int categoryId;
    private String categoryName;

    private List<String> galleryImages = new ArrayList<>();
    private List<ColorVariant> colors = new ArrayList<>();

    private  int groupId;
    private String colorName;
    public Product(){

    }
    public Product(int id, String name, String img, int price, int salePrice) {
        this.id = id;
        this.name = name;
        this.img = img;
        this.price = price;
        this.salePrice = salePrice;
    }

//    public Product(int id, String name, String img, int price, String description, String category, List<String> colors) {
//        this.id = id;
//        this.name = name;
//        this.img = img;
//        this.price = price;
//        this.description = description;
//        this.category = category;
//        this.colors = colors;
//    }

    public String getDimensions(){
        return width + " x " + depth + " x " + height + " cm";
    }

    public int getDiscountPercent(){
        if(price == 0) return 0;
        return 100 -(salePrice*100/price);
    }

    public List<ColorVariant> getColors() { return colors; }
    public void setColors(List<ColorVariant> colors) { this.colors = colors; }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getImg() { return img; }
    public void setImg(String img) { this.img = img; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public int getSalePrice() { return salePrice; }
    public void setSalePrice(int salePrice) { this.salePrice = salePrice; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getMaterial() { return material; }
    public void setMaterial(String material) { this.material = material; }

    public double getWidth() { return width; }
    public void setWidth(double width) { this.width = width; }

    public double getHeight() { return height; }
    public void setHeight(double height) { this.height = height; }

    public double getDepth() { return depth; }
    public void setDepth(double depth) { this.depth = depth; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public List<String> getGalleryImages() { return galleryImages; }
    public void setGalleryImages(List<String> galleryImages) { this.galleryImages = galleryImages; }

    @Override
    public String toString() {
        return "Product{id=" + id + ", name='" + name + "', sku='" + sku + "'}";
    }
}