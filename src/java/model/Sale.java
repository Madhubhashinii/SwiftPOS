package model;

import java.sql.Timestamp;

public class Sale {

    private int id;
    private int userId;
    private Timestamp saleDate;
    private double totalAmount;
    private String paymentMethod;
    
// Keep your existing fields...
private String cashier;    // New: for ${sale.cashier}
private int items;         // New: for ${sale.items}
private double subtotal;   // New: for ${sale.subtotal}
private double tax;        // New: for ${sale.tax}

// Add these new Getters and Setters:
public String getCashier() { return cashier; }
public void setCashier(String cashier) { this.cashier = cashier; }

public int getItems() { return items; }
public void setItems(int items) { this.items = items; }

public double getSubtotal() { return subtotal; }
public void setSubtotal(double subtotal) { this.subtotal = subtotal; }

public double getTax() { return tax; }
public void setTax(double tax) { this.tax = tax; }

// IMPORTANT: Your JSP uses ${sale.date}, but your field is saleDate. 
// Add this getter so the JSP can find it:
public Timestamp getDate() { return saleDate; } 

// IMPORTANT: Your JSP uses ${sale.total}, but your field is totalAmount.
// Add this getter so the JSP can find it:
public double getTotal() { return totalAmount; }

///

    public Sale() {}

    public Sale(int id, int userId, double totalAmount, String paymentMethod) {
        this.id = id;
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public Timestamp getSaleDate() { return saleDate; }
    public void setSaleDate(Timestamp saleDate) { this.saleDate = saleDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
}
