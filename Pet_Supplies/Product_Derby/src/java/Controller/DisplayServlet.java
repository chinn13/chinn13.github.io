/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.DisplayDAO;
import Model.Cart;
import Model.Customer;
import Model.Order;
import Model.OrderDetail;
import Model.Pet;
import Model.Product;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DisplayServlet extends HttpServlet {

    DisplayDAO displayDao;

    public DisplayServlet() throws ClassNotFoundException {
        this.displayDao = new DisplayDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/all":
                    Product_List(request, response);
                    break;
                case "/product-detail":
                    Product_Detail(request, response);
                    break;
                case "/filter-list":
                    Filter_List(request, response);
                    break;
                case "/cart-list":
                    Cart_List(request, response);
                    break;
                //-------------------------------------------
                case "/delivery-status":
                    Delivery_Status(request, response);
                    break;
                case "/view-order":
                    View_Order(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DisplayServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.print("<h1>Post</h1>");
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/cust-info":
                    Cust_Info(request, response);
                    break;
                case "/orderdetail-list":
                    OrderDetail_List(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DisplayServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void View_Order(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        User user = new User();
        user.setUser_id((Integer) session.getAttribute("user_id"));

        try {
            List<OrderDetail> viewDetailList = displayDao.view_detail(user);

            out.println("<html><head><title>Order Details</title></head><body>");
            out.println("<h1>Order Details</h1>");
            out.println("<table border='1'><tr><th>Order ID</th><th>Order Amount</th><th>Order Date</th><th>Order Status</th><th>Product ID</th><th>Product Name</th><th>Product Price</th><th>Product Type</th><th>Order Detail Qty</th></tr>");

            HashMap<String, List<OrderDetail>> orderDetailsMap = new HashMap<>();

            for (OrderDetail orderDetail : viewDetailList) {
                String orderId = orderDetail.getOrder().getOrder_id();
                if (!orderDetailsMap.containsKey(orderId)) {
                    orderDetailsMap.put(orderId, new ArrayList<>());
                }
                orderDetailsMap.get(orderId).add(orderDetail);
            }

//            for (String orderId : orderDetailsMap.keySet()) {
//                List<OrderDetail> details = orderDetailsMap.get(orderId);
//                for (OrderDetail orderDetail : details) {
//                    out.println("<tr>");
//                    if (details.indexOf(orderDetail) == 0) {
//                        out.println("<td rowspan=\"" + details.size() + "\">" + orderId + "</td>");
//                        out.println("<td rowspan=\"" + details.size() + "\">" + details.get(0).getOrder().getAmount() + "</td>");
//                        out.println("<td rowspan=\"" + details.size() + "\">" + details.get(0).getOrder().getCreateDate() + "</td>");
//                        out.println("<td rowspan=\"" + details.size() + "\">" + details.get(0).getOrder().getStatus() + "</td>");
//                    }
//                    out.println("<td>" + orderDetail.getProduct().getId() + "</td>");
//                    out.println("<td>" + orderDetail.getProduct().getName() + "</td>");
//                    out.println("<td>" + orderDetail.getProduct().getPrice() + "</td>");
//                    out.println("<td>" + orderDetail.getProduct().getType() + "</td>");
//                    out.println("<td>" + orderDetail.getQty() + "</td>");
//                    out.println("</tr>");
//                }
//            }

            out.println("</table>");
            out.println("</body></html>");

            request.setAttribute("orderDetailsMap", orderDetailsMap);
            request.setAttribute("viewDetailList", viewDetailList);

            request.getRequestDispatcher("Guest/view-order.jsp").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }

// let user view their order's delivery status
    private void Delivery_Status(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        User user = new User();
        user.setUser_id((Integer) session.getAttribute("user_id"));

        Order order = new Order();
        order.setOrder_id("O779036");

        out.print(user.getUser_id() + "," + order.getOrder_id());

        try {
            int status = displayDao.delivery_status(user, order);

            request.setAttribute("status", status);
            out.print("Status:" + status);

//            request.getRequestDispatcher("Guest/orderdetail-list.jsp").forward(request, response);
//            request.getRequestDispatcher("orderdetail-list").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }
    //----------------------------------------------------------------------------------------------------

    // ../product-list (Servlet)
    // GET Method FROM Guest/home.jsp
    private void Product_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        PrintWriter out = response.getWriter();

        try {
            List<Product> productList = displayDao.product_list();
            List<Pet> petList = displayDao.pet_list();
            String type[][] = {{"Food", "Food"}, {"Grooming", "Grooming"}, {"Toys", "Toys"}, {"Bed", "Bed"}, {"Accessories", "Accessories"}};
            
            HttpSession session = request.getSession();

            session.setAttribute("petList", petList);
            session.setAttribute("typeList", type);
            session.setAttribute("productList", productList);

            out.print("yes");
            request.getRequestDispatcher("Guest/home.jsp").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }

    // ../product-detail (Servlet)
    // GET Method FROM Guest/home.jsp
    private void Product_Detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        PrintWriter out = response.getWriter();

        int prodID = Integer.parseInt(request.getParameter("product"));

        try {
            Product product = displayDao.product_detail(prodID);

            request.setAttribute("productDetail", product);

            request.getRequestDispatcher("Guest/product-detail.jsp?product=" + prodID).forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }

    // ../filter-list (Servlet)
    // GET Method FROM header.jsp
    private void Filter_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        PrintWriter out = response.getWriter();

        String typeArr[][] = {{"Food", "Food"}, {"Grooming", "Grooming"}, {"Toys", "Toys"}, {"Bed", "Bed"}, {"Accessories", "Accessories"}};

        String action = request.getParameter("action");

        String type = request.getParameter("type");

        try {
            List<Product> productList = displayDao.filter_list(action, type);

            for (Product p : productList) {
                out.print(p.getId());
            }
            request.setAttribute("typeArr", typeArr);
            request.setAttribute("action", action);
            request.setAttribute("productList", productList);
            request.getRequestDispatcher("Guest/filter-list.jsp").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }

    }

    // ../cart-list (Servlet)
    // GET Method FROM Guest/home.jsp
    private void Cart_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        PrintWriter out = response.getWriter();

        String option[] = {"", "Delivery", "Pickup"};

        HttpSession session = request.getSession();
        User user = new User();
        user.setUser_id((Integer) session.getAttribute("user_id"));

        try {
            List<Cart> cartList = displayDao.cart_list(user);

            request.setAttribute("cartList", cartList);
            request.setAttribute("option", option);

            request.getRequestDispatcher("Guest/cart-list.jsp").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }

    // ../orderDetail (DisplayServlet)
    // FORWARD FROM ../createOrder (CartServlet)
    private void OrderDetail_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String orderID = (String) session.getAttribute("orderID");
        String tax = (String) session.getAttribute("tax");

        try {
            Order order = displayDao.order_list(orderID);
            List<Product> orderList = displayDao.orderdetail_list(orderID);

            session.setAttribute("orderDetailList", orderList);
            session.setAttribute("orderList", order);

            request.getRequestDispatcher("cust-info").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }

    // ../cust (DisplayServlet)
    // FORWARD FROM ../orderDetail (DisplayServlet)
    private void Cust_Info(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        PrintWriter out = response.getWriter();

        String option[] = {"", "Delivery", "Pickup"};

        HttpSession session = request.getSession();
        User user = new User();
        user.setUser_id((Integer) session.getAttribute("user_id"));

        String tax = (String) session.getAttribute("tax");

        try {
            Customer customer = displayDao.cust_info(user);

            session.setAttribute("customer", customer);
            session.setAttribute("option", option);

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
