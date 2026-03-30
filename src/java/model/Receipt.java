package model;

import java.util.List;

public class Receipt {

    private Sale sale;
    private List<SaleItem> items;

    public Receipt(Sale sale, List<SaleItem> items) {
        this.sale = sale;
        this.items = items;
    }

    public Sale getSale() { return sale; }
    public List<SaleItem> getItems() { return items; }
}
