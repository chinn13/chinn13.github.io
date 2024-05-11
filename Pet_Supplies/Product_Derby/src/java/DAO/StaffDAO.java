/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Staff;
import Model.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class StaffDAO {

    private String host = "jdbc:derby://localhost:1527/pet_supplies";
    private String user = "nbuser";
    private String pass = "nbuser";

    Connection conn = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    public StaffDAO() {

    }

    public void delete_Staff(String staffID) throws SQLException {
        PreparedStatement pstmtStaff = null;
        
        try {
            conn = getConnection();

                String sqlDeleteUser = "DELETE FROM users WHERE staff_id = ?";
                pstmtStaff = conn.prepareStatement(sqlDeleteUser);
                pstmtStaff.setString(1, staffID);
                pstmtStaff.executeUpdate();

                String sqlDeleteStaff = "DELETE FROM staff WHERE staff_id = ?";
                pstmtStaff = conn.prepareStatement(sqlDeleteStaff);
                pstmtStaff.setString(1, staffID);
                pstmtStaff.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void add_staff(Staff staff) throws SQLException {

        PreparedStatement stmtCheck = null;
        PreparedStatement stmtInsert = null;
        PreparedStatement stmtUsers = null;

        ResultSet rs = null;

        try {
            conn = getConnection();

            String sqlCheck = "SELECT * FROM staff ORDER BY staff_id DESC FETCH FIRST 1 ROWS ONLY";
            stmtCheck = conn.prepareStatement(sqlCheck);
            rs = stmtCheck.executeQuery();

            int id = 0;
            if (rs.next()) {
                String lastCustID = rs.getString("staff_id");
                id = Integer.parseInt(lastCustID.substring(2));
            }

            id++;
            String staffID = "S" + String.format("%04d", id);

            String sqlDuplicateCheck = "SELECT * FROM staff WHERE staff_id = ?";
            stmtCheck = conn.prepareStatement(sqlDuplicateCheck);
            stmtCheck.setString(1, staffID);
            rs = stmtCheck.executeQuery();

            if (!rs.next()) {
                String sqlInsert = "INSERT INTO staff (staff_id, username, password, email, contact) VALUES (?, ?, ?, ?, ?)";
                stmtInsert = conn.prepareStatement(sqlInsert);

                stmtInsert.setString(1, staffID);
                stmtInsert.setString(2, staff.getUsername());
                stmtInsert.setString(3, staff.getPassword());
                stmtInsert.setString(4, staff.getEmail());
                stmtInsert.setString(5, staff.getContact());

                int rowInsert = stmtInsert.executeUpdate();

                if (rowInsert > 0) {
                    String sqlUsers = "INSERT INTO users (positions, staff_id) VALUES (?, ?)";
                    stmtUsers = conn.prepareStatement(sqlUsers);

                    stmtUsers.setString(1, "staff");
                    stmtUsers.setString(2, staffID);
                    stmtUsers.executeUpdate();
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public Staff edit_staffList(Staff staff) throws SQLException {

        Staff staffs = null;

        try {

            conn = getConnection();

            String sql = "SELECT * FROM staff WHERE staff_id = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, staff.getStaff_id());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String sUsername = rs.getString("username");
                String sPassword = rs.getString("password");
                String sEmail = rs.getString("email");
                String sContact = rs.getString("contact");

                staffs = new Staff(staff.getStaff_id(), sUsername, sPassword, sEmail, sContact);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return staffs;
    }

    public void edit_staff(Staff staff) throws SQLException {

        try {

            conn = getConnection();

            String sqlUpdate = "UPDATE staff "
                    + "SET username = ?, password = ?, email = ?, contact = ? "
                    + "WHERE staff_id = ?";

            pstmt = conn.prepareStatement(sqlUpdate);

            pstmt.setString(1, staff.getUsername());
            pstmt.setString(2, staff.getPassword());
            pstmt.setString(3, staff.getEmail());
            pstmt.setString(4, staff.getContact());
            pstmt.setString(5, staff.getStaff_id());
            pstmt.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
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
