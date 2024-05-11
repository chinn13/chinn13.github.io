/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Order;
import Model.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

public class OrderDAO {

    private String host = "jdbc:derby://localhost:1527/pet_supplies";
    private String user = "nbuser";
    private String pass = "nbuser";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    public OrderDAO() throws ClassNotFoundException {
        getConnection();
    }

    public String edit_address(User user, String address) throws SQLException {
        String addr = address;
        try {
            String sqlUpdate = "UPDATE customer c SET c.address = ? "
                    + "WHERE c.cust_id = ( SELECT u.cust_id FROM users u WHERE u.user_id = ?)";
            PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);

            pstmt.setString(1, address);
            pstmt.setInt(2, user.getUser_id());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
        return addr;
    }

    public void pay_order(Order order) throws SQLException {
        try {
            String sqlUpdate = "UPDATE order_ SET status = ? WHERE order_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);

            pstmt.setString(1, "Pending");
            pstmt.setString(2, order.getOrder_id());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void cancel_order(Order order) throws SQLException {
        try {
            String sqlUpdate = "UPDATE order_ SET status = ? WHERE order_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);

            pstmt.setString(1, "Cancel");
            pstmt.setString(2, order.getOrder_id());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void edit_delivery(Order order) throws SQLException {
        try {
            String sqlUpdate = "UPDATE order_ SET method = ? WHERE order_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);

            pstmt.setString(1, order.getMethod());
            pstmt.setString(2, order.getOrder_id());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public String add_order(User user, String method, double amount) throws SQLException {
        PreparedStatement stmtCart = null;
        PreparedStatement stmtStore = null;
        PreparedStatement stmtProduct = null;
        PreparedStatement stmtCartDelete = null;
        PreparedStatement stmtCheck = null;
        PreparedStatement stmtInsert = null;
        PreparedStatement stmtCartDetail = null;

        String orderId;
        int defaulT = 0;
        String status = "Pending";

        try {
            int totalQty = 0;

            String sqlCart = "SELECT p.*, c.*, c.qty AS cartQty, p.qty AS prodQty FROM cart c JOIN product p ON c.product_id = p.product_id WHERE c.user_id = ?";
//            String sqlCart = "SELECT *, p.qty AS prodQty FROM cart c JOIN product p ON c.product_id = p.product_id WHERE c.user_id = ?";
            stmtCart = conn.prepareStatement(sqlCart);

            stmtCart.setInt(1, user.getUser_id());

            ResultSet rsCart = stmtCart.executeQuery();

            while (rsCart.next()) {
                int prodID = rsCart.getInt("product_id");
                int qty = rsCart.getInt("cartQty");
                int prodQty = rsCart.getInt("prodQty");
                double price = rsCart.getDouble("price");
                totalQty += qty;

                String sqlProduct = "select * from product where product_id = ?";
                stmtProduct = conn.prepareStatement(sqlProduct);

                stmtProduct.setInt(1, prodID);
                ResultSet rsProduct = stmtProduct.executeQuery();

                if (rsProduct.next()) {
                    String sqlStore = "UPDATE product SET qty = ? WHERE product_id = ?";
                    stmtStore = conn.prepareStatement(sqlStore);

                    stmtStore.setInt(1, prodQty - qty);
                    stmtStore.setInt(2, prodID);
                    stmtStore.executeUpdate();
                }
            }
            rsCart.close();
            stmtCart.close();

            do {
                Random random = new Random();
                int id = random.nextInt(900000) + 100000;
                orderId = "O" + String.format("%06d", id);

                String sqlCheck = "SELECT * FROM order_ WHERE order_id = ?";
                stmtCheck = conn.prepareStatement(sqlCheck);

                stmtCheck.setString(1, orderId);

                ResultSet rsCheck = stmtCheck.executeQuery();

                if (!rsCheck.next()) {
                    break;
                }
                rsCheck.close();
                stmtCheck.close();
            } while (true);

            Timestamp currentTime = new Timestamp(System.currentTimeMillis());

            String sqlInsertOrder = "INSERT INTO order_ (order_id, qty, amount, createDate, method, packing, shipping, delivered, status, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            stmtInsert = conn.prepareStatement(sqlInsertOrder);

            stmtInsert.setString(1, orderId);
            stmtInsert.setInt(2, totalQty);
            stmtInsert.setDouble(3, amount);
            stmtInsert.setTimestamp(4, currentTime);
            stmtInsert.setString(5, method);
            stmtInsert.setInt(6, defaulT);
            stmtInsert.setInt(7, defaulT);
            stmtInsert.setInt(8, defaulT);
            stmtInsert.setString(9, status);
            stmtInsert.setInt(10, user.getUser_id());

            int rowOrder = stmtInsert.executeUpdate();

            stmtInsert.close();

            if (rowOrder > 0) {
                String sqlCartDetail = "SELECT product_id, qty FROM cart WHERE user_id = ?";

                stmtCartDetail = conn.prepareStatement(sqlCartDetail);
                stmtCartDetail.setInt(1, user.getUser_id());

                ResultSet rsCartDetail = stmtCartDetail.executeQuery();

                String sqlInsertOrderDetail = "INSERT INTO orderdetail (order_id, product_id, qty) VALUES (?, ?, ?)";
                PreparedStatement stmtInsertOrderDetail = conn.prepareStatement(sqlInsertOrderDetail);

                stmtCartDelete = conn.prepareStatement("DELETE FROM cart WHERE user_id = ?");

                while (rsCartDetail.next()) {
                    int cartProductID = rsCartDetail.getInt("product_id");
                    double cartQty = rsCartDetail.getDouble("qty");
                    stmtInsertOrderDetail.setString(1, orderId);
                    stmtInsertOrderDetail.setInt(2, cartProductID);
                    stmtInsertOrderDetail.setDouble(3, cartQty);
                    stmtInsertOrderDetail.executeUpdate();
                }

                rsCartDetail.close();
                stmtCartDetail.close();

                stmtCartDelete.setInt(1, user.getUser_id());
                stmtCartDelete.executeUpdate();
                stmtCartDelete.close();
            }
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
        return orderId;
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
