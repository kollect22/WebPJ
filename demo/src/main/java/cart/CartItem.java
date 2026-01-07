package cart;

import model.Product;

import java.io.Serializable;
import java.util.concurrent.atomic.AtomicReference;

public class CartItem implements Serializable {

    private Product product;
    private int price;
    private int quantity;

    public CartItem() {
    }

    public CartItem(Product product, int price, int quantity) {
        this.product = product;
        this.price = price;
        this.quantity = quantity;
    }
    public double getTotal() {
        return price * quantity;
    }

    public void upQuantity(int quantity) {
        if(quantity <= 0) quantity =1;
        this.quantity += quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public Product getProduct() {
        return product;
    }

    public double getPrice() {
        return price;
    }
}
