package dao;

import model.Sale;
import util.DBConnection;
import java.sql.*;

public class SalesDAO {

    public int saveSale(Sale sale) throws Exception {

        String sql = "INSERT INTO sales (user_id, total_amount, payment_method) VALUES (?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, sale.getUserId());
            ps.setDouble(2, sale.getTotalAmount());
            ps.setString(3, sale.getPaymentMethod());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }
}
