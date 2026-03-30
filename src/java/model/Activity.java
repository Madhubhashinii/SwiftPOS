package model;

public class Activity {
    private String description;
    private String timestamp;
    private String user;
    private String type;
    private String icon;

    public Activity(String description, String timestamp, String user, String type, String icon) {
        this.description = description;
        this.timestamp = timestamp;
        this.user = user;
        this.type = type;
        this.icon = icon;
    }

    // Getters for JSP EL expressions
    public String getDescription() { return description; }
    public String getTimestamp() { return timestamp; }
    public String getUser() { return user; }
    public String getType() { return type; }
    public String getIcon() { return icon; }
}