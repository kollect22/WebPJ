
package model;

import java.io.Serializable;

public class ColorVariant implements Serializable {
    private int productid;
    private String colorName;
    private String imgThumbnail;

    public ColorVariant(int productid, String colorName, String imgThumbnail) {
        this.productid = productid;
        this.colorName = colorName;
        this.imgThumbnail = imgThumbnail;
    }
    public ColorVariant(){

    }

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getImgThumbnail() {
        return imgThumbnail;
    }

    public void setImgThumbnail(String imgThumbnail) {
        this.imgThumbnail = imgThumbnail;
    }
}