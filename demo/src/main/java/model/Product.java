package model;

import java.io.Serializable;

public class Product implements Serializable {
    private int id;
    private String name;
    private String img;
    private int price;

    public Product(int id, String name, String img, int price) {
        this.id = id;
        this.name = name;
        this.img = img;
        this.price = price;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", img='" + img + '\'' +
                ", price=" + price +
                '}';
    }
}
