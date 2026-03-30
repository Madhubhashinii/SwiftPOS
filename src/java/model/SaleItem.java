package model;

public class SaleItem {

    private int id;
    private int saleId;
    private int productId;
    private int quantity;
    private double price;

    public SaleItem() {}

    public SaleItem(int saleId, int productId, int quantity, double price) {
        this.saleId = saleId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getSaleId() { return saleId; }
    public void setSaleId(int saleId) { this.saleId = saleId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
