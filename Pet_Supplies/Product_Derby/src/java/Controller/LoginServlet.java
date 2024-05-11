/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.LoginDAO;
import Model.Customer;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public final class LoginServlet extends HttpServlet {

    LoginDAO loginDAO;

    public LoginServlet() throws ClassNotFoundException {
        this.loginDAO = new LoginDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/logout":
                    UserLogout(request, response);
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
                case "/register":
                    AddCustomer(request, response);
                    break;
                case "/login":
                    UserLogin(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void UserLogout(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Invalidate the session (logout)
            session.invalidate();
        }

        // Redirect to login page after logout
        response.sendRedirect("all");
    }

    private void UserLogin(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        out.print(email + password);

        User user = loginDAO.user_login(email, password);

        out.print(user.getUser_id() + ", ID: " + user.getUser_id());

        session.setAttribute("user_id", user.getUser_id());

        switch (user.getPosition()) {
            case "customer":
                session.setAttribute("loginRole", user.getPosition());
                response.sendRedirect("all");
                break;
            case "staff":
                session.setAttribute("loginRole", user.getPosition());
                response.sendRedirect("Admin/home.jsp");
                break;
            case "manager":
                session.setAttribute("loginRole", user.getPosition());
                response.sendRedirect("Admin/home.jsp");
                break;
            default:
                out.println("Invalid user role.");
                break;
        }
    }

    private void AddCustomer(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        PrintWriter out = response.getWriter();
        
        try {
            // Retrieve parameters from request
            String cUsername = request.getParameter("username");
            String cContact = request.getParameter("contact");
            String cEmail = request.getParameter("email");
            String cAddress = request.getParameter("address");
            String cPassword = request.getParameter("password");
            
//            out.print(cUsername);
//            out.print(cContact);
//            out.print(cEmail);
//            out.print(cAddress);
//            out.print(cPassword);

            // Create Customer object and set properties
            Customer customer = new Customer();
            customer.setUsername(cUsername);
            customer.setContact(cContact);
            customer.setEmail(cEmail);
            customer.setAddress(cAddress);
            customer.setPassword(cPassword);
            loginDAO.InsertCustomer(customer);

            response.sendRedirect("Guest/login.jsp");

        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
