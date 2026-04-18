package model;

import java.io.Serializable;

public class Order implements Serializable {
    private int id;
    private String orderIdCode;
    private int userId;
    private String fullName;
    private String phone;
    private String address;
    private double totalPrice;
    private String paymentMethod;
    private int status;


    public Order() {}


    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getOrderIdCode() { return orderIdCode; }
    public void setOrderIdCode(String orderIdCode) { this.orderIdCode = orderIdCode; }

    public int getUserId() { return userId; } // JDBI tìm cái này cho :userId
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
}