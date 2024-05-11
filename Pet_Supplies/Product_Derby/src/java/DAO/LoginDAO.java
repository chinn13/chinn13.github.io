package DAO;

import Model.Customer;
import Model.User;
import java.sql.*;

public class LoginDAO {

    private String host = "jdbc:derby://localhost:1527/pet_supplies";
    private String user = "nbuser";
    private String pass = "nbuser";

    PreparedStatement stmt = null;
    ResultSet rs = null;

    Connection conn = null;

    public LoginDAO() throws ClassNotFoundException {
        getConnection();
    }

    public User user_login(String email, String password) {
        User user = null;
        try {
            String sql = "SELECT u.user_id, u.positions, "
                    + "c.cust_id, c.email AS customer_email, c.password AS customer_password, "
                    + "s.staff_id, s.email AS staff_email, s.password AS staff_password "
                    + "FROM users u "
                    + "LEFT JOIN customer c ON u.cust_id = c.cust_id AND u.positions = 'customer'"
                    + "LEFT JOIN staff s ON u.staff_id = s.staff_id AND u.positions = 'staff' OR u.positions = 'manager'"
                    + "WHERE (c.email = ? AND c.password = ?) OR (s.email = ? AND s.password = ?)";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setString(3, email);
            stmt.setString(4, password);

            rs = stmt.executeQuery();

            if (rs.next()) {
                int user_id = rs.getInt("user_id");
                String userRole = rs.getString("positions");

                user = new User(user_id, userRole, null, null);
            }
        } catch (SQLException e) {
            e.getErrorCode();
        }
        return user;
    }

    public void InsertCustomer(Customer customer) throws SQLException {
        PreparedStatement stmtCheck = null;
        PreparedStatement stmtInsert = null;
        PreparedStatement stmtUsers = null;

        try {
            String sqlCheck = "SELECT * FROM customer ORDER BY cust_id DESC FETCH FIRST 1 ROWS ONLY";
            stmtCheck = conn.prepareStatement(sqlCheck);
            rs = stmtCheck.executeQuery();

            int id = 0;
            if (rs.next()) {
                String lastCustID = rs.getString("cust_id");
                id = Integer.parseInt(lastCustID.substring(2));
            }

            id++;
            String custID = "C" + String.format("%04d", id);

            String sqlDuplicateCheck = "SELECT * FROM customer WHERE cust_id = ?";
            stmtCheck = conn.prepareStatement(sqlDuplicateCheck);
            stmtCheck.setString(1, custID);
            rs = stmtCheck.executeQuery();

            if (!rs.next()) {
                String sqlInsert = "INSERT INTO customer (cust_id, username, password, email, contact, address) VALUES (?, ?, ?, ?, ?, ?)";
                stmtInsert = conn.prepareStatement(sqlInsert);

                stmtInsert.setString(1, custID);
                stmtInsert.setString(2, customer.getUsername());
                stmtInsert.setString(3, customer.getPassword());
                stmtInsert.setString(4, customer.getEmail());
                stmtInsert.setString(5, customer.getContact());
                stmtInsert.setString(6, customer.getAddress());

                int rowInsert = stmtInsert.executeUpdate();

                if (rowInsert > 0) {
                    String sqlUsers = "INSERT INTO users (positions, cust_id) VALUES (?, ?)";
                    stmtUsers = conn.prepareStatement(sqlUsers);

                    stmtUsers.setString(1, "customer");
                    stmtUsers.setString(2, custID);
                    stmtUsers.executeUpdate();
                }
            }
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
