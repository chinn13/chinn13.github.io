package DAO;

import Model.Cart;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CartDAO {

    private String host = "jdbc:derby://localhost:1527/pet_supplies";
    private String user = "nbuser";
    private String pass = "nbuser";

    Connection conn = null;
    PreparedStatement stmt = null;

    public CartDAO() throws ClassNotFoundException {
        getConnection();
    }

    public void add_cart(Cart cart) throws SQLException {
        try {
            String sqlCheck = "SELECT * FROM cart WHERE product_id = ? AND user_id = ?";
            stmt = conn.prepareStatement(sqlCheck);

            stmt.setInt(1, cart.getCart_id());
            stmt.setInt(2, cart.getUser().getUser_id());

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int qtyCart = rs.getInt("qty");

                String updateQuery = "UPDATE cart SET qty = ? WHERE product_id = ? AND user_id = ?";

                stmt = conn.prepareStatement(updateQuery);
                stmt.setInt(1, cart.getQty() + qtyCart);
                stmt.setInt(2, cart.getCart_id());
                stmt.setInt(3, cart.getUser().getUser_id());
                stmt.executeUpdate();
            } else {
                String insertQuery = "INSERT INTO cart (product_id, qty, user_id) VALUES (?, ?, ?)";
//                String insertQuery = "INSERT INTO cart (cart_id, product_id, qty, user_id) VALUES (?, ?, ?, ?)";

                stmt = conn.prepareStatement(insertQuery);
//                stmt.setInt(1, 99);
                stmt.setInt(1, cart.getCart_id());
                stmt.setInt(2, cart.getQty());
                stmt.setInt(3, cart.getUser().getUser_id());
                stmt.executeUpdate();
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void edit_cart(Cart cart) throws SQLException {
        try {
            String sqlUpdate = "UPDATE cart SET qty = ? WHERE cart_id = ?";
            stmt = conn.prepareStatement(sqlUpdate);

            stmt.setInt(1, cart.getQty());
            stmt.setInt(2, cart.getCart_id());

            stmt.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void delete_cart(Cart cart) throws SQLException {
        try {
            String sqlCart = "Delete FROM cart WHERE cart_id = ?";
            stmt = conn.prepareStatement(sqlCart);

            stmt.setInt(1, cart.getCart_id());

            stmt.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

//--------------------------------------------------------------------------------------------------
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
