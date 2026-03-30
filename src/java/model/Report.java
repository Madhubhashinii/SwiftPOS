package model;

import java.io.Serializable;

/**
 * Report JavaBean - Model class for report data
 * This follows the MVC pattern as a Model (JavaBean)
 */
public class Report implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    // Report summary data
    private double totalSales;
    private int totalProductsSold;
    private int activeCashiers;
    private double growthRate;
    
    // Chart data
    private String[] chartLabels;
    private double[] chartData;
    
    // Report metadata
    private String reportType;
    private String dateRange;
    private String generatedDate;
    
    // Constructors
    public Report() {
        // Default constructor (required for JavaBean)
    }
    
    public Report(double totalSales, int totalProductsSold, int activeCashiers, double growthRate) {
        this.totalSales = totalSales;
        this.totalProductsSold = totalProductsSold;
        this.activeCashiers = activeCashiers;
        this.growthRate = growthRate;
    }
    
    // Getters and Setters (required for JavaBean)
    
    public double getTotalSales() {
        return totalSales;
    }
    
    public void setTotalSales(double totalSales) {
        this.totalSales = totalSales;
    }
    
    public int getTotalProductsSold() {
        return totalProductsSold;
    }
    
    public void setTotalProductsSold(int totalProductsSold) {
        this.totalProductsSold = totalProductsSold;
    }
    
    public int getActiveCashiers() {
        return activeCashiers;
    }
    
    public void setActiveCashiers(int activeCashiers) {
        this.activeCashiers = activeCashiers;
    }
    
    public double getGrowthRate() {
        return growthRate;
    }
    
    public void setGrowthRate(double growthRate) {
        this.growthRate = growthRate;
    }
    
    public String[] getChartLabels() {
        return chartLabels;
    }
    
    public void setChartLabels(String[] chartLabels) {
        this.chartLabels = chartLabels;
    }
    
    public double[] getChartData() {
        return chartData;
    }
    
    public void setChartData(double[] chartData) {
        this.chartData = chartData;
    }
    
    public String getReportType() {
        return reportType;
    }
    
    public void setReportType(String reportType) {
        this.reportType = reportType;
    }
    
    public String getDateRange() {
        return dateRange;
    }
    
    public void setDateRange(String dateRange) {
        this.dateRange = dateRange;
    }
    
    public String getGeneratedDate() {
        return generatedDate;
    }
    
    public void setGeneratedDate(String generatedDate) {
        this.generatedDate = generatedDate;
    }
    
    // Utility methods
    
    public String getFormattedTotalSales() {
        return String.format("%.2f", totalSales);
    }
    
    public String getFormattedGrowthRate() {
        return String.format("%.1f", growthRate);
    }
    
    @Override
    public String toString() {
        return "Report{" +
                "totalSales=" + totalSales +
                ", totalProductsSold=" + totalProductsSold +
                ", activeCashiers=" + activeCashiers +
                ", growthRate=" + growthRate +
                ", reportType='" + reportType + '\'' +
                ", dateRange='" + dateRange + '\'' +
                '}';
    }
}