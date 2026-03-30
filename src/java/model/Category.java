package model;

public class Category {
    private int id;
    private String name;
    private String description;
    private boolean featured;
    private int productCount;
    
    public Category() {}
    
    public Category(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public boolean isFeatured() { return featured; }
    public void setFeatured(boolean featured) { this.featured = featured; }
    
    public int getProductCount() { return productCount; }
    public void setProductCount(int productCount) { this.productCount = productCount; }
}