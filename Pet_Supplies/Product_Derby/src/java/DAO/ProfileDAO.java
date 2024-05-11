package DAO;

import Model.Customer;
import Model.Staff;
import Model.User;
import java.sql.*;

public class ProfileDAO {

    private String host = "jdbc:derby://localhost:1527/pet_supplies";
    private String user = "nbuser";
    private String pass = "nbuser";

    Connection conn = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    public ProfileDAO() {

    }

    public User displayProfile(User user) throws SQLException {
        User users = null;

        try {
            conn = getConnection();

            String sql = "SELECT u.user_id, u.positions, "
                    + "c.cust_id, "
                    + "c.username AS customer_username, "
                    + "c.password AS customer_password, "
                    + "c.email AS customer_email, "
                    + "c.contact AS customer_contact, "
                    + "c.address AS customer_address,"
                    + "s.staff_id, "
                    + "s.username AS staff_username, "
                    + "s.password AS staff_password, "
                    + "s.email AS staff_email, "
                    + "s.contact AS staff_contact "
                    + "FROM users u "
                    + "LEFT JOIN customer c ON u.cust_id = c.cust_id "
                    + "LEFT JOIN staff s ON u.staff_id = s.staff_id "
                    + "WHERE u.user_id = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, user.getUser_id());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String position = rs.getString("positions");

                if ("customer".equals(position)) {
                    String custID = rs.getString("cust_id");
                    String cUserName = rs.getString("customer_username");
                    String cPassword = rs.getString("customer_password");
                    String cEmail = rs.getString("customer_email");
                    String cContact = rs.getString("customer_contact");
                    String cAddress = rs.getString("customer_address");

                    Customer customer = new Customer(custID, cUserName, cPassword, cEmail, cContact, cAddress);
                    users = new User(user.getUser_id(), position, null, customer);

                } else if ("staff".equals(position) || "manager".equals(position)) {
                    String staffID = rs.getString("staff_id");
                    String sUsername = rs.getString("staff_username");
                    String sPassword = rs.getString("staff_password");
                    String sEmail = rs.getString("staff_email");
                    String sContact = rs.getString("staff_contact");

                    Staff staff = new Staff(staffID, sUsername, sPassword, sEmail, sContact);
                    users = new User(user.getUser_id(), position, staff, null);
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return users;
    }

    public void editProfile(User user) throws SQLException {

        try {
            conn = getConnection();

            String sql = "SELECT * FROM users WHERE user_id = ? AND positions = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, user.getUser_id());
            pstmt.setString(2, user.getPosition());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String position = rs.getString("positions");

                if ("customer".equals(position)) {
                    String sqlCustomer = "UPDATE customer "
                            + "SET username = ?, password = ?, email = ?, contact = ?, address = ? "
                            + "WHERE cust_id = ?";

                    PreparedStatement custPstmt = conn.prepareStatement(sqlCustomer);

                    custPstmt.setString(1, user.getCustomer().getUsername());
                    custPstmt.setString(2, user.getCustomer().getPassword());
                    custPstmt.setString(3, user.getCustomer().getEmail());
                    custPstmt.setString(4, user.getCustomer().getContact());
                    custPstmt.setString(5, user.getCustomer().getAddress());
                    custPstmt.setString(6, user.getCustomer().getCust_id());
                    custPstmt.executeUpdate();

                } else if ("staff".equals(position) || "manager".equals(position)) {
                    String sqlStaff = "UPDATE staff "
                            + "SET username = ?, password = ?, email = ?, contact = ? "
                            + "WHERE staff_id = ?";

                    PreparedStatement staffPstmt = conn.prepareStatement(sqlStaff);

                    staffPstmt.setString(1, user.getStaff().getUsername());
                    staffPstmt.setString(2, user.getStaff().getPassword());
                    staffPstmt.setString(3, user.getStaff().getEmail());
                    staffPstmt.setString(4, user.getStaff().getContact());
                    staffPstmt.setString(5, user.getStaff().getStaff_id());
                    staffPstmt.executeUpdate();

                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        } finally {
            // Close resources in reverse order of creation
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    protected Connection getConnection() {
        conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(host, user, pass);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
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
