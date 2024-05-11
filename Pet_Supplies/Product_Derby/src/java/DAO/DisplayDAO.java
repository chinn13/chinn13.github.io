/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Cart;
import Model.Customer;
import Model.Order;
import Model.OrderDetail;
import Model.Pet;
import Model.Product;
import Model.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

public final class DisplayDAO {

    private String host = "jdbc:derby://localhost:1527/pet_supplies";
    private String user = "nbuser";
    private String pass = "nbuser";

    Connection conn = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    public DisplayDAO() throws ClassNotFoundException {
        getConnection();
    }

    public Order view_order(Order order) throws SQLException {
        Order orders = null;
        try {
            String sql = "SELECT * FROM order_ WHERE order_id = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, order.getOrder_id());

            rs = pstmt.executeQuery();

            if (rs.next()) {
                int orderQty = rs.getInt("qty");
                double amount = rs.getDouble("amount");
                String createDate = rs.getString("createDate");
                String method = rs.getString("method");
                String status = rs.getString("status");
                String packing = rs.getString("packing");
                String shipping = rs.getString("shipping");
                String delivered = rs.getString("delivered");

                User user = new User();
                user.setUser_id(rs.getInt("user_id"));

                orders = new Order(order.getOrder_id(), orderQty, amount, createDate, method, status, packing, shipping, delivered, user);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return orders;
    }

    public List<OrderDetail> view_detail(User user) throws SQLException {
        List<OrderDetail> orderDetailList = new ArrayList<>();

        try {
            String sql = "SELECT od.*, o.*, p.*, p.qty AS prodQty, od.qty AS detailQty, o.qty AS orderQty FROM "
                    + "orderdetail od "
                    + "JOIN order_ o ON od.order_id = o.order_id "
                    + "JOIN product p ON od.product_id = p.product_id "
                    + "WHERE o.user_id = ? ORDER BY o.createdate DESC";

            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, user.getUser_id());

            rs = pstmt.executeQuery();

            while (rs.next()) {
                String orderID = rs.getString("order_id");
                int orderQty = rs.getInt("orderQty");
                double amount = rs.getDouble("amount");
                String createDate = rs.getString("createDate");
                String method = rs.getString("method");
                String status = rs.getString("status");
                String packing = rs.getString("packing");
                String shipping = rs.getString("shipping");
                String delivered = rs.getString("delivered");
                Order order = new Order(orderID, orderQty, amount, createDate, method, status, packing, shipping, delivered, user);

                int prodID = rs.getInt("product_id");
                String type = rs.getString("type");
                String name = rs.getString("name");
                int prodQty = rs.getInt("prodQty");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
                String description = rs.getString("description");
                Pet pet = new Pet();
                pet.setPet_id(rs.getString("pet_id"));
                Product product = new Product(prodID, type, name, prodQty, price, description, image, pet);

                int detailQty = rs.getInt("detailQty");
                OrderDetail orderDetail = new OrderDetail(order, product, detailQty);
                orderDetailList.add(orderDetail);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return orderDetailList;
    }

    public int delivery_status(User user, Order order) throws SQLException {
        int status = 0;
        try {
            String sql = "SELECT * FROM order_ WHERE order_id = ? AND user_id = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, order.getOrder_id());
            pstmt.setInt(2, user.getUser_id());

            rs = pstmt.executeQuery();

            if (rs.next()) {
                if (!rs.wasNull() && rs.getInt("delivered") != 0) {
                    status = 3;
                } else if (!rs.wasNull() && rs.getInt("shipping") != 0) {
                    status = 2;
                } else if (!rs.wasNull() && rs.getInt("packing") != 0) {
                    status = 1;
                } else {
                    status = 0;
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return status;
    }

    public List<Product> filter_list(String action, String type) throws SQLException {
        Product product;
        List<Product> prodList = new ArrayList<>();

        String sql = "";

        try {
            if ("D".equals(action)) {
                if (type != null) {
                    if (type.equalsIgnoreCase(type)) {
                        sql = "SELECT product.*, qty AS totalqty FROM product WHERE pet_id = 'D' AND type = '" + type + "' ORDER BY store ASC";
                    }
                } else {
                    sql = "SELECT product.*, qty AS totalqty FROM product WHERE pet_id = 'D' ORDER BY store ASC";
                }
            } else if ("C".equals(action)) {
                if (type != null) {
                    if (type.equalsIgnoreCase(type)) {
                        sql = "SELECT product.*, qty AS totalqty FROM product WHERE pet_id = 'C' AND type = '" + type + "' ORDER BY store ASC";
                    }
                } else {
                    sql = "SELECT product.*, qty AS totalqty FROM product WHERE pet_id = 'C' ORDER BY store ASC";
                }
            } else if ("S".equals(action)) {
                if (type != null) {
                    if (type.equalsIgnoreCase(type)) {
                        sql = "SELECT product.*, qty AS totalqty FROM product WHERE pet_id = 'S' AND type = '" + type + "' ORDER BY store ASC";
                    }
                } else {
                    sql = "SELECT product.*, qty AS totalqty FROM product WHERE pet_id = 'S' ORDER BY store ASC";
                }
            } else if ("T".equals(action)) {
//                sql = "SELECT p.*, (SELECT SUM(od.qty) FROM orderdetail od WHERE od.product_id = p.product_id) AS totalqty FROM product p ORDER BY totalqty DESC";
                sql = "SELECT p.*, (SELECT SUM(od.qty) FROM orderdetail od WHERE od.product_id = p.product_id) AS totalqty FROM product p WHERE (SELECT SUM(od.qty) FROM orderdetail od WHERE od.product_id = p.product_id) > 0 ORDER BY totalqty DESC NULLS LAST";
            } else {
                sql = "SELECT product.*, qty AS totalqty FROM product WHERE pet_id = ''";
            }

            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                int prodID = rs.getInt("product_id");
                String prodType = rs.getString("type");
                String name = rs.getString("name");
                int qty = rs.getInt("totalqty");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
                String store = rs.getString("store");
                String description = rs.getString("description");

                Pet pet = new Pet();
                pet.setPet_id(rs.getString("pet_id"));

                product = new Product(prodID, prodType, name, qty, price, description, image, store, pet);
                prodList.add(product);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return prodList;
    }

    public List<Product> product_list() throws SQLException {
        Product product;
        List<Product> prodList = new ArrayList<>();

        try {
            String sql = "SELECT * FROM product WHERE store = 'On Stock' AND price > 25 AND price < 60";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                int prodID = rs.getInt("product_id");
                String type = rs.getString("type");
                String name = rs.getString("name");
                int qty = rs.getInt("qty");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
                String description = rs.getString("description");

                Pet pet = new Pet();
                pet.setPet_id(rs.getString("pet_id"));

                product = new Product(prodID, type, name, qty, price, description, image, pet);
                prodList.add(product);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return prodList;
    }

    public Product product_detail(int id) throws SQLException {
        Product product = null;

        try {
            String sql = "SELECT * FROM product WHERE product_id = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, id);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                int prodID = rs.getInt("product_id");
                String type = rs.getString("type");
                String name = rs.getString("name");
                int qty = rs.getInt("qty");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
                String description = rs.getString("description");

                Pet pet = new Pet();
                pet.setPet_id(rs.getString("pet_id"));

                product = new Product(prodID, type, name, qty, price, description, image, pet);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return product;
    }

    public List<Cart> cart_list(User user) throws SQLException {
        Cart cart;
        Product product;
        List<Cart> cartList = new ArrayList<>();
        List<Product> prodList = new ArrayList<>();

        try {
            String sqlProduct = "SELECT c.*,c.qty AS qtyCart, p.*, p.qty AS qtyProduct, u.* FROM cart c JOIN product p ON c.product_id = p.product_id JOIN users u ON c.user_id = u.user_id WHERE c.user_id = ?";

            pstmt = conn.prepareStatement(sqlProduct);

            pstmt.setInt(1, user.getUser_id());

            rs = pstmt.executeQuery();

            while (rs.next()) {
                int cartID = rs.getInt("cart_id");
                int prodID = rs.getInt("product_id");
                int qtyCart = rs.getInt("qtyCart");

                String type = rs.getString("type");
                String name = rs.getString("name");
                int qtyProduct = rs.getInt("qtyProduct");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
                String description = rs.getString("description");

                Pet pet = new Pet();
                pet.setPet_id(rs.getString("pet_id"));

                product = new Product(prodID, type, name, qtyProduct, price, description, image, pet);
                cart = new Cart(cartID, product, qtyCart, user);

                cartList.add(cart);
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
        return cartList;
    }

    public List<Pet> pet_list() throws SQLException {
        Pet pet;
        List<Pet> petList = new ArrayList<>();

        try {
            String sqlProduct = "SELECT * FROM pet";
            stmt = conn.createStatement();

            rs = stmt.executeQuery(sqlProduct);

            while (rs.next()) {
                String petID = rs.getString("pet_id");
                String name = rs.getString("animal");

                pet = new Pet(petID, name);
                petList.add(pet);
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
        return petList;
    }

    public Order order_list(String orderID) throws SQLException {
        Order order = null;
        try {
            String sqlOrder = "SELECT * FROM order_ WHERE order_id = ?";
            pstmt = conn.prepareStatement(sqlOrder);

            pstmt.setString(1, orderID);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                int qty = rs.getInt("qty");
                double amount = rs.getDouble("amount");
                String createDate = rs.getString("createDate");
                String method = rs.getString("method");
                String status = rs.getString("status");
                String packing = rs.getString("packing");
                String shipping = rs.getString("shipping");
                String delivered = rs.getString("delivered");

                User user = new User();
                user.setUser_id(rs.getInt("user_id"));

                order = new Order(orderID, qty, amount, createDate, method, status, packing, shipping, delivered, user);
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
        return order;
    }

    public List<Product> orderdetail_list(String orderID) throws SQLException {
        List<Product> prodList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM orderdetail WHERE order_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, orderID);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int prodID = rs.getInt("product_id");
                int orderDetailQty = rs.getInt("qty");

                String prodSql = "SELECT * FROM product WHERE product_id = ?";
                pstmt = conn.prepareStatement(prodSql);
                pstmt.setInt(1, prodID);

                ResultSet prodRs = pstmt.executeQuery();

                if (prodRs.next()) {
                    String type = prodRs.getString("type");
                    String name = prodRs.getString("name");
                    int qtyProduct = prodRs.getInt("qty");
                    double price = prodRs.getDouble("price");
                    String image = prodRs.getString("image");
                    String description = prodRs.getString("description");

                    Pet pet = new Pet();
                    pet.setPet_id(prodRs.getString("pet_id"));

                    Product product = new Product(prodID, type, name, orderDetailQty, price, description, image, pet);
                    prodList.add(product);
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return prodList;
    }

    public Customer cust_info(User user) throws SQLException {
        Customer cust = null;
        try {
            String sqlUser = "SELECT * FROM users WHERE user_id = ?";
            pstmt = conn.prepareStatement(sqlUser);
            pstmt.setInt(1, user.getUser_id());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String custId = rs.getString("cust_id");
                String sqlOrder = "SELECT * FROM customer WHERE cust_id = ?";
                pstmt = conn.prepareStatement(sqlOrder);
                pstmt.setString(1, custId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String username = rs.getString("username");
                    String password = rs.getString("password");
                    String email = rs.getString("email");
                    String contact = rs.getString("contact");
                    String address = rs.getString("address");

                    cust = new Customer(custId, username, password, email, contact, address);
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return cust;
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
