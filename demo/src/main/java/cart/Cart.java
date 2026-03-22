package cart;

import model.Product;
import java.io.Serializable;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

public class Cart implements Serializable {
    Map<Integer, CartItem> data;

    public Cart() {
        data = new HashMap<Integer, CartItem>();
    }
    public void addProduct(Product p, int quantity) {
        if (data.containsKey(p.getId())) {
            updateProduct(p.getId(), quantity);
        } else { if (quantity > 0) {
            data.put(p.getId(), new CartItem(p, p.getPrice(), quantity));}
        }
    }
    public void updateProduct(int id, int delta) {
        CartItem item = data.get(id);
        if (item == null) return;

        int newQty = item.getQuantity() + delta;

        if (newQty < 1) {
            return;
        }

        item.setQuantity(newQty);
    }

    public CartItem deleteProduct(int id) {
        return data.remove(id) ;
    }
    public List<CartItem> removeAll() {
        Collection<CartItem> values = data.values();
        data.clear();
        return new ArrayList<>(values);
    }
    public List<CartItem> getList() {
        return new ArrayList<>(data.values());
    }

    public int getTotalQuantity() {
        AtomicInteger total = new AtomicInteger();
        data.values().forEach(p -> {
            total.addAndGet(p.getQuantity());});
        return total.get();

    } public double getTotal() {
        AtomicReference<Double> total = new AtomicReference<>((double) 0);
        data.values().forEach(p -> total.updateAndGet(v -> (v + (p.getQuantity() * p.getPrice()))));
        return total.get();
    }
}