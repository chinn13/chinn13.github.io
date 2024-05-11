/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Order;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author chxxp
 */
public class PaymentDAO {

    private String host = "jdbc:derby://localhost:1527/pet_supplies";
    private String user = "nbuser";
    private String pass = "nbuser";

    Connection conn = null;
    PreparedStatement stmt = null;

    public PaymentDAO() throws ClassNotFoundException {
        conn = getConnection();
    }

    public void paid(Order order, double amount) throws SQLException {
        try {
            double total = 0;

            String sqlCart = "UPDATE order_ SET status = ?, packing = ?, amount = ? WHERE order_id = ?";
            stmt = conn.prepareStatement(sqlCart);

            if (amount < 1000) {
                total = amount + 25.00;
            } else {
                total = 0.00;
            }

            stmt.setString(1, "Paid");
            stmt.setInt(2, 1);
            stmt.setDouble(3, total);
            stmt.setString(4, order.getOrder_id());

            stmt.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    protected Connection getConnection() throws ClassNotFoundException {
        conn = null;
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, pass);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
