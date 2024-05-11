/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import Model.Customer;
import Model.Order;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class OrderServlet extends HttpServlet {

    OrderDAO orderDao;

    public OrderServlet() throws ClassNotFoundException {
        this.orderDao = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.print("Get");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();
        out.print("PostOrder");

        try {
            switch (action) {
                case "/add-order":
                    Add_Order(request, response);
                    break;
                case "/checkout-order":
                    Checkout_Order(request, response);
                    break;
                case "/edit-address":
                    Edit_Address(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    // ../add-order (OrderServlet)
    // POST Method FROM Guest/cart-list.jsp
    private void Add_Order(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        User user = new User();
        user.setUser_id((Integer) session.getAttribute("user_id"));

        String method = request.getParameter("deliveryMethod");

        String amountPost = request.getParameter("getItemAmount");
        double amount = Double.parseDouble(amountPost);

        String tax = request.getParameter("tax");

        try {
            String orderId = orderDao.add_order(user, method, amount);

            session.setAttribute("orderAmount", amount);
            session.setAttribute("orderID", orderId);
            session.setAttribute("tax", tax);

            request.getRequestDispatcher("orderdetail-list").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }

    // ../checkout_order (OrderServlet)
    // POST Method Guest/orderdetail-list.jsp
    private void Checkout_Order(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();

        String action = request.getParameter("pay");
        out.print("Action: " + action);

        Order order = new Order();
        order.setOrder_id(request.getParameter("orderid"));
        order.setMethod(request.getParameter("deliveryMethod"));

        if ("Pay Now".equalsIgnoreCase(action)) {
            try {
                orderDao.pay_order(order);
                orderDao.edit_delivery(order);

                response.sendRedirect("Guest/payment.jsp");
            } catch (SQLException e) {
                out.println("Database Error: " + e.getMessage());
            }
        } else if ("Cancel Order".equalsIgnoreCase(action)) {
            orderDao.cancel_order(order);
            response.sendRedirect("Guest/cancel.jsp");
        }
    }

    // ../edit_address (OrderServlet)
    // POST Method FROM Guest/orderdetail-list.jsp (../detail)
    private void Edit_Address(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();

        String address = request.getParameter("textAddress");
        out.print("Address: " + address);

        HttpSession session = request.getSession();
        User user = new User();
        user.setUser_id(3);
//        user.setUser_id((Integer) session.getAttribute("user_id"));
        out.print("User: " + user.getUser_id());

        try {
            String addr = orderDao.edit_address(user, address);
            session.setAttribute("address", addr);

            request.getRequestDispatcher("Guest/orderdetail-list.jsp").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
