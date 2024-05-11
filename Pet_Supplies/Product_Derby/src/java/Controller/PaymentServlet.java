/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.PaymentDAO;
import Model.Order;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class PaymentServlet extends HttpServlet {

    PaymentDAO paymentDAO;

    public PaymentServlet() throws ClassNotFoundException {
        this.paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/paid":
                    Paid(request, response);
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

//        try {
//            switch (action) {
//                case "/paid":
//                    Paid(request, response);
//                    break;
//                default:
//                    break;
//            }
//        } catch (SQLException ex) {
//            throw new ServletException(ex);
//        }
    }

    private void Paid(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        User user = new User();
        user.setUser_id((Integer) session.getAttribute("user_id"));
        Order order = new Order();
        order.setOrder_id((String) session.getAttribute("orderID"));

        double amount = (Double) session.getAttribute("orderAmount");

        paymentDAO.paid(order, amount);
        session.setAttribute("user_id", user.getUser_id());

        response.sendRedirect("all");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
