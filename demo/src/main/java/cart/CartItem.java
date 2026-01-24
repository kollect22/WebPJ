package cart;

import model.Product;

import java.io.Serializable;
import java.util.concurrent.atomic.AtomicReference;

public class CartItem implements Serializable {

    private Product product;
    private double price;
    private int quantity;

    public CartItem(Product product, double price, int quantity) {
        this.product = product;
        this.price = price;
        this.quantity = quantity;
    }
    public CartItem() {
    }

    public double getTotal() {
        return price * quantity;
    }

    public void upQuantity(int quantity) {
        this.quantity += quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public Product getProduct() {
        return product;
    }
    public void setProduct (Product product) {
        this.product = product;
    }

    public double getPrice() {
        return price;
    }

    public void setQuantity(int newQty) {
        this.quantity = newQty;
    }

}
