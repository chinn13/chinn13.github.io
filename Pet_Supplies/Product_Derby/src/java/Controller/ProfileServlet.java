/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.ProfileDAO;
import Model.Customer;
import Model.Staff;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProfileServlet extends HttpServlet {

    ProfileDAO profileDAO;

    public ProfileServlet() throws ClassNotFoundException {
        this.profileDAO = new ProfileDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/displayProfile":
                    DisplayProfile(request, response);
                    break;
                case "/profile":
                    Profile(request, response);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            log("Error processing GET request: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/updateProfile":
                    UpdateProfile(request, response);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            log("Error processing GET request: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void DisplayProfile(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("user_id");

        try {
            User profile = profileDAO.displayProfile(new User(userId));
            request.setAttribute("profile", profile);

            out.print(profile.getPosition());
//            out.print(profile.getCustomer());
//            out.print(profile.getStaff());
//            out.print(profile.getUser_id());

            request.getRequestDispatcher("Guest/profile.jsp").forward(request, response);

        } catch (Exception e) {
            log("Error while fetching user profile: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void Profile(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("user_id");

        try {
            User profile = profileDAO.displayProfile(new User(userId));
            request.setAttribute("userprofile", profile);

            out.print(profile.getPosition());
            out.print(profile.getCustomer());
            out.print(profile.getStaff());
            out.print(profile.getUser_id());

            request.getRequestDispatcher("Guest/user-profile.jsp").forward(request, response);

        } catch (Exception e) {
            log("Error while fetching user profile: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void UpdateProfile(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException, SQLException {
        PrintWriter out = response.getWriter();

        String position = request.getParameter("position");

        HttpSession session = request.getSession();

        User users = new User();
        users.setUser_id((Integer) session.getAttribute("user_id"));
        users.setPosition(position);
        out.print(users.getUser_id() + "," + users.getPosition());

        String custId = request.getParameter("custID");
        String staffId = request.getParameter("staffID");
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");

//        out.print(custId);
//        out.print(staffId);
//        out.print(userName);
//        out.print(password);
//        out.print(email);
//        out.print(contact);
//        out.print(address);
        if ("customer".equals(position)) {

            Customer customer = new Customer(custId, userName, password, email, contact, address);
            users.setCustomer(customer);
            profileDAO.editProfile(users);

        } else if ("staff".equals(position) || "manager".equals(position)) {

            Staff staff = new Staff(staffId, userName, password, email, contact);
            users.setStaff(staff);
            profileDAO.editProfile(users);

        }

        response.sendRedirect(request.getContextPath() + "/displayProfile");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
