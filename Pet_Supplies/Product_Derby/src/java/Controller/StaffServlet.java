/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.StaffDAO;
import Model.Staff;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StaffServlet extends HttpServlet {

    StaffDAO staffDAO;

    public StaffServlet() throws ClassNotFoundException {
        this.staffDAO = new StaffDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/delete-staff":
                    Delete_Staff(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/add-staff":
                    Add_Staff(request, response);
                    break;
                case "/edit-staffList":
                    Edit_StaffList(request, response);
                    break;
                case "/edit-staff":
                    Edit_Staff(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    //    /remove-staff
    private void Delete_Staff(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        String staffID = request.getParameter("staff");
        staffDAO.delete_Staff(staffID);

        response.sendRedirect("staff-list");

    }

    //    /add-staff
    private void Add_Staff(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();

        String sUsername = request.getParameter("username");
        String sEmail = request.getParameter("email");
        String sContact = request.getParameter("contact");
        String sPassword = request.getParameter("password");

        try {
            Staff staff = new Staff();
            staff.setUsername(sUsername);
            staff.setEmail(sEmail);
            staff.setContact(sContact);
            staff.setPassword(sPassword);

            staffDAO.add_staff(staff);

            response.sendRedirect("staff-list");
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }

    }

    //    /edit-staffList
    private void Edit_StaffList(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        PrintWriter out = response.getWriter();

        Staff staff = new Staff();
        staff.setStaff_id(request.getParameter("staffID"));

        try {

            Staff retrieveStaff = staffDAO.edit_staffList(staff);

            request.setAttribute("retrieveStaff", retrieveStaff);

            out.print(retrieveStaff.getStaff_id());
            out.print(retrieveStaff.getUsername());
            out.print(retrieveStaff.getEmail());
            out.print(retrieveStaff.getContact());
            out.print(retrieveStaff.getPassword());

            request.getRequestDispatcher("Admin/edit-staff.jsp").forward(request, response);

        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }

    //    /edit-staff
    private void Edit_Staff(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {

        PrintWriter out = response.getWriter();

        String staffId = request.getParameter("staffID");
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");

        Staff staff = new Staff(staffId, userName, password, email, contact);

        staffDAO.edit_staff(staff);
        response.sendRedirect("staff-list");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
