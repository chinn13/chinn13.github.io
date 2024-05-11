/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Customer;
import Model.Order;
import Model.OrderDetail;
import Model.Pet;
import Model.Product;
import Model.Staff;
import Model.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author chxxp
 */
public final class AdminDAO {

    private String host = "jdbc:derby://localhost:1527/pet_supplies";
    private String user = "nbuser";
    private String pass = "nbuser";

    Connection conn = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    public AdminDAO() throws ClassNotFoundException {
        getConnection();
    }

    public List<Staff> staff_list() throws SQLException {
        List<Staff> staffList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM staff s JOIN users u ON s.staff_id = u.staff_id WHERE u.positions = 'staff'";
            pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String id = rs.getString("staff_id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String contact = rs.getString("contact");

                Staff staff = new Staff(id, username, password, email, contact);
                staffList.add(staff);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return staffList;
    }

    public List<Customer> cust_list() throws SQLException {
        List<Customer> custList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM customer";
            pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String id = rs.getString("cust_id");
                String username = rs.getString("username");
                String email = rs.getString("email");
                String contact = rs.getString("contact");
                String address = rs.getString("address");

                Customer cust = new Customer(id, username, email, contact, address);
                custList.add(cust);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return custList;
    }

    public int detail_status(Order order) throws SQLException {
        int status = 0;
        try {
            String sql = "SELECT * FROM order_ WHERE order_id = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, order.getOrder_id());

            rs = pstmt.executeQuery();

            if (rs.next()) {
                if (rs.getInt("delivered") != 0) {
                    status = 3;
                } else if (rs.getInt("shipping") != 0) {
                    status = 2;
                } else if (rs.getInt("packing") != 0) {
                    status = 1;
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return status;
    }

    public Order order_list(Order orderID) throws SQLException {
        Order order = null;
        try {
            String sql = "SELECT * FROM order_ WHERE order_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, orderID.getOrder_id());
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

                order = new Order(orderID.getOrder_id(), orderQty, amount, createDate, method, status, packing, shipping, delivered, user);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return order;
    }

    public List<OrderDetail> detail_list(Order orderID) throws SQLException {
        OrderDetail orderDetail;
        List<OrderDetail> detailList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM orderdetail WHERE order_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, orderID.getOrder_id());
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

                    orderDetail = new OrderDetail(null, product, orderDetailQty);
                    detailList.add(orderDetail);
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return detailList;
    }

    public List<Order> order_list() throws SQLException {
        List<Order> orderList = new ArrayList<>();

        try {
            String sql = "SELECT o.*, u.*, c.* FROM order_ o JOIN users u ON o.user_id = u.user_id JOIN customer c ON c.cust_id = u.cust_id ORDER BY o.createDate DESC";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                String orderID = rs.getString("order_id");
                int qty = rs.getInt("qty");
                double amount = rs.getDouble("amount");
                String createDate = rs.getString("createDate");
                String method = rs.getString("method");
                String status = rs.getString("status");
                String packing = rs.getString("packing");
                String shipping = rs.getString("shipping");
                String delivered = rs.getString("delivered");

                String username = rs.getString("username");

                Customer cust = new Customer();
                cust.setUsername(username);

                User user = new User(cust);

                Order order = new Order(orderID, qty, amount, createDate, method, status, packing, shipping, delivered, user);

                orderList.add(order);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return orderList;
    }

    public List<Product> product_list() throws SQLException {
        Product product;
        List<Product> prodList = new ArrayList<>();

        try {
            String sql = "SELECT * FROM product ORDER BY store ASC, product_id ASC";
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
                String store = rs.getString("store");

                Pet pet = new Pet();
                pet.setPet_id(rs.getString("pet_id"));

                product = new Product(prodID, type, name, qty, price, description, image, store, pet);
                prodList.add(product);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return prodList;
    }

    public void edit_image(int id, String image) throws SQLException {
        try {
            String sql = "UPDATE product set image = ? WHERE product_id = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, "images/" + image);
            pstmt.setInt(2, id);

            pstmt.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public Product edit_list(int id) throws SQLException {
        Product product = null;

        try {
            String sql = "SELECT * FROM product p JOIN pet pt ON p.pet_id = pt.pet_id WHERE product_id = ?";
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
                String store = rs.getString("store");

                Pet pet = new Pet();
                pet.setPet_id(rs.getString("pet_id"));
                pet.setAnimal(rs.getString("animal"));

                product = new Product(prodID, type, name, qty, price, description, image, store, pet);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return product;
    }

    public void add_product(Product product) throws SQLException {
        try {
            String sqlAdd = "Insert into product(type,name,qty,price,image,description,store,pet_id)"
                    + " values(?, ?, ?, ?, ?, ?, ?, ?)";

            pstmt = conn.prepareStatement(sqlAdd);

            pstmt.setString(1, product.getType());
            pstmt.setString(2, product.getName());
            pstmt.setInt(3, product.getQty());
            pstmt.setDouble(4, product.getPrice());
            pstmt.setString(5, product.getImage());
            pstmt.setString(6, product.getDescription());
            pstmt.setString(7, "On Stock");
            pstmt.setString(8, product.getPet().getPet_id());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void edit_product(Product product) throws SQLException {
        try {
            String sqlUpdate = "UPDATE product SET type = ?, name = ?, qty = ?, price = ?, image = ?, description = ?, store = ?, pet_id = ? WHERE product_id = ?";

            pstmt = conn.prepareStatement(sqlUpdate);

            pstmt.setString(1, product.getType());
            pstmt.setString(2, product.getName());
            pstmt.setInt(3, product.getQty());
            pstmt.setDouble(4, product.getPrice());
            pstmt.setString(5, product.getImage());
            pstmt.setString(6, product.getDescription());
            pstmt.setString(7, "On Stock");
            pstmt.setString(8, product.getPet().getPet_id());
            pstmt.setInt(9, product.getId());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void remove_product(int prodID) throws SQLException {
        try {
            String sql = "UPDATE product SET qty = ?, store = ? WHERE product_id = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, 0);
            pstmt.setString(2, "Out of Stock");
            pstmt.setInt(3, prodID);
            pstmt.executeUpdate();

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
